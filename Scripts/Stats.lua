local machines = require(script.Parent.Machines)
local stats = {
   TycoonModel = workspace,
   owner = nil,
   PlayerVariables = nil,
   cash = 1000,
   crudeIntake = 100
}
stats.production = {
   gasoline = 0
}
stats.marketPrice = {
   gasoline = 10
}


-- Puts the variables and data in the player for their GUI to use
function stats.giveVariables()
   local Folder = Instance.new("Folder")
   Folder.Name = "PlayerVariables"

   local NumberValue = Instance.new("NumberValue")
   NumberValue.Name = "Wallet"
   NumberValue.Parent = Folder

   local NumberValue = Instance.new("NumberValue")
   NumberValue.Name = "MarketPriceGasoline"
   NumberValue.Parent = Folder

   local NumberValue = Instance.new("NumberValue")
   NumberValue.Name = "CrudeIntake"
   NumberValue.Parent = Folder

   Folder.Parent = stats.owner.PlayerGui
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
   stats.PlayerVariables.MarketPriceGasoline.Value = stats.marketPrice.gasoline
   stats.PlayerVariables.CrudeIntake.Value = stats.crudeIntake
end
function stats.spendCash( amount )
   assert(stats.cash >= amount,"Insufficient funds.")
   stats.cash = stats.cash - amount
   stats.updatePlayerVariables()
end
return stats
