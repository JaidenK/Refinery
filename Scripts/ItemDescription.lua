-- This is a local script inside the PlayerGui. When you click on the
-- red button to buy an item, this will give you a pop up with a
-- description of the item.

game.ReplicatedStorage:WaitForChild("ItemDescriptionEvent").OnClientEvent:connect(function(machine)
   script.Parent.Enabled = true
   script.Parent.Frame.TextLabel.Text = machine[2]
   script.Parent.Frame.MainText.Text = machine[6]
   script.Parent.Frame.ImageFrame.ImageLabel.Image = "rbxassetid://"..(machine[7] and machine[7][1] or 0)
   if machine[7] then
      local ImgFrame = script.Parent.Frame.ImageFrame
      local ImgLabel = ImgFrame.ImageLabel
      local AbsSize = ImgFrame.AbsoluteSize

      local ratioFrame = AbsSize.X/AbsSize.Y
      local ratioSource = machine[7][2]/machine[7][3]

      local scale = 1
      if ratioFrame > ratioSource then
         -- match height
         scale = AbsSize.Y/machine[7][3]
      else
         -- match width
         scale = AbsSize.Y/machine[7][2]
      end
      ImgLabel.Size = UDim2.new(0,machine[7][2]*scale,0,machine[7][3]*scale)
      ImgLabel.Position = UDim2.new(0.5,-machine[7][2]*scale/2,0.5,-machine[7][3]*scale/2)
   else
      script.Parent.Frame.ImageFrame.ImageLabel.Size = UDim2.new(0,0,0,0)
   end
end)

print("ItemDescription: Ready.")
