local Players = game:GetService("Players")
local Player = Players.LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()  -- Waits if the character hasn’t spawned yet

function AutoFish()
    while getgenv().AutoFish do
        task.wait()
        local IsCatching = Character:GetAttribute("Catching")

        if not IsCatching then
            repeat
                task.wait()
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("Old Fishing Rod").Replicator:FireServer({
                    ["Action"] = "Attack",
                    ["Data"] = { ["Alpha"] = 1, ["ResponseTime"] = 0 }
                })
                IsCatching = Character:GetAttribute("Catching")
            until Character:GetAttribute("Catching") == true
        end

        if Character:GetAttribute("Catching") then
            repeat
                task.wait()
                game:GetService("ReplicatedStorage").Events.FishPull:FireServer("Right")
                IsCatching = Character:GetAttribute("Catching")
            until not Character:GetAttribute("Catching")
        end
    end
end


function AutoSell()
    while getgenv().AutoSell == true do
        local Grabs = workspace.Grab
        local Player = Players.LocalPlayer 

        for i, v in pairs(Grabs:GetChildren()) do
            if v:FindFirstChild("Owner").Value == Player.Name then
                if v:IsA("Part") then
                    v.CFrame = "1438.62952, -0.33783555, 178.035141, 0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, 0.499959469"
                        workspace.Map.Structures.Nova_Sellary.TalkPart.Interact:FireServer("Deal", 1)
                end
            end
        end
        task.wait() 
    end
end

local AuraIS = loadstring(game:HttpGet("https://raw.githubusercontent.com/2863862963872963/2862763762763819374946311/refs/heads/main/Agoodo82726277.lua"))()

local Library = AuraIS:CreateLibrary({
    Name = "", -- Name
    Icon = "rbxassetid://12974454446" -- Icon
})

local MainTab = Library:CreateTab("Main", "rbxassetid://12974454446")


local StuffSelection = MainTab:CreateSection("Stuff" , "Normal")

local AutoSellTog = StuffSelection:CreateToggle("Radio", {
    Name = "Auto Sell 💲",
    Callback = function(Value)
            getgenv().AutoSell = Value
            if Value == true then
                AutoSell()
            end
    end,
})

local FishSeclection = MainTab:CreateSection("Fishing" , "Normal")

local AutoFishTog = FishSeclection:CreateToggle("Radio", {
    Name = "Auto Fish 🐟",
    Callback = function(Value)
            getgenv().AutoFish = Value
            if Value == true then
                AutoFish()
            end
    end,
})
