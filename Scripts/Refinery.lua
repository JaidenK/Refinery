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

-- Assigns the proper prices to each machine's buy button and hides the
-- machine itself
for _,machine in pairs(machines) do
   machine[3]["$"].Name = "$"..machine[1]
   machine[3].Parent = game.ServerStorage
   machine[4].Parent = game.ServerStorage
end

require(script.TouchConnects)

while(wait(1))do
   local gasolineProduced = math.min(stats.crudeIntake,stats.production.gasoline)
   stats.cash = stats.cash + stats.marketPrice.gasoline * gasolineProduced
   if stats.owner then stats.updatePlayerVariables() end
end
