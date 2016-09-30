-- file         : setup.lua
-- Author       : peppercopia@gmail.com
-- Description  : Connects the NodeMCU Temphumi Sensor to the network, sets the
--                system time, summarizes the runtime configuration and then
--                starts the sensor app.
-- Version      : 1.1
-- Last Updated : 2016-09-30

local setup = {}

local function wifi_wait_ip()  
  if wifi.sta.getip()== nil then
    print("Still connecting to Network ...")
  else
    --Stop the wifi timer and turn off the LED.
    tmr.stop(1)
    led.stopBlink()
    -- We are connected!  Call the NTP server and set the devices time.
    timemanager.setDeviceTime()

    -- Send to the console a summary of the runtime configuration
    print("\n=================================================")
    print("Connected WiFi mode is	     : " .. wifi.getmode())
    print("Assigned IP is			: " .. wifi.sta.getip()) 
	print("MAC address is			: " .. wifi.ap.getmac())
	print("Device Id is				: " .. config.ID)
	print("MQTT Broker is			: " .. config.HOST)
	print("MQTT Destination Topic     : " .. config.SENDTOPIC)
	--print("MQTT Command Topic		: " .. config.CMDTOPIC)
	--print("MQTT Config Topic          : " .. config.CONFIGTOPIC)
    print("=================================================")

    --Start the sensor.
    app.start()
  end
end

function setup.start()
	--Main entry point.  Send command to connect to WiFi and set up a timer 
	--to wait for the connection to be established.
    wifi.setmode(wifi.STATION);
    wifi.sta.config(config.targetSSID, config.targetSSIDPassword)
    print("=========== NodeMCU Temp/Humi Sensor ============")
    print("Build v0.2")
    print("Connecting to the network...")
    led.lazyBlink()
    wifi.sta.connect()
    tmr.alarm(1, config.connectWait, 1, wifi_wait_ip)
end

return setup  
