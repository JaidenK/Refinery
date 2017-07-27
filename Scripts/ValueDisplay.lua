local WalletValue = script.Parent.Parent:WaitForChild("PlayerVariables").Wallet
function WalletValueChanged()
   script.Parent.Wallet.Text = "Wallet: "..WalletValue.Value
end
WalletValueChanged()
WalletValue.Changed:connect(WalletValueChanged)


