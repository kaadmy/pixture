village.name = {}

village.name.prefixes = {"long", "dan", "fan", "tri", "man"}
village.name.middles = {"er", "in", "ao", "ie", "ir", "et", "em", "me", "el"}
village.name.postfixes = {"ton", "eth", "ing", "arn", "agt", "seg"}

village.name.used = {}

function village.name.generate(pr)
   local prefix = ""
   local middle = ""
   local postfix = ""

   local middles = pr:next(2, 5)

   if pr:next(1, 4) <= 1 then
      prefix = village.name.prefixes[pr:next(1, #village.name.prefixes)]
      middles = middles - 1
   end

   if pr:next(1, 2) <= 1 then
      postfix = village.name.postfixes[pr:next(1, #village.name.postfixes)]
      middles = middles - 2
   end

   if middles < 2 then
      middles = 2
   end

   for i = 1, middles do
      middle = middle..village.name.middles[pr:next(1, #village.name.middles)]
   end

   local name = prefix..middle..postfix

   name = name:gsub("^%l", string.upper)

   village.name.used[name] = true

   return name
end
