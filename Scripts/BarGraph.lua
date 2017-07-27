local Bar = script.Parent.Bar
local RightEdge = script.Parent.RightEdge
function NewBar() 
   local NewBar = Bar:Clone()
   NewBar.Visible = true
   return NewBar
end

local value = 50
local trend = 0
local maxValue = 100
local currBar = RightEdge.Bar
local lastBar = currBar
while lastBar:FindFirstChild("Bar") do
   lastBar = lastBar.Bar
end

while wait(.2) do
   local change = math.random(-2,2)
   trend = trend + change
   value = value + trend
   value = math.min(value,100)
   value = math.max(value,0)
   if value == 0 or value == 100 then trend = 0 end
   local newBar = NewBar()
   newBar.Size = UDim2.new(0,10,0,maxValue - value)
   newBar.Parent = RightEdge
   currBar.Parent = newBar
   currBar = newBar

   local oldLastBar = lastBar
   lastBar = lastBar.Parent
   oldLastBar:Destroy()
end
