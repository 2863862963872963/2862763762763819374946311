local Console = {}

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:FindFirstChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Console UI
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.5, 0, 0.4, 0)
Frame.Position = UDim2.new(0.25, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Visible = false
Frame.Parent = ScreenGui

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Console"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = Frame

-- Log Box (Scrolling Frame)
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

-- Function to Convert Values to String
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
    Label.TextScaled = false
    Label.TextWrapped = true
    Label.Font = Enum.Font.Code
    Label.Parent = LogBox

    -- Update Scrolling
    LogBox.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)

    -- Auto-remove after 10 seconds
    task.delay(10, function()
        Label:Destroy()
        LogBox.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end)
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
    for _, v in pairs(LogBox:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    LogBox.CanvasSize = UDim2.new(0, 0, 0, 0) -- Reset Scroll
end

-- Toggle Console Visibility
local isVisible = false
local function toggleConsole()
    isVisible = not isVisible
    Frame.Visible = isVisible
end

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F2 then
        toggleConsole()
    end
end)

CloseButton.MouseButton1Click:Connect(toggleConsole)
MobileToggle.MouseButton1Click:Connect(toggleConsole)

Console:print("Console Loaded! Press F2 or tap the 📜 button to toggle.")

return Console
