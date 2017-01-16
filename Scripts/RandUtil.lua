local weld = Instance.new("Motor6D")
weld.Parent = workspace.Fans.HumanoidRootPart
weld.Part0 = workspace.Fans.HumanoidRootPart
weld.Part1 = workspace.Fans.Part1





function changeLight(obj)
   for _,v in pairs(obj:GetChildren()) do
      changeLight(v)
      if v.Name == "LightScript" then
         workspace.LightScript2:Clone().Parent = v.Parent
         v:Destroy()
      end
   end
end
changeLight(workspace)