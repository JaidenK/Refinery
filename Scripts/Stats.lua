local machines = require(script.Parent.Machines)
local stats = {
   TycoonModel = workspace.Tycoon,
   owner = nil,
   PlayerVariables = nil,
   cash = 10000,
}
stats.production = {
   crude = 100,
   gasoline = 0
}
stats.storage = {
   gasoline = {stored = 0, max = 0}
}
stats.export = 0


-- Puts the variables and data in the player for their GUI to use
function stats.giveVariables()
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

   Folder.Parent = stats.TycoonModel
   stats.PlayerVariables = Folder
   stats.updatePlayerVariables()
end
function stats.setOwner(Player)
   stats.owner = Player
   Player.CharacterAdded:connect(stats.giveVariables)
   stats.giveVariables()
end
function stats.updatePlayerVariables() 
   stats.PlayerVariables.Wallet.Value = stats.cash
   stats.PlayerVariables.Production.Crude.Value = stats.production.crude
   stats.PlayerVariables.Production.Gasoline.Value = stats.production.gasoline
   stats.PlayerVariables.Storage.Gasoline.Stored.Value = stats.storage.gasoline.stored
   stats.PlayerVariables.Storage.Gasoline.Max.Value = stats.storage.gasoline.max
end
function stats.spendCash( amount )
   assert(stats.cash >= amount,"Insufficient funds.")
   stats.cash = stats.cash - amount
   stats.updatePlayerVariables()
end
return stats
