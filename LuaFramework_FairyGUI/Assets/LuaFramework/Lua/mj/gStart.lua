require 'mj/resloader'
gStart={}
function gStart.start()
	print('gStart.start()')
	resloader.loadAssetBundle(
    'test',
    function(bundle)
        gStart.createUI(bundle)
    end
    )
end

function gStart.createUI(bundle)
	UIPackage.AddPackage(bundle, bundle, "test")
	view = UIPackage.CreateObject('test', "main")
    view:MakeFullScreen();
    GRoot.inst:AddChild(view)
	local btn=view:GetChild('n0')
	print(btn)
	btn.onClick:Add(function()
		print('onCilck')
		print('onCilck')
	end)	
	print('createui end')
end