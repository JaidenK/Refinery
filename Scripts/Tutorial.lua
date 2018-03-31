local Tutorial = {
   Frame = nil,
   Gui = nil,
   Player = nil,
   ArrowPart = game.ReplicatedStorage.TutorialArrow
}
local machines = require(script.Parent.Machines)

function updateText(message)
   Tutorial.Frame.MainText.Text = message
   Tutorial.Gui.Enabled = true
end

function moveCursor(BuyModel)
   if not BuyModel then
      Tutorial.ArrowPart:Destroy()
   else
      Tutorial.ArrowPart.Parent = workspace
      Tutorial.ArrowPart.CFrame = BuyModel.TouchPart.CFrame
   end
end

function Tutorial.giveTutorial(Player)
   Tutorial.Player = Player
   Tutorial.Gui = game.ReplicatedFirst.TutorialGui:Clone()
   Tutorial.Gui.Parent = Player.PlayerGui
   Tutorial.Frame = Tutorial.Gui.Frame

   updateText("You have just purchased an empty plot of land with plans of building a large and profitable oil refinery. You don't have a whole lot of materials science or business management under your belt, so you can only refine basic products on a small scale to start. The first step to refining anything is to import crude oil. Buy a crude oil pipeline from a local oil drilling company.")
   moveCursor(machines.CrudeImport[3])
end

function Tutorial.boughtCrudeImport()
   updateText("This crude oil pipeline will carry crude from nearby pumps into your facility, but you still need to refine it into something profitable. All oil refining is centered around distillation, where the crude is boiled and the different products are fractioned. Buy an atmospheric distillation tower to begin distilling the crude oil.")
   moveCursor(machines.AtmosDist[3])
end

function Tutorial.boughtAtmosDist()
   updateText("The crude oil is now being boiled in this tower. Gasoline, jet fuel, lube, asphalt, etc. are all mixed up in there, but you don't know how to grab the good stuff yet. For now, all you can do is let the sludge drain out of the bottom and sell it as low-quality asphalt. Buy asphalt production pipes.")
   moveCursor(machines.Asphalt[3])
end

function Tutorial.boughtAsphalt()
   updateText("The asphalt is now being drained out of the tower, but you need a way to sell it to someone. In the future you might have pipes and trains to deliver your products all across the country, but for now you can only afford trucks that deliver to the local area. Buy a truck loading depot.")
   moveCursor(machines.TruckDepot[3])
end

function Tutorial.boughtTruckDepot()
   updateText("You now have a truck that's filling up with asphalt and delivering it to whatever poor community uses asphalt of this low quality to pave their roads. With this, you're now just barely making a profit off of your crude oil imports. From here, you're on your own to save up money to develop more advanced refining methods.")
   moveCursor(nil)
end

return Tutorial
