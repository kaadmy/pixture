--
-- Testing mod
-- By Kaadmy, for Pixture
--

if minetest.settings:get_bool("testing_enable") then
   local t1 = os.clock()
   for i = 1, 10000 do
      dump({x=0,y=50,z=100})
   end
   print(string.format("10000 iterations with dump({x=0,y=50,z=100}) took %.2fms", (os.clock() - t1) * 1000))

   local t2 = os.clock()
   for i = 1, 10000 do
      tostring({x=0,y=50,z=100})
   end
   print(string.format("10000 iterations with tostring({x=0,y=50,z=100}) took %.2fms", (os.clock() - t2) * 1000))

   local t3 = os.clock()
   for i = 1, 10000 do
      minetest.serialize({x=0,y=50,z=100})
   end
   print(string.format("10000 iterations with minetest.serialize({x=0,y=50,z=100}) took %.2fms", (os.clock() - t3) * 1000))

   local t4 = os.clock()
   for i = 1, 10000 do
      default.dumpvec({x=0,y=50,z=100})
   end
   print(string.format("10000 iterations with(custom function) default.dumpvec({x=0,y=50,z=100}) took %.2fms", (os.clock() - t4) * 1000))

   local t5 = os.clock()
   for i = 1, 10000 do
      minetest.hash_node_position({x=0,y=50,z=100})
   end
   print(string.format("10000 iterations with minetest.hash_node_position({x=0,y=50,z=100}) took %.2fms", (os.clock() - t5) * 1000))
end