local machines = require(script.Parent.Machines)
local buyFuncs = require(script.Parent.BuyFuncs)
local stats = require(script.Parent.Stats)

local debounce = false
local debounceTime = 0.1
-- Tests if the touching thing is a player/humanoid then runs the given
-- function.
function filterTouchEvent(Touched, func, useDebounce)
   if Touched.Parent:FindFirstChild("Humanoid") then
      if useDebounce then
         if debounce then return end
         debounce = true
      end
      ypcall(function()func(Touched)end)
      if useDebounce then
         wait(debounceTime)
         debounce = false
      end
   end
end

workspace.ClaimPart.Part.Touched:connect(function(Touched)
   filterTouchEvent(Touched, function(Touched)
      local Player = game.Players:GetPlayerFromCharacter(Touched.Parent)
      stats.setOwner(Player)
      workspace.ClaimPart.Part:Destroy()
      workspace.ClaimPart["Claim Refinery"].Name = Player.Name.."'s Refinery"
      machines.AtmosDist[3].Parent = stats.TycoonModel
      machines.Walls[3].Parent = stats.TycoonModel
      machines.Floor[3].Parent = stats.TycoonModel
   end, true)
end)

machines.AtmosDist[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyAtmosDist, true)
end)

machines.HeavyNaptha[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHeavyNaptha, true)
end)
machines.HNHydrotreater[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHNHydrotreater, true)
end)
machines.HNCatalyticReformer[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyHNCatalyticReformer, true)
end)

machines.LightNaptha[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLightNaptha, true)
end)
machines.LNHydrotreater[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLNHydrotreater, true)
end)
machines.LNIsoPlant[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyLNIsoPlant, true)
end)

machines.Walls[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyWalls, true)
end)
machines.Floor[3].TouchPart.Touched:connect(function(Touched)
   filterTouchEvent(Touched, buyFuncs.buyFloor, true)
end)
return nil
