local buyFuncs = {}
local stats = require(script.Parent.Stats)
local machines = require(script.Parent.Machines)

function buyFuncs.buyAtmosDist(Touched)
   stats.spendCash(machines.AtmosDist[1])
   machines.AtmosDist[3]:Destroy()
   machines.AtmosDist[4].Parent = stats.TycoonModel

   machines.HeavyNaptha[3].Parent = stats.TycoonModel
end
function buyFuncs.buyHeavyNaptha(Touched)
   stats.spendCash(machines.HeavyNaptha[1])
   machines.HeavyNaptha[3]:Destroy()
   machines.HeavyNaptha[4].Parent = stats.TycoonModel
   stats.production.gasoline = stats.production.gasoline + machines.HeavyNaptha[5]

   machines.HNHydrotreater[3].Parent = stats.TycoonModel
   machines.HNCatalyticReformer[3].Parent = stats.TycoonModel
end
function buyFuncs.buyHNHydrotreater(Touched)
   stats.spendCash(machines.HNHydrotreater[1])
   machines.HNHydrotreater[3]:Destroy()
   machines.HNHydrotreater[4].Parent = stats.TycoonModel
   stats.production.gasoline = stats.production.gasoline + machines.HNHydrotreater[5]
end
function buyFuncs.buyHNCatalyticReformer(Touched)
   stats.spendCash(machines.HNCatalyticReformer[1])
   machines.HNCatalyticReformer[3]:Destroy()
   machines.HNCatalyticReformer[4].Parent = stats.TycoonModel
   stats.production.gasoline = stats.production.gasoline + machines.HNCatalyticReformer[5]
end
function buyFuncs.buyWalls(Touched)
   stats.spendCash(machines.Walls[1])
   machines.Walls[3]:Destroy()
   machines.Walls[4].Parent = stats.TycoonModel
end
function buyFuncs.buyFloor(Touched)
   stats.spendCash(machines.Floor[1])
   machines.Floor[3]:Destroy()
   machines.Floor[4].Parent = stats.TycoonModel
end
return buyFuncs
