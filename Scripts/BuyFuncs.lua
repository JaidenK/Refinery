local buyFuncs = {}
local stats = require(script.Parent.Stats)
local machines = require(script.Parent.Machines)
local Tutorial = require(script.Parent.Tutorial)

local BuyMachineRF = game.ReplicatedStorage:WaitForChild("BuyMachineRF")

function BuyMachineRF.OnServerInvoke(Player, TycoonModel, machine)
   print("BuyFuncs: "..Player.Name.." trying to buy "..machine[2])

   -- Invoke the buy function for machine
   buyFuncs[machine[8]](Player)(TycoonModel, machine)
end

-- Copied from TouchConnects
local debounce = false
local debounceTime = 0.5
local RED_BUTTON = 1
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

function insertRedButton(Player, machine)
   stats.putInTycoonModel(
      Player, 
      machine[3], 
      RED_BUTTON,
      machine,
      true
   )
end

function getPlayerFromTouched(Touched)
   return game.Players:GetPlayerFromCharacter(Touched.Parent)
end


function standardBuy(Player, machine, product)
   assert(stats.spendCash(Player, machine[1]))
   local sTab = stats.getSTab(Player)
   stats.putInTycoonModel(Player, machine[4])
   if product then
      sTab.production[product] = sTab.production[product] + machine[5]
      stats.updatePlayerVariables()
   end
   -- The callback func being return here will be passed back through
   -- the stack and ultimately executed by RefineryLocal after the
   -- purchase goes through.
   return Player, sTab, function(TycoonModel, machine)
      print(TycoonModel)
      print(#TycoonModel:GetChildren())
      for k,v in pairs(TycoonModel:GetChildren()) do
         print(v)
      end
      print("BuyFuncs: callback: "..TycoonModel[machine[3].Name].Name)
      TycoonModel[machine[3].Name]:Destroy()
      print("CALLBACK")
   end
end
function standardInsert(Player, machineName)
   stats.putInTycoonModel(Player, machines[machineName][3], function(Touched)
      filterTouchEvent(Touched, buyFuncs["buy"..machineName], true)
   end, function()
      game.ReplicatedStorage.ItemDescriptionEvent:FireClient(Player, machines[machineName])
   end)
end

function buyFuncs.buyAtmosDist(Player)
   local Player, sTab, func = standardBuy(Player, machines.AtmosDist)

   --machines.HeavyNaphtha[3].Parent = stats.TycoonModel
   --machines.LightNaphtha[3].Parent = stats.TycoonModel


   insertRedButton(Player, machines.Asphalt)
   Tutorial.boughtAtmosDist(Player)
   return func
end

function buyFuncs.buyHeavyNaphtha(Touched)
   standardBuy(Touched, machines.HeavyNaphtha,"Gasoline")

   machines.HNHydrotreater[3].Parent = stats.TycoonModel
   machines.HNCatalyticReformer[3].Parent = stats.TycoonModel
end
function buyFuncs.buyHNHydrotreater(Touched)
   standardBuy(Touched, machines.HNHydrotreater,"Gasoline")
end
function buyFuncs.buyHNCatalyticReformer(Touched)
   standardBuy(Touched, machines.HNCatalyticReformer,"Gasoline")
end

function buyFuncs.buyLightNaphtha(Touched)
   standardBuy(Touched, machines.LightNaphtha,"Gasoline")

   machines.LNHydrotreater[3].Parent = stats.TycoonModel
   machines.LNIsoPlant[3].Parent = stats.TycoonModel
end
function buyFuncs.buyLNHydrotreater(Touched)
   standardBuy(Touched, machines.LNHydrotreater,"Gasoline")
end
function buyFuncs.buyLNIsoPlant(Touched)
   standardBuy(Touched, machines.LNIsoPlant,"Gasoline")
end

function buyFuncs.buyAsphalt(Player)
   local Player, sTab, func = standardBuy(Player, machines.Asphalt, "Asphalt")

   insertRedButton(Player, machines.TruckDepot)
   Tutorial.boughtAsphalt(Player)
   return func
end

function buyFuncs.buyGasolineStorage(Touched)
   standardBuy(Touched, machines.GasolineStorage)
   stats.storage.gasoline.max = stats.storage.gasoline.max + machines.GasolineStorage[5]
   stats.updatePlayerVariables()

   --machines.GasolineStorage[3].Parent = stats.TycoonModel
end

function buyFuncs.buyTruckDepot(Player)
   local Player, sTab, func = standardBuy(Player, machines.TruckDepot)
   sTab.export = sTab.export + machines.TruckDepot[5]
   stats.updatePlayerVariables()

   Tutorial.boughtTruckDepot(Player)
   --machines.TruckDepot[3].Parent = stats.TycoonModel
   return func
end

function buyFuncs.buyCrudeImport(Player)
   local Player, sTab, func = standardBuy(Player, machines.CrudeImport)
   sTab.import = sTab.import + machines.CrudeImport[5]
   stats.updatePlayerVariables()

   print("Buying crude import")
   insertRedButton(Player, machines.AtmosDist)
   -- stats.putInTycoonModel(Player, machines.AtmosDist[3], function(Touched)
   --    filterTouchEvent(Touched, buyFuncs.buyAtmosDist, true)
   -- end, function()
   --    game.ReplicatedStorage.ItemDescriptionEvent:FireClient(Player, machines.AtmosDist)
   -- end)
   Tutorial.boughtCrudeImport(Player)
   return func
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

function buyFuncs.buyWalls(Player)
   local Player, sTab, func = standardBuy(Player, machines.Walls)
   return func
end
function buyFuncs.buyFloor(Player)
   local Player, sTab, func = standardBuy(Player, machines.Floor)
   return func
end
return buyFuncs
