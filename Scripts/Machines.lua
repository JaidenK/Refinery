
local machines = {
--          {cost, full name, buy brick, machine model, production increase}
   AtmosDist = {500, "Atmospheric Distillation", workspace.BuyAtmosDist, workspace.AtmosDist},

   HeavyNaphtha = {100, "Heavy Naphtha Processing", workspace.BuyHeavyNaphtha, workspace.HeavyNaphthaAndGasolinePool, 1},
   HNHydrotreater = {200, "Heavy Naphtha Hydrotreater", workspace.BuyHNHydrotreater, workspace.HNHydrotreater, 1},
   HNCatalyticReformer = {300, "Heavy Naphtha Catalytic Reformer", workspace.BuyHNCatalyticReformer, workspace.HNCatalyticReformer, 1},

   LightNaphtha = {100, "Light Naphtha Processing", workspace.BuyLightNaphtha, workspace.LightNaphthaPipe, 1},
   LNHydrotreater = {200, "Light Naphtha Hydrotreater", workspace.BuyLNHydrotreater, workspace.LNHydrotreater, 1},
   LNIsoPlant = {300, "Light Naphtha Isomerization Plant", workspace.BuyLNIsoPlant, workspace.LNIsoPlant, 1},

   GasolineStorage = {100, "Gasoline Storage", workspace.BuyGasolineStorage, workspace.GasolineStorage, 50},

   ControlRoom = {100, "Control Room", workspace.BuyControlRoom, workspace.ControlRoom},
   GasolineControls = {100, "Gasoline Controls", workspace.BuyGasolineControls, workspace.GasolineControls},
   MarketControls = {100, "Market Controls", workspace.BuyMarketControls, workspace.MarketControls},

   Walls = {100, "Walls", workspace.BuyWalls, workspace.Walls},
   Floor = {100, "Floor", workspace.BuyFloor, workspace.FloorConcrete}
}
return machines
