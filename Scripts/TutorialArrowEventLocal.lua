-- Recieves the server's command to place a bouncing arrow above a part
-- with a specific name inside the given model. partName is assumed to
-- be the name of a model which has a TouchPart as a child.

local ArrowPart = game.ReplicatedStorage:WaitForChild("TutorialArrow")
game.ReplicatedStorage:WaitForChild("TutorialArrowEvent").OnClientEvent:connect(function(Model, partName)
   if not (Model and partName) then
      print("TutorialArrowEvent: No Model or partName given. Destroying arrow.")
      ArrowPart:Destroy()
   else
      print("TutorialArrowEvent: Moving arrow to "..partName)
      
      local Part = nil
      for _,Child in pairs(Model:GetChildren()) do
         if Child.Name == partName then
            Part = Child.TouchPart
         end
      end
      if Part then
         ArrowPart.Parent = workspace
         ArrowPart.CFrame = Part.CFrame
      else
         warn("TutorialArrowEvent: Could not find part "..partName)
      end
   end
end)
print("TutorialArrowEventLocal: ready.")
