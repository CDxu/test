--主入口函数。从这里开始lua逻辑
require 'mj/gStart'
require "FairyGUI"
require "Common/functions"
require 'tolua'
require 'utils'
function Main()					
	print("logic start")	
	gStart.start()
end

--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end