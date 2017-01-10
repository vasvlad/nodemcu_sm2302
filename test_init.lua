-- file         : init.lua
-- Author       : peppercopia@gmail.com
-- Description  : The starting module for the NodeMCU TempHumi Sensor.
-- Version      : 1.0
-- Last Updated : 2016-09-25

-- Load configuration and setup modules
config = require("config")
setup = require("setup")

-- Include the components used
sensor = require("am2302")
sensor2 = require("ds18s20")
led = require("led")
timemanager = require("timemanager")

-- Load the sensor app module
app = require("app_temphumi")

--Start up the application
setup.start()




