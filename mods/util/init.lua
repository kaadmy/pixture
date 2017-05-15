--
-- Utility functions
--

util = {}

function util.sort_pos(pos1, pos2)
   -- function taken from worldedit
   -- ensure that pos2 has greater coords than pos1
   pos1 = {x=pos1.x, y=pos1.y, z=pos1.z}
   pos2 = {x=pos2.x, y=pos2.y, z=pos2.z}
   if pos1.x > pos2.x then
      pos2.x, pos1.x = pos1.x, pos2.x
   end
   if pos1.y > pos2.y then
      pos2.y, pos1.y = pos1.y, pos2.y
   end
   if pos1.z > pos2.z then
      pos2.z, pos1.z = pos1.z, pos2.z
   end
   return pos1, pos2
end

function util.fixlight(pos1, pos2)
   -- function taken from worldedit
   -- repair most lighting in a block
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   --make area stay loaded

   local manip = minetest.get_voxel_manip()
   manip:read_from_map(pos1, pos2)

   local nodes = minetest.find_nodes_in_area(pos1, pos2, "air")
   local dig_node = minetest.dig_node
   for _, pos in ipairs(nodes) do
      dig_node(pos)
   end

   manip:write_to_map()

   return #nodes
end

if minetest.setting_getbool("fixlight_command_enable") then
   minetest.register_privilege(
      "fixlight",
      {
         description = "Can use /fixlight command",
         give_to_singleplayer = false
   })

   minetest.register_chatcommand(
      "fixlight",
      {
	 params = "[radius 1-20]",
	 description = "Fix light in a radius around you",
	 privs = {fixlight = true},
	 func = function(name, param)
		   local rad = tonumber(param)

		   if rad == nil or (rad < 1 or rad > 20) then
		      return false, "Bad param for /fixlight; type /help fixlight"
		   end

		   local player = minetest.get_player_by_name(name)

		   local pos = player:getpos()
		   pos.x = math.floor(pos.x + 0.5)
		   pos.y = math.floor(pos.y + 0.5)
		   pos.z = math.floor(pos.z + 0.5)

		   local minp = {x = pos.x - rad, y = pos.y - rad, z = pos.z - rad}
		   local maxp = {x = pos.x + rad, y = pos.y + rad, z = pos.z + rad}

		   util.fixlight(minp, maxp)

		   minetest.chat_send_all("*** " .. name .. " has fixed light in a " .. rad .. "m radius at (" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. ")")
		end
      })
end

function util.nodefunc(pos1, pos2, name, func, nomanip)
   -- function based off fixlight
   -- call a function for every node of a single type
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   if not nomanip then
      local manip = minetest.get_voxel_manip()
      manip:read_from_map(pos1, pos2)
   end

   local nodes = minetest.find_nodes_in_area(pos1, pos2, name)
   for _, pos in ipairs(nodes) do
      func(pos)
   end
end

function util.getvoxelmanip(pos1, pos2)
   -- function based off fixlight
   -- return a voxel manipulator
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   local manip = minetest.get_voxel_manip()
   manip:read_from_map(pos1, pos2)

   return manip
end

function util.remove_area(pos1, pos2, nomanip)
   -- function based off fixlight
   -- call a function for every node of a single type
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   if not nomanip then
      local manip = minetest.get_voxel_manip()
      manip:read_from_map(pos1, pos2)
   end

   for i = pos1.x, pos2.x-1 do
      for j = pos1.y, pos2.y-1 do
	 for k = pos1.z, pos2.z-1 do
	    minetest.remove_node({x = i, y = j, z = k})
	 end
      end
   end

   manip:write_to_map()
end

function util.areafunc(pos1, pos2, func, nomanip)
   -- function based off fixlight
   -- call a function for every node of a single type
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   if not nomanip then
      local manip = minetest.get_voxel_manip()
      manip:read_from_map(pos1, pos2)
   end

   for i = pos1.x, pos2.x-1 do
      for j = pos1.y, pos2.y-1 do
	 for k = pos1.z, pos2.z-1 do
	    func(pos)
	 end
      end
   end
end

function util.reconstruct(pos1, pos2, nomanip)
   -- function based off fixlight
   -- force a re-construction of the nodes in an area, for fixing missing metadata in schematics
   local pos1, pos2 = util.sort_pos(pos1, pos2)

   if not nomanip then
      local manip = minetest.get_voxel_manip()
      manip:read_from_map(pos1, pos2)
   end

   -- fix chests
   local nodes = minetest.find_nodes_in_area(pos1, pos2, "default:chest")
   local node = minetest.registered_nodes["default:chest"]
   for _, pos in ipairs(nodes) do
      node.on_construct(pos)
   end

   -- fix music players
   nodes = minetest.find_nodes_in_area(pos1, pos2, "music:player")
   node = minetest.registered_nodes["music:player"]
   for _, pos in ipairs(nodes) do
      node.on_construct(pos)
   end

   -- fix furnaces
   nodes = minetest.find_nodes_in_area(pos1, pos2, "default:furnace")
   node = minetest.registered_nodes["default:furnace"]
   for _, pos in ipairs(nodes) do
      node.on_construct(pos)
   end
end

function util.choice(tab, pr)
   -- return a random index of the given table

   local choices = {}

   for n, _ in pairs(tab) do
      table.insert(choices, n)
   end

   if #choices <= 0 then return end

   if pr then
      return choices[pr:next(1, #choices)]
   else
      return choices[math.random(1, #choices)]
   end
end

function util.choice_element(tab, pr)
   -- return a random element of the given table

   local choices = {}

   for _,n in pairs(tab) do
      table.insert(choices, n)
   end

   if #choices <= 0 then return end

   if pr then
      return choices[pr:next(1, #choices)]
   else
      return choices[math.random(1, #choices)]
   end
end

-- util.split function taken from a StackOverflow answer.
-- http://stackoverflow.com/questions/12709205/split-a-string-and-store-in-an-array-in-lua
function util.split(str, tok)
   -- Source: http://lua-users.org/wiki/MakingLuaLikePhp
   -- Credit: http://richard.warburton.it/

   if not tok then return {} end

   local pos = 0
   local arr = {}

   for st, sp in function() return string.find(str, tok, pos, true) end do
      table.insert(arr, string.sub(str, pos, st - 1))
      pos = sp + 1
   end

   table.insert(arr, string.sub(str, pos))

   return arr
end
