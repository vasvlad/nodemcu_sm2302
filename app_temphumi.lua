-- file         : app_temphumi.lua
-- Author       : peppercopia@gmail.com
-- Description  : Main application code to publish sensor telemetry on
--              : the configured MQTT topic.
-- Version      : 1.0
-- Last Updated : 2016-09-24

local app = {}  
m = nil

-- Function to emit the sensors readings
local function emit_event()
    temp, humi = sensor.getValues()	
    m:publish(config.SENDTOPIC.."temperature", temp, 0, 0)
    m:publish(config.SENDTOPIC.."humidity", humi,0,0)
    temp2 = sensor2.getValue()
    m:publish(config.SENDTOPIC.."temperature2", temp2, 0, 0)
end

--Listener for subscribed messages.  Not implemented, this is where
--the functions to update configuration based on incoming command
--messages will go.
local function cmd_listener() 
    m:subscribe(config.CMDTOPIC,0,function(conn)
        --print("Dynamic configuation not yet implemented.")
    end)
end

--Connect to MQTT
local function mqtt_start()  
    m = mqtt.Client(config.ID, 120, config.USERNAME, config.PASSWD)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data)
      if data ~= nil then
        print(topic .. ": " .. data)
        -- do something, we have received a message
      end
    end)
    -- Connect to broker
    m:connect(config.HOST, config.PORT, 0, 1, function(con) 
		--You can subscribe to topics by uncommenting this and
		--implementing the function.
		
		--cmd_listener()
       
	   -- Set up a time to emit an event each interval defined in the config.
        tmr.stop(6)
        tmr.alarm(6, config.PUBINTERVAL, 1, emit_event)
    end) 

end

function app.start()  
  --Main entry point.  Call the local mqtt_start function to really start.
  mqtt_start()
end

return app  
