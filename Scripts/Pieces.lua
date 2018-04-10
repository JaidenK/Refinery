local pieces = {
   StraightPipe = {
      cost = 10,
      Label = script.StraightPipe,
      -- consider adding a 3rd component to the input coordinate to represent product type.
      inputs = { -- local coordinates Seems that x and y are flipped though.
         {0,1}, -- left
         {0,-1} -- right
      }
   }
}
return pieces
