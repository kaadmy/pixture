--
-- Jewels mod
-- By Kaadmy
--

jewels = {}
jewels.registered_jewels = {}

local function p(i)
   if i >= 0 then i = "+" .. i end
   return i
end

function jewels.register_jewel(toolname, new_toolname, def)
   -- registers a new tool with different stats

   local data = {
      overlay = def.overlay or "jewels_jeweled_handle.png", -- overlay image
      stats = {
	 digspeed = def.stats.digspeed, -- negative digs faster
	 maxlevel = def.stats.maxlevel, -- positive digs higher levels
	 maxdrop= def.stats.maxdrop, -- positive increases max drop level
	 uses = def.stats.uses, -- positive increases uses
	 fleshy = def.stats.fleshy, -- positive increases fleshy damage
	 range = def.stats.range, -- positive increases reach distance with tool
      }
   }

   jewels.registered_jewels[toolname] = data

   local tooldef = minetest.registered_tools[toolname]

   local new_tool_invimage = ""
   if tooldef.inventory_image then
      new_tool_invimage = tooldef.inventory_image .. "^" .. data.overlay
   end

   local new_tool_wieldimage = ""
   if tooldef.wield_image then
      new_tool_wieldimage = tooldef.wield_image .. "^" .. data.overlay
   end

   local new_tooldef = tooldef   
   local desc = new_tooldef.description or ""

   desc = "Jeweled " .. desc

   new_tooldef.inventory_image = new_tool_invimage
   new_tooldef.wield_image = new_tool_wieldimage

   if data.stats.range and new_tooldef.range then
      new_tooldef.range = new_tooldef.range + data.stats.range
      desc = desc .. "\nRange: " .. p(data.stats.range)
   end

   if new_tooldef.tool_capabilities then
      if data.stats.maxdrop and new_tooldef.tool_capabilities.max_drop_level then
	 new_tooldef.tool_capabilities.max_drop_level = new_tooldef.tool_capabilities.max_drop_level + data.stats.maxdrop
	 desc = desc .. "\nDrop level: " .. p(data.stats.maxdrop)
      end

      if data.stats.digspeed then
	 for group, cap in pairs(new_tooldef.tool_capabilities.groupcaps) do
	    for i, _ in ipairs(cap.times) do
	       cap.times[i] = cap.times[i] + data.stats.digspeed
	    end

	    if data.stats.maxlevel and cap.maxlevel then
	       cap.maxlevel = cap.maxlevel + data.stats.maxlevel
	    end

	    if data.stats.uses and cap.uses then
	       cap.uses = cap.uses + data.stats.uses
	    end
	 end

	 desc = desc .. "\nDig time: " .. p(data.stats.digspeed) .. " seconds"
      end

      if data.stats.uses then
	 desc = desc .. "\nUses: " .. p(data.stats.uses)
      end
      if data.stats.maxlevel then
	 desc = desc .. "\nDig level: " .. p(data.stats.maxlevel)
      end

      if data.stats.fleshy and new_tooldef.tool_capabilities.damage_groups and new_tooldef.tool_capabilities.damage_groups.fleshy then
	 new_tooldef.tool_capabilities.damage_groups.fleshy = new_tooldef.tool_capabilities.damage_groups.fleshy + data.stats.fleshy
	 desc = desc .. "\nDamage: " .. p(data.stats.fleshy)
      end
   end

   new_tooldef.description = desc   

   minetest.register_tool(new_toolname, new_tooldef)
end

minetest.register_craftitem(
   "jewels:jewel",
   {
      description = "Jewel",
      inventory_image = "jewels_jewel.png",
      stack_max = 10
   })

dofile(minetest.get_modpath("jewels").."/jewels.lua")