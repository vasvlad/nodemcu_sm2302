-- file         : led.lua
-- Author       : peppercopia@gmail.com
-- Description  : Module to handle onboard red LED.
-- Version      : 1.0
-- Last Updated : 2016-09-25

local led = {}

function led.blink()
	--Timer to invert LED state.
    tmr.alarm(1,200,tmr.ALARM_AUTO,function()
        if gpio.read(config.ledRed) == gpio.LOW then
            gpio.write(config.ledRed, gpio.HIGH)
        else
            gpio.write(config.ledRed, gpio.LOW)
        end
    end)
end

function led.stopBlink()
    --Clear the blinking timer
    tmr.unregister(1)
    --Make sure the LED is in the off state
    gpio.write(config.ledRed, gpio.HIGH)

end

return led
