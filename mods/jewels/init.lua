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
      name = new_toolname, -- the new name of the tool
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

   if not jewels.registered_jewels[toolname] then
      jewels.registered_jewels[toolname] = {}
   end
   table.insert(jewels.registered_jewels[toolname], data)

   local tooldef = minetest.deserialize(minetest.serialize(minetest.registered_tools[toolname]))

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

function jewels.can_jewel(toolname)
   for name, _ in pairs(jewels.registered_jewels) do
      if name == toolname then
	 return true
      end
   end

   return false
end

function jewels.get_jeweled(toolname)
   for name, jables in pairs(jewels.registered_jewels) do
      if name == toolname then
	 return util.choice_element(jables)
      end
   end
end

minetest.register_craftitem(
   "jewels:jewel",
   {
      description = "Jewel",
      inventory_image = "jewels_jewel.png",
      stack_max = 10
   })

minetest.register_node(
   "jewels:bench",
   {
      description = "Jewelers Workbench",
      tiles ={"jewels_bench_top.png", "jewels_bench_bottom.png", "jewels_bench_sides.png"},
      paramtype2 = "facedir",
      groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
      legacy_facedir_simple = true,
      is_ground_content = false,
      sounds = default.node_sound_wood_defaults(),
      on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("jewels_bench"))
			meta:set_string("infotext", "Jewelers Workbench")

			local inv = meta:get_inventory()
			inv:set_size("main", 1)
		     end,
      can_dig = function(pos, player)
		   local meta = minetest.get_meta(pos)
		   local inv = meta:get_inventory()

		   return inv:is_empty("main")
		end,
      on_punch = function(pos, node, player, pointed_thing)
		    local itemstack = player:get_wielded_item()
		    
		    if itemstack:get_name() == "jewels:jewel" then
		       local meta = minetest.get_meta(pos)
		       local inv = meta:get_inventory()

		       local itemname = inv:get_stack("main", 1):get_name()

		       if jewels.can_jewel(itemname) then
			  inv:set_stack("main", 1, ItemStack(jewels.get_jeweled(itemname)))

			  itemstack:take_item()
		       end		       
		    end

		    player:set_wielded_item(itemstack)
		end,
   })

minetest.register_craft(
   {
      output = "jewels:bench",
      recipe = {
	 {"group:planks", "jewels:jewel", "group:planks"},
	 {"default:ingot_carbonsteel", "group:planks", "default:ingot_carbonsteel"},
	 {"group:planks", "group:planks", "group:planks"}
      }
   })

local form_bench = default.ui.get_page("core_2part")
form_bench = form_bench .. "list[current_name;main;2.25,1.75;1,1;]"
form_bench = form_bench .. "listring[current_name;main]"
form_bench = form_bench .. default.ui.get_itemslot_bg(2.25, 1.75, 1, 1)

form_bench = form_bench .. "label[3.25,1.75;1. Place unjeweled tool here]"
form_bench = form_bench .. "label[3.25,2.25;2. Hold a jewel and punch the bench]"

form_bench = form_bench .. "list[current_player;main;0.25,4.75;8,4;]"
form_bench = form_bench .. "listring[current_player;main]"
form_bench = form_bench .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_bench = form_bench .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)
default.ui.register_page("jewels_bench", form_bench)

dofile(minetest.get_modpath("jewels").."/jewels.lua")

default.log("mod:jewels", "loaded")