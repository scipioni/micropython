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
 
jupiter: jupyter_micropython_kernel/README.md

jupyter_micropython_kernel/README.md:
	lib/bin/pip install -U jupyter
	git clone https://github.com/goatchurchprime/jupyter_micropython_kernel.git
	lib/bin/pip install -e jupyter_micropython_kernel
	lib/bin/python -m jupyter_micropython_kernel.install
	make widgets
	make turtle

.PHONY: virtualenv
virtualenv: lib/bin/activate

lib/bin/activate:
	python3 -mvenv lib
	lib/bin/pip install -U pip wheel
	lib/bin/pip install esptool adafruit-ampy

.PHONY: bootstrap
bootstrap: virtualenv jupiter

widgets:
	pip install ipywidgets
	jupyter nbextension enable --py widgetsnbextension
	pip install https://github.com/takluyver/mobilechelonian/archive/master.zip

turtle:
	pip install https://github.com/takluyver/mobilechelonian/archive/master.zip
