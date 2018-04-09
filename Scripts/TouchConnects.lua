local machines = require(script.Parent.Machines)
local buyFuncs = require(script.Parent.BuyFuncs)
local Tutorial = require(script.Parent.Tutorial)
local stats    = require(script.Parent.Stats)

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




workspace.ClaimTycoon1.Part.Touched:connect(function(Touched)
   filterTouchEvent(Touched, function(Touched)
      local Player = game.Players:GetPlayerFromCharacter(Touched.Parent)
      stats.setOwner(Player, workspace.ClaimTycoon1.Part)
      workspace.ClaimTycoon1.Part.CanCollide = false
      workspace.ClaimTycoon1.Part.Transparency = 1
      workspace.ClaimTycoon1:WaitForChild("Claim Refinery").Name = Player.Name.."'s Refinery"

      -- Walls
      stats.putInTycoonModel(Player, machines.Walls[3], function(Touched)
         filterTouchEvent(Touched, buyFuncs.buyWalls, true)
      end, function()
         game.ReplicatedStorage.ItemDescriptionEvent:FireClient(Player, machines.Walls)
      end)

      -- Floor
      stats.putInTycoonModel(Player, machines.Floor[3], function(Touched)
         filterTouchEvent(Touched, buyFuncs.buyFloor, true)
      end)

      -- Control Room
      stats.putInTycoonModel(Player, machines.ControlRoom[3], function(Touched)
         filterTouchEvent(Touched, buyFuncs.buyControlRoom, true)
      end)

      -- Gasoline Storage
      stats.putInTycoonModel(Player, machines.GasolineStorage[3], function(Touched)
         filterTouchEvent(Touched, buyFuncs.buyGasolineControls, true)
      end)

      -- Crude Import
      stats.putInTycoonModel(Player, machines.CrudeImport[3], function(Touched)
         filterTouchEvent(Touched, buyFuncs.buyCrudeImport, true)
      end, function()
         game.ReplicatedStorage.ItemDescriptionEvent:FireClient(Player, machines.CrudeImport)
      end)

      Tutorial.giveTutorial(Player)
   end, true)
end)

machines.AtmosDist[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyAtmosDist, true)
end)

machines.HeavyNaphtha[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHeavyNaphtha, true)
end)
machines.HNHydrotreater[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHNHydrotreater, true)
end)
machines.HNCatalyticReformer[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHNCatalyticReformer, true)
end)

machines.LightNaphtha[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLightNaphtha, true)
end)
machines.LNHydrotreater[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLNHydrotreater, true)
end)
machines.LNIsoPlant[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLNIsoPlant, true)
end)

machines.Asphalt[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyAsphalt, true)
end)

machines.GasolineStorage[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyGasolineStorage, true)
end)
machines.TruckDepot[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyTruckDepot, true)
end)

machines.MarketControls[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyMarketControls, true)
end)

print("TouchConnects: ready.")

return nil
