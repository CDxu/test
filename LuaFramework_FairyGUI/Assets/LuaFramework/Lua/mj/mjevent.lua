local EventLib = require "eventlib"

local Event = {}
function Event:new()
   local o = {}
   o.events={}
   self.__index = self
   return setmetatable(o, self)
end
function Event:clear()
   for evt_name, evt in pairs(self.events) do
      evt:remove()
   end
   self.events={}
end
function Event:AddListener(event,handler)
   if not event or type(event) ~= "string" then
      return
   end
   if not handler or type(handler) ~= "function" then
      return
   end
   local events = self.events
   if not events[event] then
      events[event] = EventLib:new(event)
   end
   events[event]:connect(handler)
end

function Event:Brocast(event,...)
   local events = self.events
   if not events[event] then
   else
      events[event]:fire(...)
   end
end

function Event:RemoveListener(event,handler)
   local events = self.events
   if not events[event] then
   else
      events[event]:disconnect(handler)
   end
end

return Event
