
local machines = {
--          {cost, full name, buy brick, machine model, production increase}
   AtmosDist = {500, "Atmospheric Distillation", workspace.BuyAtmosDist, workspace.AtmosDist},
   HeavyNaptha = {500, "Heavy Naptha Processing", workspace.BuyHeavyNaptha, workspace.HeavyNapthaAndGasolinePool, 1},
   HNHydrotreater = {100, "Heavy Naptha Hydrotreater", workspace.BuyHNHydrotreater, workspace.HNHydrotreater, 1},
   HNCatalyticReformer = {100, "Heavy Naptha Catalytic Reformer", workspace.BuyHNCatalyticReformer, workspace.HNCatalyticReformer, 1},
   Walls = {100, "Walls", workspace.BuyWalls, workspace.Walls},
   Floor = {100, "Floor", workspace.BuyFloor, workspace.FloorConcrete}
}
return machines
