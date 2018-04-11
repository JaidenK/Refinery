local InsertIntoTycoonEvent = game.ReplicatedStorage:WaitForChild("InsertIntoTycoonEvent")
-- local GetTycoonModelRemoteFunction = nil
local TycoonClaimedEvent = game.ReplicatedStorage:WaitForChild("TycoonClaimedEvent")
local TycoonModel = nil
local TycoonModelRefPart = nil
local Player = game.Players.LocalPlayer


-- Fired in TouchConnects when the player walks into the claim part
TycoonClaimedEvent.OnClientEvent:connect(function(Model, RefPart)
   TycoonModel = Model
   -- The same ref part as in the server's sTab for the player.
   -- Hopefully this works. Not sure if the server changes the name of
   -- the part or does something with it.
   TycoonModelRefPart = RefPart
   print("RefineryLocal: You claimed a refinery.")
end)

function putInTycoonModelHelper(Parent, Model)
   -- Recursively insert every child. Needed because there's
   -- repositioning involved, not just parenting.
   for _,Child in pairs(Model:GetChildren()) do
      putInTycoonModelHelper(Model, Child)
   end
   Model.Parent = Parent
   -- Reposition the model if it's actually a part. Hopefully these
   -- three are all the parts that I'll be using. Wedge part or special
   -- mesh etc might exist, but I doubt I'll use them.
   if Model:IsA("Part") or Model:IsA("MeshPart") or Model:IsA("UnionOperation") then
      -- Our tycoon.
      local There = TycoonModelRefPart
      -- The reference tycoon.
      local Here = workspace.ClaimPart.Part
      -- Putting the reference coords into our tycoon's local frame? 
      local ObjSpaceCFrame = Here.CFrame:toObjectSpace(Model.CFrame)
      -- I forget how this all works.
      Model.CFrame = There.CFrame:toWorldSpace(ObjSpaceCFrame)
   end
end
InsertIntoTycoonEvent.OnClientEvent:connect(function(Model, TouchFunction, ClickFunction)
   if not TycoonModel then
      warn("RefineryLocal: Trying to insert into TycoonModel before it exists.")
      repeat wait(1) until TycoonModel
   end


   local ModelClone = Model:Clone()
   putInTycoonModelHelper(TycoonModel, ModelClone)
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
