FIRMWARE=esp8266-20171101-v1.9.3.bin


format:
erase:
	esptool.py --port /dev/ttyUSB0 erase_flash

$(FIRMWARE):
	wget -c http://micropython.org/resources/firmware/$(FIRMWARE)

firmware: $(FIRMWARE)
	esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect 0 $(FIRMWARE)

.PHONY: upload
upload: boot.py main.py utils.py configuration.py 
	ampy -p /dev/ttyUSB0 put utils.py /utils.py
	ampy -p /dev/ttyUSB0 put boot.py /boot.py
	ampy -p /dev/ttyUSB0 put main.py /main.py
	ampy -p /dev/ttyUSB0 put configuration.py /configuration.py

utils.py:

boot.py:

main.py:

configuration.py:

reboot:
	ampy -p /dev/ttyUSB0 reset
 
jupiter_build: jupyter_micropython_kernel/README.md

jupyter_micropython_kernel/README.md:
	git clone https://github.com/goatchurchprime/jupyter_micropython_kernel.git
	lib/bin/pip install -e jupyter_micropython_kernel
	lib/bin/python -m jupyter_micropython_kernel.install

.PHONY: virtualenv
virtualenv: lib/bin/activate

lib/bin/activate:
	python3 -mvenv lib
	lib/bin/pip install esptool adafruit-ampy

.PHONY: bootstrap
bootstrap: virtualenv jupiter_build
