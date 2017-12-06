local utils = { }
function utils.table_index(t, o)
    for i, v in ipairs(t) do
        if v == o then
            return i
        end
    end
    return -1
end
function utils.table_remove(t, x, n)
    local j = 0
    for i = #t, 1, -1 do
        if t[i] == x then
            table.remove(t, i)
            j = j + 1
            if j >= n then
                return
            end
        end
    end
end
function utils.table_maxn(t)

    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end

    return count;
end
function utils.table_maxnIndex(t)

    local mn = 0
    for k, v in pairs(t) do
        if mn < v then
            mn = v
        end
    end

    return utils.table_index(t, mn);
end
-- 拷贝新表
function utils.deepcopy(object)
    local lookup_table = { }
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then

            return lookup_table[object]
        end
        -- if
        local new_table = { }
        lookup_table[object] = new_table


        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end    
function utils.Screenshot()

    -- coroutine.start( function()
    local texture2D = UnityEngine.Texture2D(UnityEngine.Screen.width, UnityEngine.Screen.height, UnityEngine.TextureFormat.RGB24, true);
    texture2D:ReadPixels(UnityEngine.Rect(0, 0, UnityEngine.Screen.width, UnityEngine.Screen.height), 0, 0);
    texture2D:Apply();
    local time = os.date("%m-%d-%s");
    local filePath = UnityEngine.Application.persistentDataPath .. "/" .. time .. ".png";
    System.IO.File:WriteAllBytes(filePath, texture2D:EncodeToPNG());
    -- end )
end

function utils.getAsyncImage(url)
    local www = UnityEngine.WWW(url)
    coroutine.www(www)
    local pageData = www.bytes
    local tex2D = UnityEngine.Texture2D(100, 100);
    tex2D:LoadImage(pageData);
    local image = NTexture(tex2D);
    return image;
end
local function forceS(url)
    return string.gsub(url, "^[hH][tT][tT][pP]:", "https:")
end
function utils.asyncImage(imageView, url)
    coroutine.start( function()
        local s = forceS(url)
        print('force S from ' .. url .. ' to ' .. s)
        local www = UnityEngine.WWW(s)
        coroutine.www(www)
        if not www.error then
            local texture2D = UnityEngine.Texture2D(100, 100);
            texture2D:LoadImage(www.bytes)
            imageView.texture = NTexture(texture2D)
        else
            print(www.error)
        end
    end )
end
local function loadAssetBundlesAsync(bundle_names, callback)
    coroutine.start( function()
        local bundles = { }
        for i, name in ipairs(bundle_names) do
            print("load bundle :" .. name)
            local url = LuaFramework.Util.DataPath .. name .. ".unity3d"
            local req = UnityEngine.AssetBundle.LoadFromFileAsync(url)
            while not req.isDone do
                coroutine.wait(0.5)
            end
            bundles[name] = req.assetBundle
        end
        callback(bundles)
    end )
end
local function loadAssetBundlesWWW(bundle_names, callback)
    coroutine.start( function()
        local bundles = { }
        for i, name in ipairs(bundle_names) do
            local url = "file://" .. LuaFramework.Util.DataPath .. name .. ".unity3d"
            local www = UnityEngine.WWW(url)
            coroutine.www(www)
            bundles[name] = www.assetBundle
        end
        callback(bundles)
    end )
end
function utils.loadAssetBundles(bundle_names, callback)
    if UnityEngine.AssetBundleCreateRequest then
        loadAssetBundlesAsync(bundle_names, callback)
    else
        loadAssetBundlesWWW(bundle_names, callback)
    end
end
function utils.distance(x)
    if x < 10 then
        return string.format('%.1f米', x)
    elseif x < 1000 then
        return string.format('%.0f米', x)
    elseif x < 10000 then
        return string.format('%.2f公里', x / 1000)
    elseif x < 50000 then
        return string.format('%.0f公里', x / 1000)
    else
        return '50公里以上'
    end
end

-- <summary>
-- 重新设置Shader
-- </summary>
-- <param name="obj"></param>
function utils.ResetShader(object)
    local materialsmap = { }
    if object ~= nil then
        local renderers = object:GetComponentsInChildren(typeof(UnityEngine.Renderer));
        for i=0, renderers.Length-1 ,1 do
            local materials = renderers[i].materials;
            for i=0, materials.Length-1, 1 do
                local material = materials[i]
                table.insert(materialsmap, material)
            end
        end
        for i = 1, utils.table_maxn(materialsmap), 1 do
            material = materialsmap[i];
            if material ~= nil then
                
            end            
            local shadername = material.shader.name;
            local newShader = UnityEngine.Shader.Find(shadername);
            if newShader ~= null then
                material.shader = newShader;
            end
        end
    end
end

return utils
