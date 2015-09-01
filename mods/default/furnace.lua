--
-- Furnace
--

function default.furnace_active_formspec(percent, item_percent)
   local form = default.ui.get_page("core_2part")
   form = form .. "list[current_player;main;0.25,4.75;8,4;]"
   form = form .. "listring[current_player;main]"
   form = form .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
   form = form .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

   form = form .. "list[current_name;src;2.25,0.75;1,1;]"
   form = form .. "listring[current_name;src]"
   form = form .. default.ui.get_itemslot_bg(2.25, 0.75, 1, 1)

   form = form .. "list[current_name;fuel;2.25,2.75;1,1;]"
   form = form .. default.ui.get_itemslot_bg(2.25, 2.75, 1, 1)

   form = form .. "list[current_name;dst;4.25,1.25;2,2;]"
   form = form .. "listring[current_name;dst]"
   form = form .. default.ui.get_hotbar_itemslot_bg(4.25, 1.25, 2, 2)

   form = form .. "image[2.25,1.75;1,1;ui_fire_bg.png^[lowpart:"
   form = form .. (100-percent) .. ":ui_fire.png]"
   form = form .. "image[3.25,1.75;1,1;ui_arrow_bg.png^[lowpart:"
   form = form .. (item_percent) .. ":ui_arrow.png^[transformR270]"

   return form
end

local form_furnace = default.ui.get_page("core_2part")
form_furnace = form_furnace .. "list[current_player;main;0.25,4.75;8,4;]"
form_furnace = form_furnace .. "listring[current_player;main]"
form_furnace = form_furnace .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_furnace = form_furnace .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

form_furnace = form_furnace .. "list[current_name;src;2.25,0.75;1,1;]"
form_furnace = form_furnace .. "listring[current_name;src]"
form_furnace = form_furnace .. default.ui.get_itemslot_bg(2.25, 0.75, 1, 1)

form_furnace = form_furnace .. "list[current_name;fuel;2.25,2.75;1,1;]"
form_furnace = form_furnace .. default.ui.get_itemslot_bg(2.25, 2.75, 1, 1)

form_furnace = form_furnace .. "list[current_name;dst;4.25,1.25;2,2;]"
form_furnace = form_furnace .. "listring[current_name;dst]"
form_furnace = form_furnace .. default.ui.get_hotbar_itemslot_bg(4.25, 1.25, 2, 2)

form_furnace = form_furnace .. "image[2.25,1.75;1,1;ui_fire_bg.png]"
form_furnace = form_furnace .. "image[3.25,1.75;1,1;ui_arrow_bg.png^[transformR270]"

default.ui.register_page("default_furnace_inactive", form_furnace)

minetest.register_node(
   "default:furnace",
   {
      description = "Furnace",
      tiles ={"default_furnace_top.png", "default_furnace_top.png", "default_furnace_sides.png",
	      "default_furnace_sides.png", "default_furnace_sides.png", "default_furnace_front.png"},
      paramtype2 = "facedir",
      groups = {cracky = 2},
      legacy_facedir_simple = true,
      is_ground_content = false,
      sounds = default.node_sound_stone_defaults(),
      on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("default_furnace_inactive"))
			meta:set_string("infotext", "Furnace")

			local inv = meta:get_inventory()
			inv:set_size("fuel", 1)
			inv:set_size("src", 1)
			inv:set_size("dst", 4)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("fuel") then
		      return false
		   elseif not inv:is_empty("dst") then
		      return false
		   elseif not inv:is_empty("src") then
		      return false
		   end
		   return true
		end,
   })

minetest.register_node(
   "default:furnace_active",
   {
      description = "Furnace",
      tiles ={"default_furnace_top.png", "default_furnace_top.png", "default_furnace_sides.png",
	      "default_furnace_sides.png", "default_furnace_sides.png", "default_furnace_front.png^default_furnace_flame.png"},
      paramtype2 = "facedir",
      light_source = 8,
      drop = "default:furnace",
      groups = {cracky = 2},
      legacy_facedir_simple = true,
      is_ground_content = false,
      sounds = default.node_sound_stone_defaults(),
      on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("default_furnace_inactive"))
			meta:set_string("infotext", "Furnace");

			local inv = meta:get_inventory()
			inv:set_size("fuel", 1)
			inv:set_size("src", 1)
			inv:set_size("dst", 4)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.get_meta(pos);
		   local inv = meta:get_inventory()
		   if not inv:is_empty("fuel") then
		      return false
		   elseif not inv:is_empty("dst") then
		      return false
		   elseif not inv:is_empty("src") then
		      return false
		   end
		   return true
		end,
   })

function swap_node(pos, name)
   local node = minetest.get_node(pos)
   if node.name == name then
      return
   end
   node.name = name
   minetest.swap_node(pos, node)
end

minetest.register_abm(
   {
      nodenames = {"default:furnace", "default:furnace_active"},
      interval = 1.0,
      chance = 1,
      action = function(pos, node, active_object_count, active_object_count_wider)
		  --
		  -- Initialize metadata
		  --
		  local meta = minetest.get_meta(pos)
		  local fuel_time = meta:get_float("fuel_time") or 0
		  local src_time = meta:get_float("src_time") or 0
		  local fuel_totaltime = meta:get_float("fuel_totaltime") or 0
		  
		  --
		  -- Initialize inventory
		  --
		  local inv = meta:get_inventory()
		  for listname, size in pairs(
		     {
			src = 1,
			fuel = 1,
			dst = 4,
		     }) do
		     if inv:get_size(listname) ~= size then
			inv:set_size(listname, size)
		     end
		  end
		  local srclist = inv:get_list("src")
		  local fuellist = inv:get_list("fuel")
		  local dstlist = inv:get_list("dst")
		  
		  --
		  -- Cooking
		  --
		  
		  -- Check if we have cookable content
		  local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		  local cookable = true
		  
		  if cooked.time == 0 then
		     cookable = false
		  end
		  
		  -- Check if we have enough fuel to burn
		  if fuel_time < fuel_totaltime then
		     -- The furnace is currently active and has enough fuel
		     fuel_time = fuel_time + 1
		     
		     -- If there is a cookable item then check if it is ready yet
		     if cookable then
			src_time = src_time + 1
			if src_time >= cooked.time then
			   -- Place result in dst list if possible
			   if inv:room_for_item("dst", cooked.item) then
			      inv:add_item("dst", cooked.item)
			      inv:set_stack("src", 1, aftercooked.items[1])
			      src_time = 0
			   end
			end
		     end
		  else
		     -- Furnace ran out of fuel
		     if cookable then
			-- We need to get new fuel
			local fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
			
			if fuel.time == 0 then
			   -- No valid fuel in fuel list
			   fuel_totaltime = 0
			   fuel_time = 0
			   src_time = 0
			else
			   -- Take fuel from fuel list
			   inv:set_stack("fuel", 1, afterfuel.items[1])
			   
			   fuel_totaltime = fuel.time
			   fuel_time = 0
			   
			end
		     else
			-- We don't need to get new fuel since there is no cookable item
			fuel_totaltime = 0
			fuel_time = 0
			src_time = 0
		     end
		  end
		  
		  --
		  -- Update formspec, infotext and node
		  --
		  local formspec = default.ui.get_page("default_furnace_inactive")
		  local item_state = ""
		  local item_percent = 0
		  if cookable then
		     item_percent =  math.floor(src_time / cooked.time * 100)
		     item_state = item_percent .. "%"
		  else
		     if srclist[1]:is_empty() then
			item_state = "Empty"
		     else
			item_state = "Not cookable"
		     end
		  end
		  
		  local fuel_state = "Empty"
		  local active = "inactive "
		  if fuel_time <= fuel_totaltime and fuel_totaltime ~= 0 then
		     active = "active "
		     local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		     fuel_state = fuel_percent .. "%"
		     formspec = default.furnace_active_formspec(fuel_percent, item_percent)
		     swap_node(pos, "default:furnace_active")
		  else
		     if not fuellist[1]:is_empty() then
			fuel_state = "0%"
		     end
		     swap_node(pos, "default:furnace")
		  end
		  
		  local infotext =  "Furnace " .. active .. "(Item: " .. item_state .. "; Fuel: " .. fuel_state .. ")"
		  
		  --
		  -- Set meta values
		  --
		  meta:set_float("fuel_totaltime", fuel_totaltime)
		  meta:set_float("fuel_time", fuel_time)
		  meta:set_float("src_time", src_time)
		  meta:set_string("formspec", formspec)
		  meta:set_string("infotext", infotext)
	       end,
   })

default.log("furnace", "loaded")