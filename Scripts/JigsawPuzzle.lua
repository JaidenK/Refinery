local gridRef = script:WaitForChild("GridSquare")
local Frame = script.Parent:WaitForChild("Frame"):WaitForChild("ContentFrame")
local Buttons = {
   Straight = script.Parent.Frame:WaitForChild("ButtonFrame"):WaitForChild("StraightPipe"),
   Angle = script.Parent.Frame.ButtonFrame:WaitForChild("AnglePipe"),
   Tee = script.Parent.Frame.ButtonFrame:WaitForChild("TPipe"),
   Quad = script.Parent.Frame.ButtonFrame:WaitForChild("QuadPipe"),
   Move = script.Parent.Frame.ButtonFrame:WaitForChild("MoveButton"),
   Sell = script.Parent.Frame.ButtonFrame:WaitForChild("SellButton"),
   Close = script.Parent.Frame:WaitForChild("CloseButton")
}

local grid = {}
local activeFrames = {}
local pieces = require(script.Pieces)
local currentRotation = 1
local currentPiece = nil -- pieces.StraightPipe
local currentPos = {0,0}
local isCurrentPosValid = true

local MAX_WIDTH = 10
local MAX_HEIGHT = 5

function buildGrid()
   -- Figure out the aspect ratio and scaling factors. The entire window
   -- will have to be scaled so that there's no empty space around the
   -- grid while being as big as possible.
   local AbsSize = Frame.AbsoluteSize
   local WinAbsSize = Frame.Parent.AbsoluteSize
   local containerRatio = AbsSize.X/AbsSize.Y
   local gridRatio = MAX_WIDTH/MAX_HEIGHT

   -- The margin around the contentframe to the edge of the window
   local margin = WinAbsSize - AbsSize
   local newWinAbsSize = nil

   if containerRatio > gridRatio then
      -- match height. Squeeze the container horizontally.
      -- There is a minimum width! I'll settle for a janky looking grid
      -- since this only happens on a minority of displays anyway.
      -- Maybe? Perhaps it happens often on mobile but heck mobile
      -- users.

      -- Calculate the width of the buttons. Could be brute forced, but
      -- let's do it programatically for future proofing. Using
      -- arbitrary button other than close button.
      local buttonWidth = Buttons.Straight.Size.X.Offset
      -- The smallest x pos in the set of Natural numbers. The close
      -- button could throw this off, but I'll assume it's negative
      -- anyway. 
      local lowestNaturalXPos = 999
      for _,Button in pairs(Buttons) do
         local pos = Button.Position.X.Offset
         if pos > 0 and pos < lowestNaturalXPos then
            lowestNaturalXPos = pos
         end
      end
      local marginBetweenButtons = lowestNaturalXPos - buttonWidth
      -- There is one more margin than buttons. 
      local numButtons = #script.Parent.Frame.ButtonFrame:GetChildren()
      local minimumWidth = (numButtons+1) * marginBetweenButtons -- width of all margins
                           + numButtons * buttonWidth -- width of all buttons
      print("numButtons",numButtons)
      print("minimumWidth",minimumWidth)

      local desiredWidth = AbsSize.Y * gridRatio + margin.X
      
      -- Only use desiredWidth if it's bigger than the minimum.
      newWinAbsSize = Vector2.new(
         desiredWidth > minimumWidth and desiredWidth or minimumWidth, 
         WinAbsSize.Y
      )

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
   local cellSize = AbsSize.Y/MAX_HEIGHT
   gridRef.Size = UDim2.new(0,cellSize,0,cellSize)

   print("containerRatio",containerRatio)
   print("gridRatio",gridRatio)

   -- ImgLabel.Size = UDim2.new(0,machine[7][2]*scale,0,machine[7][3]*scale)
   -- ImgLabel.Position = UDim2.new(0.5,-machine[7][2]*scale/2,0.5,-machine[7][3]*scale/2)


   for row=1,MAX_HEIGHT do
      grid[row] = {}
      for col=1,MAX_WIDTH do
         local newCell = gridRef:Clone()
         -- newCell.Visible = true
         -- Using scale instead of offset works as long as width > minwidth.
         newCell.Position = UDim2.new(0,(col-1)*cellSize,0,(row-1)*cellSize)
         -- newCell.Name = "("..row..","..col..")"
         newCell.Parent = Frame

         newCell.MouseEnter:connect(function()
            currentPos = {row,col}
            movePiece()
         end)
         grid[row][col] = {
            newCell,
            Color3.new(1,1,1),
            0
         }
      end
   end
end

function equipPiece(Piece)
   unequipPiece()
   currentPiece = Piece
   currentPiece.Label = Piece.Label:Clone()
end

function unequipPiece()
   if currentPiece then
      currentPiece.Label:Destroy()
      currentPiece = nil
   end
end

function getCurrCell()
   return grid[currentPos[1]][currentPos[2]][1]
end

function movePiece()
   if currentPiece then
      currentPiece.Label.Parent = getCurrCell()
   end


   -- for i,gridPos in ipairs(activeFrames) do
   --    gridPos[1].BackgroundColor3 = gridPos[2]
   -- end
   -- activeFrames = {}
   -- local color = Color3.new(0,1,0)
   -- isCurrentPosValid = true
   -- for i,v in ipairs(currentPiece[currentRotation]) do
   --    activeFrames[i] = grid[currentPos[1]+v[1]][currentPos[2]+v[2]]
   --    if activeFrames[i][3] == 1 then
   --       color = Color3.new(1,0,0)
   --       isCurrentPosValid = false
   --    end
   -- end
   -- for i,gridPos in ipairs(activeFrames) do
   --    gridPos[1].BackgroundColor3 = color
   -- end
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
Frame.MouseLeave:connect(function()
   if currentPiece then
      currentPiece.Label.Parent = nil
   end
end)

Buttons.Straight.MouseButton1Click:connect(function() 
   equipPiece(pieces.StraightPipe)
end)

-- This delay is a hack to allow the Gui to load before resizing it.
-- This should work because the player won't realistically be able to
-- open this Gui within this delay time. This could be changed to allow
-- for less lag during loading, if such optimization is ever somehow
-- needed.
wait(2)
buildGrid()
print("JigsawPuzzle: ready.")
