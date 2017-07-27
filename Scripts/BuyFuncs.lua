local buyFuncs = {}
local stats = require(script.Parent.Stats)
local machines = require(script.Parent.Machines)

function standardBuy(Touched, machine, product)
   local Player = game.Players:GetPlayerFromCharacter(Touched.Parent)
   assert(Player == stats.owner)
   stats.spendCash(machine[1])
   machine[3]:Destroy()
   machine[4].Parent = stats.TycoonModel
   if product then
      stats.production[product] = stats.production[product] + machine[5]
   end
end

function buyFuncs.buyAtmosDist(Touched)
   standardBuy(Touched, machines.AtmosDist)

   machines.HeavyNaphtha[3].Parent = stats.TycoonModel
   machines.LightNaphtha[3].Parent = stats.TycoonModel
end

function buyFuncs.buyHeavyNaphtha(Touched)
   standardBuy(Touched, machines.HeavyNaphtha,"gasoline")

   machines.HNHydrotreater[3].Parent = stats.TycoonModel
   machines.HNCatalyticReformer[3].Parent = stats.TycoonModel
end
function buyFuncs.buyHNHydrotreater(Touched)
   standardBuy(Touched, machines.HNHydrotreater,"gasoline")
end
function buyFuncs.buyHNCatalyticReformer(Touched)
   standardBuy(Touched, machines.HNCatalyticReformer,"gasoline")
end

function buyFuncs.buyLightNaphtha(Touched)
   standardBuy(Touched, machines.LightNaphtha,"gasoline")

   machines.LNHydrotreater[3].Parent = stats.TycoonModel
   machines.LNIsoPlant[3].Parent = stats.TycoonModel
end
function buyFuncs.buyLNHydrotreater(Touched)
   standardBuy(Touched, machines.LNHydrotreater,"gasoline")
end
function buyFuncs.buyLNIsoPlant(Touched)
   standardBuy(Touched, machines.LNIsoPlant,"gasoline")
end

function buyFuncs.buyControlRoom(Touched)
   standardBuy(Touched, machines.ControlRoom)

   machines.GasolineControls[3].Parent = stats.TycoonModel
end
function buyFuncs.buyGasolineControls(Touched)
   standardBuy(Touched, machines.GasolineControls)
end

function buyFuncs.buyWalls(Touched)
   standardBuy(Touched, machines.Walls)
end
function buyFuncs.buyFloor(Touched)
   standardBuy(Touched, machines.Floor)
end
return buyFuncs
