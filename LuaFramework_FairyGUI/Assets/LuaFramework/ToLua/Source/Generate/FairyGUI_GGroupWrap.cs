﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class FairyGUI_GGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FairyGUI.GGroup), typeof(FairyGUI.GObject));
		L.RegFunction("UpdateBounds", UpdateBounds);
		L.RegFunction("New", _CreateFairyGUI_GGroup);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateFairyGUI_GGroup(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				FairyGUI.GGroup obj = new FairyGUI.GGroup();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: FairyGUI.GGroup.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int UpdateBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			FairyGUI.GGroup obj = (FairyGUI.GGroup)ToLua.CheckObject<FairyGUI.GGroup>(L, 1);
			obj.UpdateBounds();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

