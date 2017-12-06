local obj2str

local function table2str(obj)
   local s = ""
   local n = 0
   for k,v in pairs(obj) do
      s = s .. obj2str(k) .. "=" .. obj2str(v) .. ","
      n = n+1
   end
   if n == #obj then
      s = ""
   end
   for i,v in ipairs(obj) do
      s = s .. obj2str(v) .. ","
      n = i
   end
   return "{" .. s .."}"
end

obj2str = function(obj)
   if type(obj) == "string" then
      return "'"..obj.."'"
   elseif type(obj) == "table" then
      return table2str(obj)
   else
      return tostring(obj)
   end
end


function log(...)
   local s = ""
   for i,v in ipairs({...}) do
      s = s .. '\t' .. obj2str(v)
   end
   print(s)
end
function saveTable(...)
   local s = ""
   for i,v in ipairs({...}) do
      s = s .. '\t' .. obj2str(v)
   end
   return s
end