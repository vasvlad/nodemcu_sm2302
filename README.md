# NodeMCU MQTT-Enabled AM2302 Temp/Humidity Sensor

A NodeMCU application that publishes a timestamped JSON temperature/humidity event to an MQTT topic on a configured interval. 

#GUIDE IS A WORK IN PROGRESS

##Installation

These instructions assume you have a new NodeMCU that also requires firmware to be installed and you already have an MQTT up and running.  If you need help installing MQTT there are many tutorials on the internet to help.  For my project I used the free MQTT server Mosquitto on an old laptop running Lubuntu.  When I get a chance I will do a tutorial of that if people are interested.

###Step 1 - Install the Firmware

###Step 2 - Load the application to NodeMCU 
Update config.lua with your own configuration for Wifi, MQTT Server settings etc.  Write the files to a blank NodeMCU.

###Step 3 - Test it out

IF you subscribe to the topic on your MQTT server you should see the following event published (when the interval is up, be patient!):

```
{
  "temperature": 24.6,
  "eventLocation": "domain/location",
  "humidity": 3.6,
  "eventTime": "2016-09-29T04:17:47+00:00",
  "eventType": "temphumi",
  "sensorID": 1547899
}
```

##Hardware

It's a pretty simple first project, I used it to learn my way around Lua.  Hardware wiring photos soon.


##Firmware build

The NodeMCU firmware version that the code was built on is included in the /firmare folder.  It is a FLOAT build of the following 12 modules: 

<b>cjson dht file gpio mqtt net node rtctime sntp tmr uart wifi</b>

Provided by the good folks over at https://nodemcu-build.com/
