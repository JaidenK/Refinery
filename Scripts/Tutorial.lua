local Tutorial = {
   Frame = nil,
   Gui = nil,
   Player = nil
}
local machines = require(script.Parent.Machines)
local stats = require(script.Parent.Stats)

function updateText(message)
   Tutorial.Frame.Visible = false
   wait()
   Tutorial.Frame.Visible = true
   Tutorial.Frame.MainText.Text = message
end

function moveCursor(Player, BuyModel)
   local sTab = stats.getSTab(Player)
   game.ReplicatedStorage.TutorialArrowEvent:FireClient(Player,sTab.TycoonModel,BuyModel and BuyModel.Name or nil)
end

function Tutorial.giveTutorial(Player)
   Tutorial.Player = Player
   Tutorial.Gui = game.ReplicatedFirst.TutorialGui:Clone()
   Tutorial.Gui.Parent = Player.PlayerGui
   Tutorial.Frame = Tutorial.Gui.Frame
   wait(0.1)
   updateText("You have just purchased an empty plot of land near some oil fields in Texas with plans of building a large and profitable oil refinery. You don't have a whole lot of materials science or business management under your belt, so you can only refine basic products on a small scale to start. The first step to refining anything is to import crude oil. Buy a crude oil pipeline from a local oil drilling company by walking over the red button labeld \"Crude Import.\" TIP: Some buttons can be clicked before buying them to read a description of what they do.")
   moveCursor(Player, machines.CrudeImport[3])
end

function Tutorial.boughtCrudeImport(Player)
   updateText("This crude oil pipeline will carry crude from nearby pumps into your facility, but you still need to refine it into something profitable. All oil refining is centered around distillation, where the crude is boiled and the different products are fractioned. Buy an atmospheric distillation tower to begin distilling the crude oil.")
   moveCursor(Player, machines.AtmosDist[3])
end

function Tutorial.boughtAtmosDist(Player)
   updateText("The crude oil is now being boiled in this tower. Gasoline, jet fuel, lube, asphalt, etc. are all mixed up in there, but you don't know how to grab the good stuff yet. For now, all you can do is let the sludge drain out of the bottom and sell it as low-quality asphalt. Buy asphalt production pipes.")
   moveCursor(Player,machines.Asphalt[3])
end

function Tutorial.boughtAsphalt(Player)
   updateText("The asphalt is now being drained out of the tower, but you need a way to sell it to someone. In the future you might have pipes and trains to deliver your products all across the country, but for now you can only afford trucks that deliver to the local area. Buy a truck loading depot.")
   moveCursor(Player,machines.TruckDepot[3])
end

function Tutorial.boughtTruckDepot(Player)
   updateText("You now have a truck that's filling up with asphalt and delivering it to whatever poor community uses asphalt of this low quality to pave their roads. With this, you're now just barely making a profit off of your crude oil imports. From here, you're on your own to save up money to develop more advanced refining methods.")
   moveCursor(Player,nil)
end

return Tutorial
