local pieces = {
   StraightPipe = {
      cost = 10,
      Label = script.StraightPipe,
      -- consider adding a 3rd component to the input coordinate to represent product type.
      inputs = { -- local coordinates Seems that x and y are flipped though.
         {0,1}, -- left
         {0,-1} -- right
      },
      product_id = 0
   },
   AnglePipe = {
      cost = 15,
      Label = script.AnglePipe,
      inputs = {
         {0,1},
         {-1,0}
      },
      product_id = 0
   },
   TPipe = {
      cost = 20,
      Label = script.TPipe,
      inputs = {
         {0,1},
         {1,0},
         {0,-1}
      },
      product_id = 0
   },
   QuadPipe = {
      cost = 25,
      Label = script.QuadPipe,
      inputs = {
         {0,1},
         {0,-1},
         {1,0},
         {-1,0}
      },
      product_id = 0
   }
}
return pieces
