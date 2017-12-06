local mjEvent = require('mj/mjevent')
local loaderEvent = mjEvent:new()
local bundles = {}
local function loadAssetBundleAsync(name)
   print('want to load '..name)
   print(bundles[name])
   if bundles[name] then
      if bundles[name] ~= 'loading' then
         print('bundle has loaded '..name)
         loaderEvent:Brocast(name, bundles[name])
      else
         print('bundle is loading '..name)
         print(bundles[name])
      end
      return
   end
   print('start load bundle '..name)
   bundles[name] = "loading"
   coroutine.start(function()
         local url = UnityEngine.Application.dataPath..'/StreamingAssets/'.. name .. ".unity3d"--LuaFramework.Util.DataPath .. name .. ".unity3d"
		 print(url)
         if UnityEngine.AssetBundleCreateRequest then
            local req = UnityEngine.AssetBundle.LoadFromFileAsync(url)
            while not req.isDone do
               coroutine.wait(0.5)
            end
            bundles[name]=req.assetBundle
         else
            local www = UnityEngine.WWW('file://'..url)
            coroutine.www(www)
            bundles[name]=www.assetBundle
         end
         loaderEvent:Brocast(name, bundles[name])
   end)
end
resloader = {}
function resloader.loadAssetBundle(bundle_name, callback)
   if callback then
      local event_callback = function(bundle)
         print('event_callback '..bundle_name)
         loaderEvent:RemoveListener(bundle_name, event_callback)
         callback(bundle)
      end
      loaderEvent:AddListener(bundle_name, event_callback)
   end
   loadAssetBundleAsync(bundle_name)
end
function resloader.unloadAssetBundle(bundle_name)
   local bundle = bundles[bundle_name]
   if bundle then
      bundles[bundle_name] = nil
      bundle:Unload(true)
   end
end
