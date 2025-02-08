local Console = {}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Console Frame (Main Window)
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
ConsoleFrame.Position = UDim2.new(0.25, 0, 0.05, 0)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConsoleFrame.BorderSizePixel = 0
ConsoleFrame.Visible = false -- Start hidden
ConsoleFrame.Parent = ScreenGui

-- Top Bar (Draggable & Clear Button)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0.1, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TopBar.BorderSizePixel = 0
TopBar.Parent = ConsoleFrame

-- Clear Button
local ClearButton = Instance.new("TextButton")
ClearButton.Size = UDim2.new(0.15, 0, 1, 0)
ClearButton.Position = UDim2.new(0.85, 0, 0, 0)
ClearButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ClearButton.Text = "Clear"
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.Parent = TopBar

-- Scrollable Log Frame
local LogFrame = Instance.new("ScrollingFrame")
LogFrame.Size = UDim2.new(1, 0, 0.9, 0)
LogFrame.Position = UDim2.new(0, 0, 0.1, 0)
LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogFrame.ScrollBarThickness = 5
LogFrame.BackgroundTransparency = 1
LogFrame.Parent = ConsoleFrame

-- UIListLayout for Logs
local LogList = Instance.new("UIListLayout")
LogList.Parent = LogFrame
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

-- Dragging Logic
local dragging
local dragInput
local dragStart
local startPos

local function onInputBegan(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ConsoleFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end

local function onInputChanged(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ConsoleFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end

TopBar.InputBegan:Connect(onInputBegan)
UserInputService.InputChanged:Connect(onInputChanged)

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
    Label.Size = UDim2.new(1, 0, 0, 15)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = color
    Label.Text = msg
    Label.TextScaled = false
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Code
    Label.Parent = LogFrame

    -- Update Canvas Size for Scrolling
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, LogList.AbsoluteContentSize.Y)
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
    for _, v in pairs(LogFrame:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end

-- Console Toggle Function
local ConsoleVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    ConsoleVisible = not ConsoleVisible
    ConsoleFrame.Visible = ConsoleVisible
end)

-- Clear Logs When Clicking Clear Button
ClearButton.MouseButton1Click:Connect(function()
    Console:clear()
end)

return Console
