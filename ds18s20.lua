-- file         : ds18s20.lua 

local ds18s20 = {}

function ds18s20.getValue()
    pin = config.DS18S20_PIN 
    ow.setup(pin)
    count = 0
    repeat
      count = count + 1
      addr = ow.reset_search(pin)
      addr = ow.search(pin)
      tmr.wdclr()
    until (addr ~= nil) or (count > 100)
    if addr == nil then
       return "No more addresses."
    else
      print(addr:byte(1,8))
      crc = ow.crc8(string.sub(addr,1,7))
      if crc == addr:byte(8) then
        if (addr:byte(1) == 0x10) or (addr:byte(1) == 0x28) then
          print("Device is a DS18S20 family device.")
          ow.reset(pin)
          ow.select(pin, addr)
          ow.write(pin, 0x44, 1)
          tmr.delay(1000000)
          present = ow.reset(pin)
          ow.select(pin, addr)
          ow.write(pin,0xBE,1)
          print("P="..present)  
          data = nil
          data = string.char(ow.read(pin))
          for i = 1, 8 do
            data = data .. string.char(ow.read(pin))
          end
          print(data:byte(1,9))
          crc = ow.crc8(string.sub(data,1,8))
          print("CRC="..crc)
          if crc == data:byte(9) then
             t = (data:byte(1) + data:byte(2) * 256) * 625
             t1 = t / 10000
             t2 = t % 10000
             print("Temperature="..t1.."."..t2.."Centigrade")
             return t1
          end                   
          tmr.wdclr()
        else
          return "Device family is not recognized."
        end
      else
        return "CRC is not valid!"
      end
    end
end

return ds18s20 
