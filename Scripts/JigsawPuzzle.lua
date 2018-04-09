local gridRef = script.GridSquare
local Frame = script.Parent.Frame.ContentFrame
local Buttons = {
   Straight = script.Parent.Frame.ButtonFrame.StraightPipe,
   Angle = script.Parent.Frame.ButtonFrame.AnglePipe,
   Tee = script.Parent.Frame.ButtonFrame.TPipe,
   Quad = script.Parent.Frame.ButtonFrame.QuadPipe,
   Move = script.Parent.Frame.ButtonFrame.MoveButton,
   Sell = script.Parent.Frame.ButtonFrame.SellButton,
   Close = script.Parent.Frame.CloseButton
}

local grid = {}
local activeFrames = {}
local pieces = require(script.Pieces)
local currentRotation = 1
local currentPiece = pieces.t
local currentPos = {0,0}
local isCurrentPosValid = true

local MAX_WIDTH = 100
local MAX_HEIGHT = 100


function buildGrid()
   -- figure out the aspect ratio and scaling factors. The entire window
   -- will have to be scaled so that there's no empty space around the
   -- grid
   local AbsSize = Frame.AbsoluteSize
   local WinAbsSize = Frame.Parent.AbsoluteSize
   local containerRatio = AbsSize.X/AbsSize.Y
   local gridRatio = MAX_WIDTH/MAX_HEIGHT

   -- The margin around the contentframe to the edge of the window
   local margin = Frame.Parent.AbsoluteSize - AbsSize

   local scale = 1
   local newWinAbsSize = nil
   if containerRatio > gridRatio then
      -- match height. Squeeze the container horizontally.
      newWinAbsSize = Vector2.new(AbsSize.Y * gridRatio + margin.X, WinAbsSize.Y)
   else
      -- match width. Squeeze the container vertically.
      newWinAbsSize = Vector2.new(WinAbsSize.X, AbsSize.X / gridRatio + margin.Y)
   end
   -- Size/Position was using scale, so update to use offset. This is a
   -- really long comment.
   Frame.Parent.Size = UDim2.new(0,newWinAbsSize.X,0,newWinAbsSize.Y)
   Frame.Parent.Position = UDim2.new(0.5,-newWinAbsSize.X/2,0.5,-newWinAbsSize.Y/2)

   -- once the sizes match, this should be the width/height of a single
   -- square cell
   cellSize = AbsSize.Y/MAX_HEIGHT


   -- ImgLabel.Size = UDim2.new(0,machine[7][2]*scale,0,machine[7][3]*scale)
   -- ImgLabel.Position = UDim2.new(0.5,-machine[7][2]*scale/2,0.5,-machine[7][3]*scale/2)


   -- for row=1,MAX_HEIGHT do
   --    grid[row] = {}
   --    for col=1,MAX_WIDTH do
   --       local newFrame = gridRef:Clone()
   --       newFrame.Visible = true
   --       newFrame.Position = UDim2.new(col/10,0,row/10,0)
   --       newFrame.Name = "("..row..","..col..")"
   --       newFrame.Parent = script.Parent.Frame
   --       newFrame.MouseEnter:connect(function()
   --          currentPos = {row,col}
   --          movePiece()
   --       end)
   --       grid[row][col] = {newFrame,Color3.new(1,1,1),0}
   --    end
   -- end
end

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

-- script.Parent.Frame.InputBegan:connect(function(input)
--    if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then -- left mouse button down
--       assert(isCurrentPosValid,"Invalid position.")
--       for i,gridPos in ipairs(activeFrames) do
--          gridPos[2] = Color3.new(.05,.05,.05)
--          gridPos[1].BackgroundColor3 = gridPos[2]
--          gridPos[3] = 1
--       end
--    else if input.UserInputType == Enum.UserInputType.MouseButton2 and input.UserInputState == Enum.UserInputState.Begin then -- Right mouse button down
--       currentRotation = currentRotation + 1
--       if currentRotation > #currentPiece then 
--          currentRotation = 1
--       end
--       movePiece()
--    end
--    end
-- end)

buildGrid()
