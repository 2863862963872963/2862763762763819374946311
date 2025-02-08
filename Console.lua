local Console = {}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Console Frame
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
ConsoleFrame.Position = UDim2.new(0.25, 0, -0.35, 0) -- Hidden at start
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.Parent = ScreenGui

-- UIListLayout for Logs
local LogList = Instance.new("UIListLayout")
LogList.Parent = ConsoleFrame
LogList.FillDirection = Enum.FillDirection.Vertical
LogList.SortOrder = Enum.SortOrder.LayoutOrder

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
ToggleButton.Position = UDim2.new(0.45, 0, 0.05, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Text = "📜 Console"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui



-- Convert Any Data Type to String
local function toString(...)
    local args = {...}
    for i = 1, #args do
        if typeof(args[i]) == "table" then
            args[i] = HttpService:JSONEncode(args[i]) -- Convert table to JSON string
        else
            args[i] = tostring(args[i]) -- Convert everything else to string
        end
    end
    return table.concat(args, " ")
end

-- Function to Log Messages
local function logMessage(msg, color)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = color
    Label.Text = msg
    Label.TextScaled = true
    Label.Font = Enum.Font.Code
    Label.Parent = ConsoleFrame
end

-- Console Functions
function Console:print(...)
    logMessage("[LOG] " .. toString(...), Color3.fromRGB(0, 255, 0))
end

function Console:warn(...)
    logMessage("[WARN] " .. toString(...), Color3.fromRGB(255, 255, 0))
end

function Console:error(...)
    logMessage("[ERROR] " .. toString(...), Color3.fromRGB(255, 0, 0))
end

function Console:clear()
    for _, v in pairs(ConsoleFrame:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
end

-- Console Toggle Function
local ConsoleVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    ConsoleVisible = not ConsoleVisible
    ConsoleFrame.Position = ConsoleVisible and UDim2.new(0.25, 0, 0.05, 0) or UDim2.new(0.25, 0, -0.35, 0)
        Console:print("ok")
end)

return Console
