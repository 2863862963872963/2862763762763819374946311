local Console = {}

-- Create Console UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:FindFirstChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.5, 0, 0.4, 0)
Frame.Position = UDim2.new(0.25, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Visible = false
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Console"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = Frame

local LogBox = Instance.new("ScrollingFrame")
LogBox.Size = UDim2.new(1, 0, 0.9, 0)
LogBox.Position = UDim2.new(0, 0, 0.1, 0)
LogBox.CanvasSize = UDim2.new(0, 0, 0, 0)
LogBox.BackgroundTransparency = 1
LogBox.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = LogBox
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Mobile Toggle Button
local MobileToggle = Instance.new("TextButton")
MobileToggle.Size = UDim2.new(0.15, 0, 0.05, 0)
MobileToggle.Position = UDim2.new(0.825, 0, 0, 10)
MobileToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MobileToggle.Text = "📜 Console"
MobileToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileToggle.Font = Enum.Font.SourceSansBold
MobileToggle.TextSize = 14
MobileToggle.Parent = ScreenGui

-- Log function
local function logMessage(text, color)
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, 0, 0, 20)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Text = text
    LogLabel.TextColor3 = color
    LogLabel.Font = Enum.Font.SourceSans
    LogLabel.TextSize = 14
    LogLabel.TextWrapped = true
    LogLabel.Parent = LogBox
    LogBox.CanvasSize = UDim2.new(0, 0, 0, LogBox.UIListLayout.AbsoluteContentSize.Y)
end

Console.print = function(...)
    logMessage("[LOG] " .. table.concat({...}, " "), Color3.fromRGB(0, 255, 0))
end

Console.warn = function(...)
    logMessage("[WARN] " .. table.concat({...}, " "), Color3.fromRGB(255, 255, 0))
end

Console.error = function(...)
    logMessage("[ERROR] " .. table.concat({...}, " "), Color3.fromRGB(255, 0, 0))
end

Console.clear = function()
    for _, child in pairs(LogBox:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

-- Toggle visibility
local toggleKey = Enum.KeyCode.F2
local isVisible = false

local function toggleConsole()
    isVisible = not isVisible
    Frame.Visible = isVisible
end

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == toggleKey then
        toggleConsole()
    end
end)

CloseButton.MouseButton1Click:Connect(toggleConsole)
MobileToggle.MouseButton1Click:Connect(toggleConsole)

Console:print("Console Loaded! Press F2 or tap the 📜 button to toggle.")

return Console
