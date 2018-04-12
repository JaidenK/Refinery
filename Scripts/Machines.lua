local buyFuncs = require(script.Parent.BuyFuncs)

local machines = {
   -- {
   --    cost,
   --    full name,
   --    buy brick, 
   --    machine model, 
   --    production increase, 
   --    description, 
   --    {
   --       desc. img. id, 
   --       img width, 
   --       img height
   --    },
   --    buyFunc
   -- }
   AtmosDist = {
      500, 
      "Atmospheric Distillation", 
      workspace.BuyAtmosDist, 
      workspace.AtmosDist, 
      nil, 
      "Atmospheric distillation towers are where the crude is seperated "..
      "into different fractions based on their boiling points. Boiling crude "..
      "oil is pumped into the tower near the bottom, and it rises due to "..
      "heat. As it rises, it cools, and different fractions will settle "..
      "out due to their different boiling points. By placing many trays "..
      "inside the tower, it's possible to capture these different fractions "..
      "at various heights inside the tower. The fractions will be further "..
      "processed into things like fuel, asphalt, lubricants, plastics, etc.", 
      {1581633081, 144, 265}
   },

   HeavyNaphtha = {
      100,
      "Heavy Naphtha Processing",
      workspace.BuyHeavyNaphtha,
      workspace.HeavyNaphthaAndGasolinePool,
      1
   },

   HNHydrotreater = {
      200,
      "Heavy Naphtha Hydrotreater",
      workspace.BuyHNHydrotreater,
      workspace.HNHydrotreater,
      1
   },

   HNCatalyticReformer = {
      300,
      "Heavy Naphtha Catalytic Reformer",
      workspace.BuyHNCatalyticReformer,
      workspace.HNCatalyticReformer,
      1
   },

   
   LightNaphtha = {
      100,
      "Light Naphtha Processing",
      workspace.BuyLightNaphtha,
      workspace.LightNaphthaPipe,
      1
   },

   LNHydrotreater = {
      200,
      "Light Naphtha Hydrotreater",
      workspace.BuyLNHydrotreater,
      workspace.LNHydrotreater,
      1
   },

   LNIsoPlant = {
      300,
      "Light Naphtha Isomerization Plant",
      workspace.BuyLNIsoPlant,
      workspace.LNIsoPlant,
      1
   },

   
   Asphalt = {
      100,
      "Asphalt Processing",
      workspace.BuyAsphalt,
      workspace.AsphaltPipe,
      1,
      ""
   },

   
   GasolineStorage = {
      100,
      "Gasoline Storage",
      workspace.BuyGasolineStorage,
      workspace.GasolineStorage,
      50
   },

   
   TruckDepot = {
      100,
      "Truck Depot",
      workspace.BuyTruckDepot,
      workspace.TruckDepot,
      10
   },

   CrudeImport = {
      100,
      "Crude Import",
      workspace.BuyCrudeImport,
      workspace.CrudePipe,
      10,
      "You've cut a deal with a nearby oil drilling company, and they're "..
      "willing to send you a small amount of crude oil to get your refinery "..
      "started. All you have to do is pay to set up the pipes and the crude "..
      "will start flowing.",
      {1581752829, 200, 200}
   },

   
   ControlRoom = {
      100,
      "Control Room",
      workspace.BuyControlRoom,
      workspace.ControlRoom,
      nil,
      "A control room gives you access to production statistics and advanced "..
      "management controls. Currently you're constantly selling your product "..
      "for whatever people are buying it for, but with this admin building "..
      "you can monitor prices and storage."
   },

   GasolineControls = {
      100,
      "Gasoline Controls",
      workspace.BuyGasolineControls,
      workspace.GasolineControls
   },

   MarketControls = {
      100,
      "Market Controls",
      workspace.BuyMarketControls,
      workspace.MarketControls,
      nil
   },

   
   Walls = {
      100,
      "Walls",
      workspace.BuyWalls,
      workspace.Walls,
      nil,
      "Walls surround your refinery and prevent people from accidentally "..
      "wandering onto your property. This is the first tier of security "..
      "for your refinery.",
      nil,
      buyFuncs.buyWalls
   },

   Floor = {
      100,
      "Floor",
      workspace.BuyFloor,
      workspace.FloorConcrete,
      nil,
      "The refinery is currently built on a plot of dirt. Paving the property "..
      "with concrete will make the place look cleaner and reduce maintanence "..
      "costs on the machines."
   }
}
print("Machines: ready.")
return machines
