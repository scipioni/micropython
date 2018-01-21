from machine import Pin
from time import sleep

# GPIO16 (D0) is the internal LED for NodeMCU
led = Pin(16, Pin.OUT)

def blink(count=10):
    for i in range(count):
        led.value(not led.value())
        sleep(0.1)

def do_connect_wifi(ssid='ranch', password=''):
    import network
    sta_if = network.WLAN(network.STA_IF)
    if not sta_if.isconnected():
        print('connecting to network...')
        sta_if.active(True)
        sta_if.connect(ssid, password)
        while not sta_if.isconnected():
            pass
    print('network config:', sta_if.ifconfig())
    from ntptime import settime
    settime()
    blink()
        

