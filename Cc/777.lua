local Players = game:GetService("Players")
local Player = Players.LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()

local SelectingStar;
local SelectingMap;

local Stars = {}
for i, v in pairs(workspace.Server.Stars:GetChildren()) do
    table.insert(Stars, v.Name)
end

local Maps = {}
for i, v in pairs(workspace.Server.Enemies:GetChildren()) do
    table.insert(Maps, v.Name)
end

local Pets = workspace.Server.Pets:GetChildren()

for _, pet in pairs(Pets) do
    local playerName, id = pet.Name:match("^(.-)%-%-%-([%w%-]+)$")
    if playerName and id then
        print("Player Name:", playerName, "ID:", id)
    end
end

function TP(targetCFrame)
    local humanoidRootPart = Character:WaitForChild("HumanoidRootPart", 5)
    if humanoidRootPart then
        local antifall = Instance.new("BodyVelocity", humanoidRootPart)
        antifall.Velocity = Vector3.new(0, 0, 0)
        antifall.MaxForce = Vector3.new(100000, 100000, 100000)
        humanoidRootPart.CFrame = targetCFrame
        antifall:Destroy()
    end
end

function AutoClick() 
    while getgenv().AutoClick do task.wait()
        game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer("Enemies", "World", "Click")
    end
end

function AutoOpenStar()
    while getgenv().AutoOpenStar do
        task.wait()
        if SelectingStar == nil or SelectingStar == "" then
            Notify("Star Open Notify!", "You haven't selected any star", 1)
            AutoOpenStarTog:SetValue(False)
            break
        end
        for i, v in pairs(workspace.Server.Stars:GetChildren()) do
            if v.Name == SelectingStar and v:FindFirstChild("Coins") then
                repeat
                    TP(v.Coins.Star.CFrame * CFrame.new(0, -8, 0))
                    
                    local args = {
                        [1] = "General",
                        [2] = "Stars",
                        [3] = "Open",
                        [4] = SelectingStar,
                        [5] = "Coins"
                    }
                    game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer(unpack(args))
                    
                    task.wait()  
                until not v:FindFirstChild("Coins") or not getgenv().AutoOpenStar
            end
        end
    end
end

function AutoReequip()
    while getgenv().AutoReequip do task.wait(300)
        game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer("General", "Pets", "Equip_Best")
    end
end


local AuraIS = loadstring(game:HttpGet("https://raw.githubusercontent.com/2863862963872963/2862763762763819374946311/refs/heads/main/Agoodo82726277.lua"))()

local Library = AuraIS:CreateLibrary({
    Name = "",
    Icon = "rbxassetid://12974454446"
})

function Notify(Title1, Content1, Duration1)
    local success, err = pcall(function()
        Library:Notify({
            Title = Title1,
            Content = Content1,
            Duration = Duration1,
            Image = "rbxassetid://4483362458",
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        
                    end
                }
            },
        })
    end)
    
    if not success then
        warn("Notify function failed: " .. tostring(err))
    end
end

local MainTab = Library:CreateTab("Main", "rbxassetid://12974454446")
local EggTab = Library:CreateTab("Egg", "rbxassetid://12974454446")

local ConfigSelection = MainTab:CreateSection("Config", "Normal")

local AutoClickTog = ConfigSelection:CreateToggle("Radio", {
    Name = "Auto Click",
    Callback = function(Value)
        getgenv().AutoClick = Value
        if Value == true then
            AutoClick() 
        end
    end,
})

local AutoReEquipTog = ConfigSelection:CreateToggle("Radio", {
    Name = "Auto Re-Equip Every 5mins",
    Callback = function(Value)
        getgenv().AutoReequip = Value
        if Value == true then
            AutoReequip()
        end
    end,
})

local FarmSelection = MainTab:CreateSection("Farm 💲", "Normal")
local MapDropDown = FarmSelection:CreateDropdown({
    Name = "Map",
    Options = Maps,
    CurrentOption = {""},
    MultipleOptions = false,
    Flag = "MapsDD",
    Callback = function(v)
        SelectingMap = v
        print("Selecting Map:", SelectingMap)
    end,
})

local EggSelection = EggTab:CreateSection("Egg", "Normal")

local EggDropDown = EggSelection:CreateDropdown({
    Name = "Stars",
    Options = Stars,
    CurrentOption = {""},
    MultipleOptions = false,
    Flag = "StarsDD",
    Callback = function(v)
        SelectingStar = v
        print("Selecting Star:", SelectingStar)
    end,
})

local AutoOpenStarTog = EggSelection:CreateToggle("Radio", {
    Name = "Open Star",
    Callback = function(Value)
        getgenv().AutoOpenStar = Value
        if Value == true then
            AutoOpenStar()
        end
    end,
})
