local buyFuncs = {}
local stats = require(script.Parent.Stats)
local machines = require(script.Parent.Machines)
local Tutorial = require(script.Parent.Tutorial)

-- Copied from TouchConnects
local debounce = false
local debounceTime = 0.5
-- Tests if the touching thing is a player/humanoid then runs the given
-- function.
function filterTouchEvent(Touched, func, useDebounce)
   if Touched.Parent:FindFirstChild("Humanoid") then
      if useDebounce then
         if debounce then return end
         debounce = true
      end
      -- ypcall(function()
         func(Touched)
      -- end)
      if useDebounce then
         wait(debounceTime)
         debounce = false
      end
   end
end


function standardBuy(Touched, machine, product)
   local Player = game.Players:GetPlayerFromCharacter(Touched.Parent)
   assert(stats.spendCash(Player, machine[1]))
   local sTab = stats.getSTab(Player)
   sTab.TycoonModel[machine[3].Name]:Destroy()
   stats.putInTycoonModel(Player, machine[4])
   if product then
      sTab.production[product] = sTab.production[product] + machine[5]
      stats.updatePlayerVariables()
   end
   return Player, sTab
end

function buyFuncs.buyAtmosDist(Touched)
   standardBuy(Touched, machines.AtmosDist)

   --machines.HeavyNaphtha[3].Parent = stats.TycoonModel
   --machines.LightNaphtha[3].Parent = stats.TycoonModel
   machines.Asphalt[3].Parent = stats.TycoonModel
   Tutorial.boughtAtmosDist()
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

function buyFuncs.buyAsphalt(Touched)
   standardBuy(Touched, machines.Asphalt,"asphalt")

   machines.TruckDepot[3].Parent = stats.TycoonModel
   Tutorial.boughtAsphalt()
end

function buyFuncs.buyGasolineStorage(Touched)
   standardBuy(Touched, machines.GasolineStorage)
   stats.storage.gasoline.max = stats.storage.gasoline.max + machines.GasolineStorage[5]
   stats.updatePlayerVariables()

   --machines.GasolineStorage[3].Parent = stats.TycoonModel
end

function buyFuncs.buyTruckDepot(Touched)
   standardBuy(Touched, machines.TruckDepot)
   stats.export = stats.export + machines.TruckDepot[5]
   stats.updatePlayerVariables()

   Tutorial.boughtTruckDepot()
   --machines.TruckDepot[3].Parent = stats.TycoonModel
end

function buyFuncs.buyCrudeImport(Touched)
   local Player, sTab = standardBuy(Touched, machines.CrudeImport)
   sTab.import = sTab.import + machines.CrudeImport[5]
   stats.updatePlayerVariables()


   stats.putInTycoonModel(Player, machines.AtmosDist[3], function(Touched)
      filterTouchEvent(Touched, buyFuncs.buyAtmosDist, true)
   end, function()
      Player.PlayerGui.ItemDescriptionEvent:FireClient(Player, machines.AtmosDist)
   end)
   Tutorial.boughtCrudeImport()
end

function buyFuncs.buyControlRoom(Touched)
   local Player, sTab = standardBuy(Touched, machines.ControlRoom)

   machines.GasolineControls[3].Parent = stats.TycoonModel
   machines.MarketControls[3].Parent = stats.TycoonModel
end
function buyFuncs.buyGasolineControls(Touched)
   standardBuy(Touched, machines.GasolineControls)
end
function buyFuncs.buyMarketControls(Touched)
   standardBuy(Touched, machines.MarketControls)
end

function buyFuncs.buyWalls(Touched)
   standardBuy(Touched, machines.Walls)
end
function buyFuncs.buyFloor(Touched)
   standardBuy(Touched, machines.Floor)
end
return buyFuncs
