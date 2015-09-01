--
-- Wielditem mod
-- By Kaadmy, for Pixture
--

local update_time = 1
local timer = 10

local function step(dtime)
   timer = timer + dtime
   if timer > update_time then
      for _, player in pairs(minetest.get_connected_players()) do
	 
      end
      timer = 0
   end
end

minetest.register_globalstep(step)
