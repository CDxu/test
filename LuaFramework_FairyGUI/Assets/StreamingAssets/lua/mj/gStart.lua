
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
end