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
local currentRotation = 0
local referencePiece = nil
local currentPiece = nil -- pieces.StraightPipe
local currentPos = {0,0}
local isCurrentPosValid = true

local Graph = {}

local MAX_WIDTH = 20
local MAX_HEIGHT = 15

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
            0,
            {} -- The pieces on this grid cell
         }
      end
   end
end

-- Assumes the piece is in a valid spot.
function placePiece()
   -- Check spaces on the inputs. If there is a piece there, check if
   -- the current piece is on that piece's input. If the inputs match,
   -- create the connection.

   if not currentPiece then return end

   -- Warn if a piece already is here.
   local currGrid = getGrid()
   if #currGrid[4] > 0 then
      warn("A piece already exists at ("..currentPos[1]..","..currentPos[2]..")")
   end

   -- Put piece into gride table.
   table.insert(currGrid[4], currentPiece)

   -- test each input pos
   for _,pos in ipairs(currentPiece.inputs) do
      local neighboringGrid = getGrid(pos[1],pos[2])
      -- loop through every piece in the neighboring grid spot.
      if neighboringGrid then 
         for _,piece in ipairs(neighboringGrid[4]) do
            for _,input in ipairs(piece.inputs) do
               if piece.pos[1]+input[1] == currentPos[1] and piece.pos[2]+input[2] == currentPos[2] then
                  connectPiece(piece)
               end
            end
         end
      end
   end
   table.insert(Graph, currentPiece)
   currentPiece = nil
   equipPiece()
   movePiece()
end

function connectPiece(Piece)
   table.insert(Piece.neighbors, currentPiece)
   table.insert(currentPiece.neighbors, Piece)
   print("JigsawPuzzle: Connection made.")
end

function equipPiece()
   unequipPiece()
   currentPiece = {}
   currentPiece.cost = referencePiece.cost
   currentPiece.Label = referencePiece.Label:Clone()
   currentPiece.Label.Parent = nil
   currentPiece.inputs = {}
   for i,v in ipairs(referencePiece.inputs) do
      currentPiece.inputs[i] = v
   end
   currentPiece.pos = {0,0}
   currentPiece.neighbors = {}
   if currentRotation > 0 then
      for i=1,currentRotation/90 do
         rotatePiece(true)
      end
   end
end

function unequipPiece()
   if currentPiece then
      currentPiece.Label:Destroy()
      currentPiece = nil
   end
end

function rotatePiece(suppress)
   if currentPiece then
      -- print("JigsawPuzzle: rotate piece")
      -- Clockwise rotation
      if not suppress then 
         currentRotation = currentRotation + 90 
         if currentRotation >= 360 then
            currentRotation = 0
         end
      end
      currentPiece.Label.Rotation = currentRotation

      local newInputs = {}
      for i,v in ipairs(currentPiece.inputs) do
         local newCoord = {
            v[2],
            -v[1]
         }
         -- print("JigsawPuzzle: ("..v[1]..","..v[2]..") -> ("..newCoord[1]..","..newCoord[2]..")")
         newInputs[i] = newCoord
      end
      currentPiece.inputs = newInputs
   end
end

function getCurrCell()
   local gridPos = getGrid()
   if gridPos then 
      return gridPos[1]
   end
   return nil
end
function getGrid(x, y)
   local newX = currentPos[1] + (x and x or 0)
   local newY = currentPos[2] + (y and y or 0)
   if newX <= MAX_HEIGHT and newY <= MAX_WIDTH then
      return grid[newX][newY]
   end
   return nil
end

function movePiece()
   if currentPiece then
      currentPiece.Label.Parent = getCurrCell()
      currentPiece.pos = currentPos
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

Frame.InputBegan:connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputState == Enum.UserInputState.Begin then -- left mouse button down
--       -- assert(isCurrentPosValid,"Invalid position.")
--       -- for i,gridPos in ipairs(activeFrames) do
--       --    gridPos[2] = Color3.new(.05,.05,.05)
--       --    gridPos[1].BackgroundColor3 = gridPos[2]
--       --    gridPos[3] = 1
--       -- end
      placePiece()
      -- print("JigsawPuzzle: Left click")
   elseif input.UserInputType == Enum.UserInputType.MouseButton2 and input.UserInputState == Enum.UserInputState.Begin then -- Right mouse button down
--    --    currentRotation = currentRotation + 1
--    --    if currentRotation > #currentPiece then 
--    --       currentRotation = 1
--    --    end
--    --    movePiece()
--    -- end
      -- print("JigsawPuzzle: Right click")
      rotatePiece()
   end
end)

game:GetService("UserInputService").InputBegan:Connect(function (Input, GameProcessed)
   if Input.UserInputType == Enum.UserInputType.Keyboard then
      if Input.KeyCode == Enum.KeyCode.R then
         rotatePiece()
      end
   end
end)






Frame.MouseLeave:connect(function()
   if currentPiece then
      currentPiece.Label.Parent = nil
   end
end)

Buttons.Straight.MouseButton1Click:connect(function() 
   referencePiece = pieces.StraightPipe
   equipPiece()
end)
Buttons.Angle.MouseButton1Click:connect(function() 
   referencePiece = pieces.AnglePipe
   equipPiece()
end)
Buttons.Tee.MouseButton1Click:connect(function() 
   referencePiece = pieces.TPipe
   equipPiece()
end)
Buttons.Quad.MouseButton1Click:connect(function() 
   referencePiece = pieces.QuadPipe
   equipPiece()
end)
Buttons.Close.MouseButton1Click:connect(function()
   script.Parent.Enabled = false
end)

-- This delay is a hack to allow the Gui to load before resizing it.
-- This should work because the player won't realistically be able to
-- open this Gui within this delay time. This could be changed to allow
-- for less lag during loading, if such optimization is ever somehow
-- needed.
wait(2)
buildGrid()
print("JigsawPuzzle: ready.")
