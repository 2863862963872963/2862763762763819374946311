-- Create a module for the library
local Library = {}

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Library"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.25, 0, 0.25, 0)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "ImageBackground"
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.Position = UDim2.new(0, 0, 0, 0)
imageLabel.Image = "rbxassetid://87338835273192" -- Replace with your image asset ID
imageLabel.ScaleType = Enum.ScaleType.Tile
imageLabel.BackgroundTransparency = 1
imageLabel.Parent = frame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20)
uiCorner.Parent = imageLabel

-- Create the TabBar
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -50, 0, 40) -- Matches the width of the MainFrame, fixed height
TabBar.Position = UDim2.new(0, 25, 1, -40) -- Aligns to the bottom of MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Parent = frame

-- Add UIListLayout to organize tabs
local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)
layout.Parent = TabBar

-- Function to add a tab
function Library:Tab(tabName, tabImage)
    if #TabBar:GetChildren() - 1 >= 8 then
        warn("Cannot add more than 8 tabs!")
        return
    end

    local tab = Instance.new("Frame")
    tab.Name = tabName
    tab.Size = UDim2.new(0, 70, 1, 0) -- Size of each tab
    tab.BackgroundTransparency = 1
    tab.Parent = TabBar

    -- Add the tab image
    local image = Instance.new("ImageLabel")
    image.Name = "TabImage"
    image.Size = UDim2.new(0, 24, 0, 24) -- Fixed size for the icon
    image.Position = UDim2.new(0.5, -12, 0, 5) -- Centered horizontally, offset vertically
    image.Image = tabImage
    image.BackgroundTransparency = 1
    image.Parent = tab

    -- Add the tab name
    local label = Instance.new("TextLabel")
    label.Name = "TabName"
    label.Size = UDim2.new(1, 0, 0, 12) -- Below the image
    label.Position = UDim2.new(0, 0, 0, 30)
    label.Text = tabName
    label.Font = Enum.Font.SourceSans
    label.TextSize = 12
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Parent = tab

    -- Add click functionality (optional)
    tab.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            print(tabName .. " clicked!")
        end
    end)
end

return Library
