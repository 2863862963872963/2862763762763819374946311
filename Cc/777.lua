
game:GetService("Players").LocalPlayer.Character:FindFirstChild("Old Fishing Rod").Replicator:FireServer({["Action"] = "Attack", ["Data"] = { ["Alpha"] = 1, ["ResponseTime"] = 0 }})
game:GetService("ReplicatedStorage").Events.FishPull:FireServer("Right")

local AuraIS = loadstring(game:HttpGet("https://raw.githubusercontent.com/2863862963872963/2862763762763819374946311/refs/heads/main/Agoodo82726277.lua"))()

local Library = AuraIS:CreateLibrary({
    Name = "", -- Name
    Icon = "rbxassetid://12974454446" -- Icon
})

local MainTab = Library:CreateTab("Main", "rbxassetid://12974454446")







local FishSeclection = MainTab:CreateSection("Fishing" , "Normal")




local AutoFishTog = FishSeclection:CreateToggle("Radio", {
    Name = "Auto Fish 🐟",
    Callback = function(Value)
    end,
})
