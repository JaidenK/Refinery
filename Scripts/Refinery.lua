--[[

Start off with crude coming in, Distillation Tower, asphalt

Everything is calculated by product per second.
e.g.
default asphalt production is 1 asphalt/sec
buying the blower adds 5 asphalt/sec
etc

Production is limited by crude intake. Each unit of crude contains a
maximum yield. Each machine in the production line adds to the amount
of crude that can be converted. Once you have more machines than the
crude can supply, you'll need to get more crude.

Every second, profit is calculated by market values and production and
added to the current profit. There will be a bank where you can collect
your profit, and it adds to your wallet when you collect.

Things have a status as "good condition" or "needs maintenance." A 
broken down machine causes damage to nearby machines unless a flare
tower is installed. (?)

Each branch of production has a linear progression list?
Each node determines which parts are shown or hidden.

--]]

local stats = require(script.Stats)
local machines = require(script.Machines)

local MachineInfoEvent = game.ReplicatedStorage:WaitForChild("MachineInfoEvent")





-- Assigns the proper prices to each machine's buy button and hides the
-- machine itself
for _,machine in pairs(machines) do
   machine[3]["$"].Name = "$"..machine[1]
   machine[3].Parent = game.ReplicatedStorage
   machine[4].Parent = game.ReplicatedStorage
end

require(script.TouchConnects)

-- When a player is respawns, I need to tell them what the details of
-- the machines are. This is used for identifying what machines are
-- being bought by server events and such. I have to create an event for
-- when a player is added, so that I can connect to their spawn event.
game.Players.PlayerAdded:connect(function(Player)
   print("Refinery: Player added: "..Player.Name)
   Player.CharacterAdded:connect(function(Model)
      print("Refinery: CharacterAdded for player "..Player.Name)
      MachineInfoEvent:FireClient(Player, machines)
   end)
end)



while(wait(1))do
   local totalCrudeUnits = 0
   for _,NumberValue in ipairs(workspace.CrudeMixture:GetChildren()) do
      totalCrudeUnits = totalCrudeUnits + NumberValue.Value
   end
   for _,sTab in ipairs(stats) do
      for product, productValue in pairs(sTab.production) do
         -- print("Payout: "..product.." "..productValue)
         -- Percent of total crude import units that contains this
         -- product.
         local crudeFraction = workspace.CrudeMixture[product].Value / totalCrudeUnits
         -- Number of units of this product being exported.
         local productUnits = sTab.import * crudeFraction
         -- Market price modified by player's product value.
         local productSellingPrice = workspace.MarketPrice[product].Value * productValue
         local finalExportCash = productUnits * productSellingPrice
         sTab.cash = sTab.cash + finalExportCash
         -- print("Cash: "..sTab.cash)
      end
   end
   stats.updatePlayerVariables()
end
