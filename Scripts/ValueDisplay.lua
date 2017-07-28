local TycoonModel = workspace.Tycoon
local PlayerVariables = workspace.Tycoon:WaitForChild("PlayerVariables")
function WalletValueChanged()
   script.Parent.Wallet.Text = "Wallet: "..PlayerVariables.Wallet.Value
end
function IncomeChanged()
   if TycoonModel:FindFirstChild("MarketControls") then
      local gasolineProduced = math.min(PlayerVariables.Production.Crude.Value,PlayerVariables.Production.Gasoline.Value)
      local income = workspace.MarketPrice.Gasoline.Value * gasolineProduced

      TycoonModel.MarketControls.Monitor.SurfaceGui.Frame.Income.Text = "Income: $"..income
   end
end
function GasolineProdChanged()
   if TycoonModel:FindFirstChild("GasolineControls") then
      TycoonModel.GasolineControls.Monitor.SurfaceGui.Frame.Production.Label.Text = PlayerVariables.Production.Gasoline.Value.." bps"
   end
   IncomeChanged()
end
function GasolineStorageChanged()
   if TycoonModel:FindFirstChild("GasolineControls") then
      local Bar = TycoonModel.GasolineControls.Monitor.SurfaceGui.Frame.StorageMeter.Bar
      local stored = PlayerVariables.Storage.Gasoline.Stored.Value
      local max = PlayerVariables.Storage.Gasoline.Max.Value
      local barHeight = (stored / max) * 100
      Bar.Size = UDim2.new(0,30,0,barHeight)
      Bar.Position = UDim2.new(0,0,0,100-barHeight)
      TycoonModel.GasolineControls.Monitor.SurfaceGui.Frame.Storage.Text = stored.."/"..max
   end
   IncomeChanged()
end
function GasolinePriceChanged()
   if TycoonModel:FindFirstChild("MarketControls") then
      TycoonModel.MarketControls.Monitor.SurfaceGui.Frame.GasolinePrice.Text = "$"..workspace.MarketPrice.Gasoline.Value
   end
   IncomeChanged()
end
function allChanged()
   WalletValueChanged()
   GasolineProdChanged()
   GasolineStorageChanged()
   GasolinePriceChanged()
end
allChanged()
PlayerVariables.Wallet.Changed:connect(WalletValueChanged)
PlayerVariables.Production.Gasoline.Changed:connect(GasolineProdChanged)
PlayerVariables.Storage.Gasoline.Stored.Changed:connect(GasolineStorageChanged)
PlayerVariables.Storage.Gasoline.Max.Changed:connect(GasolineStorageChanged)
workspace.MarketPrice.Gasoline.Changed:connect(GasolineStorageChanged)
TycoonModel.ChildAdded:connect(allChanged)

