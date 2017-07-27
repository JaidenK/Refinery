
local machines = {
--          {cost, full name, buy brick, machine model, production increase}
   AtmosDist = {500, "Atmospheric Distillation", workspace.BuyAtmosDist, workspace.AtmosDist},

   HeavyNaphtha = {500, "Heavy Naphtha Processing", workspace.BuyHeavyNaphtha, workspace.HeavyNaphthaAndGasolinePool, 1},
   HNHydrotreater = {100, "Heavy Naphtha Hydrotreater", workspace.BuyHNHydrotreater, workspace.HNHydrotreater, 1},
   HNCatalyticReformer = {100, "Heavy Naphtha Catalytic Reformer", workspace.BuyHNCatalyticReformer, workspace.HNCatalyticReformer, 1},

   LightNaphtha = {500, "Light Naphtha Processing", workspace.BuyLightNaphtha, workspace.LightNaphthaPipe, 1},
   LNHydrotreater = {100, "Light Naphtha Hydrotreater", workspace.BuyLNHydrotreater, workspace.LNHydrotreater, 1},
   LNIsoPlant = {100, "Light Naphtha Isomerization Plant", workspace.BuyLNIsoPlant, workspace.LNIsoPlant, 1},

   ControlRoom = {100, "Control Room", workspace.BuyControlRoom, workspace.ControlRoom},
   GasolineControls = {100, "Gasoline Controls", workspace.BuyGasolineControls, workspace.GasolineControls},

   Walls = {100, "Walls", workspace.BuyWalls, workspace.Walls},
   Floor = {100, "Floor", workspace.BuyFloor, workspace.FloorConcrete}
}
return machines
