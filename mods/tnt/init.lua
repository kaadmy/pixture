
--
-- TNT mod
-- By PilzAdam and ShadowNinja
-- Tweaked by Kaadmy, for Pixture
--

tnt = {}

-- Default to enabled in singleplayer and disabled in multiplayer

local singleplayer = minetest.is_singleplayer()
local setting = minetest.setting_getbool("tnt_enable")

if (not singleplayer and setting ~= true) or (singleplayer and setting == false) then
   return
end

local tnt_radius = tonumber(minetest.setting_get("tnt_radius") or 3)

-- Loss probabilities array (one in X will be lost)

local loss_prob = {
   ["default:cobble"] = 3,
   ["default:dirt"] = 4,
}

-- Fill a list with data for content IDs, after all nodes are registered

local cid_data = {}

local function rand_pos(center, pos, radius)
   pos.x = center.x + math.random(-radius, radius)
   pos.z = center.z + math.random(-radius, radius)
end

local function eject_drops(drops, pos, radius)
   local drop_pos = vector.new(pos)
   for _, item in pairs(drops) do
      local count = item:get_count()
      local max = item:get_stack_max()
      if count > max then
	 item:set_count(max)
      end
      while count > 0 do
	 if count < max then
	    item:set_count(count)
	 end
	 rand_pos(pos, drop_pos, radius)
	 local obj = minetest.add_item(drop_pos, item)
	 if obj then
	    obj:get_luaentity().collect = true
	    obj:setacceleration({x=0, y=-10, z=0})
	    obj:setvelocity({x=math.random(-3, 3), y=10,
			     z=math.random(-3, 3)})
	 end
	 count = count - max
      end
   end
end

local function add_drop(drops, item)
   item = ItemStack(item)
   local name = item:get_name()
   if loss_prob[name] ~= nil and math.random(1, loss_prob[name]) == 1 then
      return
   end

   local drop = drops[name]
   if drop == nil then
      drops[name] = item
   else
      drop:set_count(drop:get_count() + item:get_count())
   end
end

local function destroy(drops, pos, cid)
   if minetest.is_protected(pos, "") then
      return
   end
   local def = cid_data[cid]
   if def and def.on_blast then
      def.on_blast(vector.new(pos), 1)
      return
   end

   minetest.remove_node(pos)
   if def then
      local node_drops = minetest.get_node_drops(def.name, "")
      for _, item in ipairs(node_drops) do
	 add_drop(drops, item)
      end
   end
end


local function calc_velocity(pos1, pos2, old_vel, power)
   local vel = vector.direction(pos1, pos2)
   vel = vector.normalize(vel)
   vel = vector.multiply(vel, power)

   -- Divide by distance
   local dist = vector.distance(pos1, pos2)
   dist = math.max(dist, 1)
   vel = vector.divide(vel, dist)

   -- Add old velocity
   vel = vector.add(vel, old_vel)
   return vel
end

local function entity_physics(pos, radius)
   -- Make the damage radius larger than the destruction radius
   radius = radius * 2

   local no_water = (minetest.find_node_near(pos, 2, {"default:water_source"}) == nil)

   local objs = minetest.get_objects_inside_radius(pos, radius)
   for _, obj in pairs(objs) do
      local obj_pos = obj:getpos()
      local obj_vel = obj:getvelocity()
      local dist = math.max(1, vector.distance(pos, obj_pos))

      if obj_vel ~= nil then
	 obj:setvelocity(calc_velocity(pos, obj_pos,
				       obj_vel, radius * 10))
      end

      if no_water then
	 local damage = (4 / dist) * radius
	 obj:set_hp(obj:get_hp() - damage)
      end
   end
end

local function add_effects(pos, radius)
   minetest.add_particlespawner(
      {
	 amount = 128,
	 time = 1,
	 minpos = vector.subtract(pos, radius / 2),
	 maxpos = vector.add(pos, radius / 2),
	 minvel = {x = -20, y = -20, z = -20},
	 maxvel = {x = 20,  y = 20,  z = 20},
	 minacc = vector.new(),
	 maxacc = vector.new(),
	 minexptime = 0.2,
	 maxexptime = 1,
	 minsize = 16,
	 maxsize = 24,
	 texture = "tnt_smoke.png",
   })
end

function tnt.burn(pos)
   local name = minetest.get_node(pos).name
   if name == "tnt:tnt" then
      minetest.sound_play("tnt_ignite", {pos = pos})
      minetest.set_node(pos, {name = "tnt:tnt_burning"})
      minetest.get_node_timer(pos):start(2)
   end
end

-- TNT ground removal

function tnt.explode(pos, radius, sound)
   minetest.sound_play(
      sound,
      {
         pos = pos,
         gain = 1.5,
         max_hear_distance = 128
   })

   local pos = vector.round(pos)
   local vm = VoxelManip()
   local pr = PseudoRandom(os.time())
   local p1 = vector.subtract(pos, radius)
   local p2 = vector.add(pos, radius)
   local minp, maxp = vm:read_from_map(p1, p2)
   local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
   local data = vm:get_data()

   local drops = {}
   local p = {}

   local c_air = minetest.get_content_id("air")

   for z = -radius, radius do
      for y = -radius, radius do
	 local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	 for x = -radius, radius do
	    if (x * x) + (y * y) + (z * z) <= (radius * radius) + pr:next(-radius, radius) then
	       local cid = data[vi]
	       p.x = pos.x + x
	       p.y = pos.y + y
	       p.z = pos.z + z
	       if cid ~= c_air then
		  destroy(drops, p, cid)
	       end
	    end
	    vi = vi + 1
	 end
      end
   end

   return drops
end

-- TNT node explosion

function tnt.boom(pos)
   minetest.remove_node(pos)

   local drops = tnt.explode(pos, tnt_radius, "tnt_explode")
   entity_physics(pos, tnt_radius)
   eject_drops(drops, pos, tnt_radius)
   add_effects(pos, tnt_radius)
end

-- On load register content IDs

local function on_load()
   for name, def in pairs(minetest.registered_nodes) do
      cid_data[minetest.get_content_id(name)] = {
         name = name,
         drops = def.drops,
         on_blast = def.on_blast,
      }
   end
end

minetest.after(0, on_load)

-- Nodes

minetest.register_node(
   "tnt:tnt",
   {
      description = "TNT",
      tiles = {"tnt_top.png", "tnt_bottom.png", "tnt_sides.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults(),

      on_punch = function(pos, node, puncher)
         local itemname = puncher:get_wielded_item():get_name()

         if itemname == "default:flint_and_steel" then
            tnt.burn(pos)
         end
      end,
      on_blast = function(pos, intensity)
         tnt.burn(pos)
      end,
})

-- Nodes

minetest.register_node(
   "tnt:tnt_burning",
   {
      tiles = {
	 {
	    name = "tnt_top_burning.png",
	    animation = {
	       type = "vertical_frames",
	       aspect_w = 16,
	       aspect_h = 16,
	       length = 1,
	    }
	 },
	 "tnt_bottom.png", "tnt_sides.png"},
      light_source = 5,
      drop = "tnt:tnt",
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults(),
      on_timer = tnt.boom,
      -- unaffected by explosions
      on_blast = function() end,
})

-- Crafting

crafting.register_craft(
   {
      output = "tnt:tnt",
      items = {
         "group:planks 4",
         "default:flint_and_steel",
      }
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "tnt:tnt",
      burntime = 13,
})

-- Achievements

achievements.register_achievement(
   "boom",
   {
      title = "Boom!",
      description = "Craft TNT",
      times = 1,
      craftitem = "tnt:tnt",
})

default.log("mod:tnt", "loaded")
