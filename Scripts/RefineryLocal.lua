game.ReplicatedStorage:WaitForChild("InsertIntoTycoonEvent").OnClientEvent:connect(function(model, TouchFunction, ClickFunction)
   -- local sTab = stats.getSTab(Player)
   -- local ModelClone = model:Clone()
   -- putInTycoonModelHelper(sTab, sTab.TycoonModel, ModelClone)
   -- if TouchFunction then
   --    -- print("Connecting touch function.")
   --    ModelClone.TouchPart.Touched:connect(TouchFunction)
   -- end
   -- if ClickFunction then
   --    -- print("Connecting click function")
   --    ModelClone.TouchPart.ClickDetector.MouseClick:connect(ClickFunction)
   -- end
end)
print("RefineryLocal: ready.")
