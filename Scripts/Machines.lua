
local machines = {
--          {cost, full name, buy brick, machine model, production increase}
   AtmosDist = {500, "Atmospheric Distillation", workspace.BuyAtmosDist, workspace.AtmosDist},

   HeavyNaptha = {500, "Heavy Naptha Processing", workspace.BuyHeavyNaptha, workspace.HeavyNapthaAndGasolinePool, 1},
   HNHydrotreater = {100, "Heavy Naptha Hydrotreater", workspace.BuyHNHydrotreater, workspace.HNHydrotreater, 1},
   HNCatalyticReformer = {100, "Heavy Naptha Catalytic Reformer", workspace.BuyHNCatalyticReformer, workspace.HNCatalyticReformer, 1},

   LightNaptha = {500, "Light Naptha Processing", workspace.BuyLightNaptha, workspace.LightNapthaPipe, 1},
   LNHydrotreater = {100, "Light Naptha Hydrotreater", workspace.BuyLNHydrotreater, workspace.LNHydrotreater, 1},
   LNIsoPlant = {100, "Light Naptha Isomerization Plant", workspace.BuyLNIsoPlant, workspace.LNIsoPlant, 1},

   Walls = {100, "Walls", workspace.BuyWalls, workspace.Walls},
   Floor = {100, "Floor", workspace.BuyFloor, workspace.FloorConcrete}
}
return machines
