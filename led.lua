-- file         : led.lua
-- Author       : peppercopia@gmail.com
-- Description  : Module to handle onboard red LED.
-- Version      : 1.1
-- Last Updated : 2016-09-30

local led = {}

function led.blink()
    --Clear the other timer just in case
    tmr.unregister(2)
    
	--Timer to invert LED state.
    tmr.alarm(3,200,tmr.ALARM_AUTO,function()
        if gpio.read(config.ledRed) == gpio.LOW then
            gpio.write(config.ledRed, gpio.HIGH)
        else
            gpio.write(config.ledRed, gpio.LOW)
        end
    end)
end

function led.lazyBlink()
    --Clear the other timer just in case
    tmr.unregister(3)
    
    --Timer to invert LED state.
    tmr.alarm(2,600,tmr.ALARM_AUTO,function()
        if gpio.read(config.ledRed) == gpio.LOW then
            gpio.write(config.ledRed, gpio.HIGH)
        else
            gpio.write(config.ledRed, gpio.LOW)
        end
    end)
end

function led.stopBlink()
    --Clear the blinking timer
    tmr.unregister(3)
    tmr.unregister(2)
    --Make sure the LED is in the off state
    gpio.write(config.ledRed, gpio.HIGH)
end

return led
