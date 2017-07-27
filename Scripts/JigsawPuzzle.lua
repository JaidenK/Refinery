local gridRef = script["(0,0)"]
local grid = {}
local activeFrames = {}
local pieces = require(script.Pieces)
local currentRotation = 1
local currentPiece = pieces.t
local currentPos = {0,0}
local isCurrentPosValid = true

function movePiece()
   for i,gridPos in ipairs(activeFrames) do
      gridPos[1].BackgroundColor3 = gridPos[2]
   end
   activeFrames = {}
   local color = Color3.new(0,1,0)
   isCurrentPosValid = true
   for i,v in ipairs(currentPiece[currentRotation]) do
      activeFrames[i] = grid[currentPos[1]+v[1]][currentPos[2]+v[2]]
      if activeFrames[i][3] == 1 then
         color = Color3.new(1,0,0)
         isCurrentPosValid = false
      end
   end
   for i,gridPos in ipairs(activeFrames) do
      gridPos[1].BackgroundColor3 = color
   end
end
for row=0,9 do
   grid[row+1] = {}
   for col=0,9 do
      local newFrame = gridRef:Clone()
      newFrame.Visible = true
      newFrame.Position = UDim2.new(col/10,0,row/10,0)
      newFrame.Name = "("..row..","..col..")"
      newFrame.Parent = script.Parent.Frame
      newFrame.MouseEnter:connect(function()
         currentPos = {row,col}
         movePiece()
      end)
      grid[row+1][col+1] = {newFrame,Color3.new(1,1,1),0}
   end
end

script.Parent.Frame.InputBegan:connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then -- left mouse button down
      assert(isCurrentPosValid,"Invalid position.")
      for i,gridPos in ipairs(activeFrames) do
         gridPos[2] = Color3.new(.05,.05,.05)
         gridPos[1].BackgroundColor3 = gridPos[2]
         gridPos[3] = 1
      end
   else if input.UserInputType == Enum.UserInputType.MouseButton2 and input.UserInputState == Enum.UserInputState.Begin then -- Right mouse button down
      currentRotation = currentRotation + 1
      if currentRotation > #currentPiece then 
         currentRotation = 1
      end
      movePiece()
   end
   end
end)
