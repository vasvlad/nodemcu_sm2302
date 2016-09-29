-- file         : timemanager.lua
-- Author       : peppercopia@gmail.com
-- Description  : Manages setting and retrieving the device internal time.
-- Version      : 1.0
-- Last Updated : 2016-09-25

local timemanager = {}

    -- This function sets the time of the device by connecting to the configured
    -- NTP (time) server.
	function timemanager.setDeviceTime()

		--Call the NTP server and deal with the result
		sntp.sync(config.NTPSERVER,
		
		function(sec,usec,server)
            print('The time syncronization with ' .. config.NTPSERVER .. ' was successful.')
            print('Device UTC time is ' .. timemanager.getDeviceTime())
		end,
		
		function(errcode)
       
			--Time sync failed, print the reason to the logging queue
            local errorMessage = {}
            errorMessage[1] = "\"DNS lookup failed\""
            errorMessage[2] = "\"Memory allocation failure\""
            errorMessage[3] = "\"UDP send failed\""
            errorMessage[4] = "\"Timeout, no NTP response received\""			
			
			print('Synchronizing time with ' .. config.NTPSERVER .. ' failed with reason: ' .. errorMessage[errcode] .. '.')
            --Clean up
            local errorMessage = {}
            
		end
	)
    
    -- Function provides the device time in a formatted string.
	function timemanager.getDeviceTime()
	
		--Returns a formatted date/time string
		tm = rtctime.epoch2cal(rtctime.get())
		return (string.format("%04d-%02d-%02dT%02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]).."+00:00")

	end

end

return timemanager
