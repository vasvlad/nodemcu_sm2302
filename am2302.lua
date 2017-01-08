-- file         : am2302.lua
-- Author       : peppercopia@gmail.com
-- Description  : Reads telemetry from an AM2302 (DHT22) sensor and returns a JSON
--                event message.
-- Version      : 1.1
-- Last Updated : 2016-09-30

local am2302 = {}

function am2302.getValues()
    
    --Define the sensorEvent Lua table.
    --Get the telemetry from the sensor and set collection time
	status, temp, humi, temp_dec, humi_dec = dht.read(config.AM2302_PIN)
--    sensorEvent.eventTime = timemanager.getDeviceTime()

    --Evaluate sensor response and update sensorEvent table
	if status == dht.OK then
		--Sensor data ok, update sensorEvent Lua table with sensor readings.
        --Print the readings to the console
		--Uncomment for local development/testing
        print("")   
        print("========= Temperature / Humidity Event =========")
        print ("temperatura", temp)
        print ("humidity", humi)
        print("================================================")
 
        return temp, humi
       
	elseif status == dht.ERROR_CHECKSUM then
        --Update sensorEvent Lua table with error description.
        return "Checksum Error!", "Checksum Error!"
	
	elseif status == dht.ERROR_TIMEOUT then
        --Update sensorEvent Lua table with error description.
        return "Sensor Timeout!", "Sensor Timeout!"
	end
    
end

return am2302
