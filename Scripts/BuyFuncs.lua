local buyFuncs = {}
local stats = require(script.Parent.Stats)
local machines = require(script.Parent.Machines)

function standardBuy(machine, product)
   stats.spendCash(machine[1])
   machine[3]:Destroy()
   machine[4].Parent = stats.TycoonModel
   if product then
      stats.production[product] = stats.production[product] + machine[5]
   end
end

function buyFuncs.buyAtmosDist(Touched)
   standardBuy(machines.AtmosDist)

   machines.HeavyNaptha[3].Parent = stats.TycoonModel
   machines.LightNaptha[3].Parent = stats.TycoonModel
end

function buyFuncs.buyHeavyNaptha(Touched)
   standardBuy(machines.HeavyNaptha,"gasoline")

   machines.HNHydrotreater[3].Parent = stats.TycoonModel
   machines.HNCatalyticReformer[3].Parent = stats.TycoonModel
end
function buyFuncs.buyHNHydrotreater(Touched)
   standardBuy(machines.HNHydrotreater,"gasoline")
end
function buyFuncs.buyHNCatalyticReformer(Touched)
   standardBuy(machines.HNCatalyticReformer,"gasoline")
end

function buyFuncs.buyLightNaptha(Touched)
   standardBuy(machines.LightNaptha,"gasoline")

   machines.LNHydrotreater[3].Parent = stats.TycoonModel
   machines.LNIsoPlant[3].Parent = stats.TycoonModel
end
function buyFuncs.buyLNHydrotreater(Touched)
   standardBuy(machines.LNHydrotreater,"gasoline")
end
function buyFuncs.buyLNIsoPlant(Touched)
   standardBuy(machines.LNIsoPlant,"gasoline")
end

function buyFuncs.buyWalls(Touched)
   standardBuy(machines.Walls)
end
function buyFuncs.buyFloor(Touched)
   standardBuy(machines.Floor)
end
return buyFuncs
