-- file         : init.lua
-- Author       : peppercopia@gmail.com
-- Description  : The starting module for the NodeMCU TempHumi Sensor.
-- Version      : 1.0.1
-- Last Updated : 2016-09-30

--timers used in application
--tmr(1) - WiFi Connection Checker
--tmr(2) - Slow blink LED
--tmr(3) - Blink LED
--tmr(6) - MQTT Poll Interval Publishing

-- Load configuration and setup modules
config = require("config")
setup = require("setup")

-- Include the components used
sensor = require("am2302")
led = require("led")
timemanager = require("timemanager")

-- Load the sensor app module
app = require("app_temphumi")

--Start up the application
setup.start()
