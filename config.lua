-- file : config.lua
-- author : peppercopia@gmail.com
-- description : Configuration settings for the NodeMCU TempHumi Sensor.

-- If you are not compiling these files you should probably remove the comments
-- to save space on the device as well.  Recommended to compile though!

--Start fresh with the config module
local config = {}

--Device
config.ID = node.chipid() 						-- Stores the unique ID of the NodeMCU.  Will be used to identifiy individual sensors
config.DOMAIN = "/devices"                          -- The area of scope, like "home" or "cottage"
config.LOCATION = "esp8266/mobile" 					    -- The LOCATION of the nodeMCU sensor in the domain, keep the name short and avoid spaces, ie. "garage" or "mainbedroom"
config.ledRed = 0                               -- gpio16

-- WiFi Configuration
config.targetSSID = "MYWIFI" 					-- The name that your wifi is broadcasting
config.targetSSIDPassword = "PASSWORD" 			-- Replace with your wifi password
config.connectWait = 3000 						-- How long to wait for the wifi connection to establish before checking the status again

-- MQTT Configuration
config.HOST = "10.0.0.33" 					-- IP address or hostname of your MQTT server 
config.PORT = 1883 								-- Standard MQTT port, don't change unless you know why you are changing it
config.USERNAME = ""					-- MQTT Username
config.PASSWD = ""							-- MQTT Password
config.SENDTOPIC = config.DOMAIN .. "/"         -- The topic that this nodeMCU will publish to.
                   .. config.LOCATION
                   .. "/" 
--config.CMDTOPIC = "sensor_cmd"				-- [NOT IMPLEMENTED YET] - The command topic.  Sensor will listen on this topic for instructions 
--config.CONFIGTOPIC = "sensor_config"			-- [NOT IMPLEMENTED YET] - The topic to listen to for an incoming sensor configuration
config.PUBINTERVAL = 90000						-- How often the sensor should publish its readings, in milliseconds. 
												-- Examples: 1000 = 1 sec, 60000 = 1 min, 360000 = 6 min (10 data points an hour)
-- NTP Time Configuration
config.NTPSERVER = "time.windows.com"           -- NTP server to connect to.  Default is the Windows default.

-- am2302.lua Configuration
config.AM2302_PIN = 4							-- datapin of the connected AM2302
-- ds18s20.lua Configuration
config.DS18S20_PIN = 3							-- datapin of the connected AM2302


return config  
