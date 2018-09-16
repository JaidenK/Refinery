local machines = require(script.Parent.Machines)
local stats = {}
local InsertIntoTycoonEvent = game.ReplicatedStorage:WaitForChild("InsertIntoTycoonEvent")
local TycoonClaimedEvent = game.ReplicatedStorage:WaitForChild("TycoonClaimedEvent")

-- Puts the variables and data in the player for their GUI to use
function stats.giveVariables(sTab)
   local Folder = Instance.new("Folder")
   Folder.Name = "PlayerVariables"

   local NumberValue = Instance.new("NumberValue")
   NumberValue.Name = "Wallet"
   NumberValue.Parent = Folder

   local FolderProduction = Instance.new("Folder")
   FolderProduction.Name = "Production"
   FolderProduction.Parent = Folder

      local NumberValue = Instance.new("NumberValue")
      NumberValue.Name = "Crude"
      NumberValue.Parent = FolderProduction

      local NumberValue = Instance.new("NumberValue")
      NumberValue.Name = "Gasoline"
      NumberValue.Parent = FolderProduction

   local FolderStorage = Instance.new("Folder")
   FolderStorage.Name = "Storage"
   FolderStorage.Parent = Folder

      local FolderStorageGasoline = Instance.new("Folder")
      FolderStorageGasoline.Name = "Gasoline"
      FolderStorageGasoline.Parent = FolderStorage

         local NumberValue = Instance.new("NumberValue")
         NumberValue.Name = "Stored"
         NumberValue.Parent = FolderStorageGasoline

         local NumberValue = Instance.new("NumberValue")
         NumberValue.Name = "Max"
         NumberValue.Parent = FolderStorageGasoline

   Folder.Parent = sTab.TycoonModel
   sTab.PlayerVariables = Folder
   stats.updatePlayerVariables()
end
function stats.setOwner(Player, Part)
   sTab = {} -- New Stats Table

   sTab.TycoonModel = Instance.new("Model")
   sTab.TycoonModel.Name = Player.Name.."'s Tycoon"
   sTab.TycoonModel.Parent = workspace

   sTab.RefPart = Part

   sTab.Owner = Player
   sTab.cash = 10000
   sTab.PlayerVariables = nil

   sTab.production = {
      Gasoline = 0,
      Asphalt = 0.5
   }
   sTab.storage = {
      gasoline = {stored = 0, max = 0}
   }
   sTab.export = 0
   sTab.import = 100

   table.insert(stats, sTab)

   -- Player.CharacterAdded:connect(stats.giveVariables) -- For when they respawn
   TycoonClaimedEvent:FireClient(Player, sTab.TycoonModel, Part)
   stats.giveVariables(sTab)
end
function stats.updatePlayerVariables() 
   for _,sTab in ipairs(stats) do
      sTab.PlayerVariables.Wallet.Value = sTab.cash
      sTab.PlayerVariables.Production.Crude.Value = sTab.production.crude
      sTab.PlayerVariables.Production.Gasoline.Value = sTab.production.gasoline
      sTab.PlayerVariables.Storage.Gasoline.Stored.Value = sTab.storage.gasoline.stored
      sTab.PlayerVariables.Storage.Gasoline.Max.Value = sTab.storage.gasoline.max
   end
end
function stats.spendCash(Player, amount)
   local isValidPurchase = false
   for _,sTab in ipairs(stats) do
      if sTab.Owner == Player and sTab.cash >= amount then
         sTab.cash = sTab.cash - amount
         stats.updatePlayerVariables()
         isValidPurchase = true
      end
   end
   return isValidPurchase
end
function putInTycoonModelHelper(sTab, Parent, model)
   for _,Child in pairs(model:GetChildren()) do
      putInTycoonModelHelper(sTab, model, Child)
   end
   model.Parent = Parent
   if model:IsA("Part") or model:IsA("MeshPart") or model:IsA("UnionOperation") then
      local There = sTab.RefPart
      local Here = workspace.ClaimPart.Part
      local ObjSpaceCFrame = Here.CFrame:toObjectSpace(model.CFrame)
      model.CFrame = There.CFrame:toWorldSpace(ObjSpaceCFrame)
   end
end
function stats.putInTycoonModel(Player, model, TouchFunction, ClickFunction, isLocal)
   if isLocal then
      InsertIntoTycoonEvent:FireClient(Player, model, TouchFunction, ClickFunction)   
   else
      local sTab = stats.getSTab(Player)
      local ModelClone = model:Clone()
      putInTycoonModelHelper(sTab, sTab.TycoonModel, ModelClone)
      if TouchFunction then
         -- print("Connecting touch function.")
         ModelClone.TouchPart.Touched:connect(TouchFunction)
      end
      if ClickFunction then
         -- print("Connecting click function")
         ModelClone.TouchPart.ClickDetector.MouseClick:connect(ClickFunction)
      end
   end
end
function stats.getSTab(Player)
   local sTab = nil
   for _,maybeSTab in ipairs(stats) do
      if maybeSTab.Owner == Player then
         sTab = maybeSTab
      end
   end
   if not sTab then 
      warn("Trying to request non existent sTab of player:") 
      warn(Player.Name) 
      error() 
   end
   return sTab
end
print("Stats: ready.")
return stats
