from pynq import Overlay
from pynq.lib import LED, Switch, Button
import time

if __name__ == "__main__":
   base = Overlay("system_wrapper.xsa")
   led0 = base.u1_led_gpio[0]

   while(True):
       led0.toggle()
       time.sleep(0.5)

