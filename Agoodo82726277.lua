local a = "Alpha 0.1"
local b = 5
local c = "AuraIS"
local d = c .. "/Configurations"
local e = {
    Flags = {},
    Theme = {
        Dark = {
            TextColor = Color3.fromRGB(240, 240, 240),
            MainColor = Color3.fromRGB(16, 16, 16),
            SecondaryColor = Color3.fromRGB(22, 22, 22),
            NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
            ImageColor = Color3.fromRGB(255, 255, 255),
            TabBackground = Color3.fromRGB(80, 80, 80),
            TabStroke = Color3.fromRGB(85, 85, 85),
            TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
            TabTextColor = Color3.fromRGB(240, 240, 240),
            SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
            SliderColor = Color3.fromRGB(170, 0, 255),
            ToggleEnabled = Color3.fromRGB(170, 0, 255),
            ToggleDisabled = Color3.fromRGB(139, 139, 139),
            CardButton = Color3.fromRGB(230, 230, 230),
            TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint)
        }
    }
}
local f = tostring(math.random(1, 100)) .. tostring(math.random(1, 50)) .. tostring(math.random(1, 100))
function e:DragFunc(g, h)
    h = h or g
    local i = false
    local j, k, l
    g.InputBegan:Connect(
        function(m)
            if m.UserInputType == Enum.UserInputType.MouseButton1 or m.UserInputType == Enum.UserInputType.Touch then
                i = true
                k = m.Position
                l = h.Position
                m.Changed:Connect(
                    function()
                        if m.UserInputState == Enum.UserInputState.End then
                            i = false
                        end
                    end
                )
            end
        end
    )
    g.InputChanged:Connect(
        function(m)
            if m.UserInputType == Enum.UserInputType.MouseMovement or m.UserInputType == Enum.UserInputType.Touch then
                j = m
            end
        end
    )
    game:GetService("UserInputService").InputChanged:Connect(
        function(m)
            if m == j and i then
                local n = m.Position - k
                h.Position = UDim2.new(l.X.Scale, l.X.Offset + n.X, l.Y.Scale, l.Y.Offset + n.Y)
            end
        end
    )
end
function e:TatMoUi()
    if game.CoreGui.UI_Library.Enabled then
        game.CoreGui.UI_Library.Enabled = false
    else
        game.CoreGui.UI_Library..Enabled = true
    end
end
UICorner.Parent = ImageButton
UICorner.CornerRadius = UDim.new(1, 0) 
local o = game:GetService("TextService")
local p = game:GetService("UserInputService")
local q = game:GetService("TweenService")
local r = game:GetService("HttpService")
local s = game:GetService("RunService")
local t = game:GetService("Players")
local u = game:GetService("CoreGui")
local v = t.LocalPlayer:GetMouse()
local w = game:GetObjects("rbxassetid://14742706510")[1]
w.Enabled = false
w.DisplayOrder = 100
if get_hidden_gui or gethui then
    w.Parent = u
else
    w.Parent = u
end
function e:Notify(x, y)
    spawn(
        function()
            local z = y.Duration or b
            local A = w.Notifications[x]:Clone()
            A.Parent = w.Notifications
            A.Name = y.Title or "Unknown Title"
            A.Parent = w.Notifications
            A.Visible = true
            A.Actions.ButtonTemplate.Visible = false
            if y.Actions then
                for B, C in pairs(y.Actions) do
                    local D = A.Actions.ButtonTemplate:Clone()
                    D.Name = C.Name
                    D.Visible = true
                    D.Parent = A.Actions
                    D.Text = C.Name
                    D.Size = UDim2.new(0, D.TextBounds.X + 27, 1, 0)
                    D.MouseButton1Click:Connect(
                        function()
                            local E, F = pcall(C.Callback)
                        end
                    )
                end
            end
            A.Title.Text = y.Title or "Unknown"
            A.Description.Text = y.Content or "Unknown"
            if y.Image then
                A.Icon.Image = y.Image
            end
            while z >= 0 do
                A.Duration.Text = z
                wait(1)
                z = z - 1
            end
            A:Destroy()
        end
    )
end
function e:CreateLibrary(G, H)
    local I = {
        Name = typeof(G) == "table" and G.Name or (typeof(G) == "string" and G or "Undefined"),
        Icon = typeof(G) == "table" and G.Icon or H or "rbxassetid://11432865001"
    }
    w.Enabled = true
    local J = w.Main.SideBar
    local K = J.Buttons
    local L = w.Main.TabContainer
    J.NameText.Text = I.Name
    J.Icon.Image = I.Icon
    e:DragFunc(J, w.Main)
    K.Parent.Minimize.MouseButton1Click:Connect(
        function()
            if K.Parent.Minimize.Rotation == 0 then
                q:Create(K.Parent.Minimize, e.Theme.Dark.TweenInfo, {Rotation = 180}):Play()
                q:Create(K.Parent, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0, 147, 1, 0)}):Play()
                q:Create(L, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0, 349, 0, 326)}):Play()
                q:Create(L, e.Theme.Dark.TweenInfo, {Position = UDim2.new(0.305, 0, 0.021, 0)}):Play()
            else
                q:Create(K.Parent.Minimize, e.Theme.Dark.TweenInfo, {Rotation = 0}):Play()
                q:Create(K.Parent, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0, 55, 1, 0)}):Play()
                q:Create(L, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0, 439, 0, 326)}):Play()
                q:Create(L, e.Theme.Dark.TweenInfo, {Position = UDim2.new(0.13, 0, 0.021, 0)}):Play()
            end
        end
    )
    local M = {}
    function M:Notify(y, N, O, P)
        spawn(
            function()
                w.Main.Notifications.Visible = true
                local z = typeof(y) == "table" and y.Duration or O or b
                local A = w.Main.Notifications.Template
                A.Parent = w.Notifications
                A.Duration.Text = z
                A.Parent = w.Main.Notifications
                A.Visible = true
                for Q, R in pairs(A.Actions:GetChildren()) do
                    if R.Name ~= "ButtonTemplate" and not R:IsA("UIListLayout") then
                        R:Destroy()
                    end
                end
                A.Actions.ButtonTemplate.Visible = false
                if typeof(y) == "table" and y.Actions or P then
                    for B, C in pairs(typeof(y) == "table" and y.Actions or P) do
                        local D = A.Actions.ButtonTemplate:Clone()
                        D.Name = C.Name
                        D.Visible = true
                        D.Parent = A.Actions
                        D.Text = C.Name
                        D.Size = UDim2.new(0, D.TextBounds.X + 27, 1, 0)
                        D.MouseButton1Click:Connect(
                            function()
                                local E, F = pcall(C.Callback)
                            end
                        )
                    end
                end
                A.Title.Text = typeof(y) == "table" and y.Title or y or "Unknown"
                A.Description.Text = typeof(y) == "table" and y.Content or N or "Unknown"
                while z >= 0 do
                    A.Duration.Text = z
                    wait(1)
                    z = z - 1
                end
                w.Main.Notifications.Visible = false
                for Q, R in pairs(A.Actions:GetChildren()) do
                    if R.Name ~= "ButtonTemplate" and not R:IsA("UIListLayout") then
                        R:Destroy()
                    end
                end
            end
        )
    end
    function M:CreateTab(S, H)
        if not S then
            return
        end
        local T = K.Template:Clone()
        T.ImageLabel.Image = typeof(S) == "table" and S.Icon or H or "rbxassetid://11432859220"
        T.TextLabel.Text = typeof(S) == "table" and S.Title or S or "Unknown"
        T.Visible = true
        T.Parent = K
        local U = L.Template:Clone()
        U.Parent = L
        U.Name = typeof(S) == "table" and S.Title or S or "Unknown"
        U.Visible = true
        U.LayoutOrder = #L:GetChildren()
        for B, V in ipairs(U:GetChildren()) do
            if V.ClassName == "Frame" then
                V:Destroy()
            end
        end
        T.MouseButton1Click:Connect(
            function()
                for B, W in ipairs(L:GetChildren()) do
                    if W.Name ~= "Template" and W.ClassName == "Frame" and W ~= T then
                    end
                end
                if L.UIPageLayout.CurrentPage ~= U then
                    L.UIPageLayout:JumpTo(U)
                end
            end
        )
        local X = {}
        function X:CreateSection(Y, Z)
            local _ = {}
            local a0
            if Z == "Normal" then
                a0 = L.Template.SectionTitle:Clone()
                a0.Name = Y
                a0.Title.Text = Y
                a0.Visible = true
                a0.Parent = U
            elseif Z == "Foldable" then
                a0 = L.Template.FoldableSectionTitle:Clone()
                a0.Name = Y
                a0.Title.Text = Y
                a0.Visible = true
                a0.Parent = U
            end
            a0.Title.TextTransparency = 1
            q:Create(a0.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            function _:SetName(a1)
                a0.Title.Text = a1
            end
            local function a2()
                local a3 = a0.UIListLayout.AbsoluteContentSize
                a0.Size = UDim2.new(1, 0, 0, a3.Y)
            end
            if Z == "Foldable" then
                local a4 = true
                a0.Title.TextButton.MouseButton1Click:Connect(
                    function()
                        if a4 then
                            a4 = false
                            for B, R in ipairs(a0:GetChildren()) do
                                if R.Name ~= "UIListLayout" and R.Name ~= "UIPadding" and not R:IsA("TextLabel") then
                                    R.Visible = false
                                end
                            end
                        else
                            a4 = true
                            for B, R in ipairs(a0:GetChildren()) do
                                if R.Name ~= "UIListLayout" and R.Name ~= "UIPadding" and not R:IsA("TextLabel") then
                                    R.Visible = true
                                end
                            end
                        end
                        a2()
                    end
                )
            end
            function _:CreateButton(a5)
                local a6 = {Func = a5.Callback}
                local a7 = L.Template.Button:Clone()
                a7.Name = a5.Name or "Undefined"
                a7.Title.Text = a5.Name or "Undefined"
                a7.Visible = true
                a7.Parent = a0
                a2()
                a7.Interact.MouseButton1Click:Connect(
                    function()
                        local a8, a9 = pcall(a6.Func)
                        if not a8 then
                            local aa = a7.Size
                            q:Create(a7, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0.992, -10, 0, 35)}):Play()
                            q:Create(a7, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(103, 0, 0)}):Play()
                            a7.Title.Text = "Error occurred"
                            print("[AuraIS]: An error occurred: " .. tostring(a9))
                            wait(0.5)
                            a7.Title.Text = a5.Name
                            q:Create(a7, e.Theme.Dark.TweenInfo, {Size = aa}):Play()
                            q:Create(a7, e.Theme.Dark.TweenInfo, {BackgroundColor3 = e.Theme.Dark.SecondaryColor}):Play(

                            )
                        else
                            local aa = a7.Size
                            q:Create(a7, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0.992, -10, 0, 35)}):Play()
                            wait(0.2)
                            q:Create(a7, e.Theme.Dark.TweenInfo, {Size = aa}):Play()
                        end
                    end
                )
                function a6:SetCallback(ab)
                    a6.Func = ab
                end
                function a6:SetName(ac)
                    a7.Title.Text = ac
                    a7.Name = ac
                end
                return a6
            end
            function _:CreateToggle(ad, ae)
                if ad == "Radio" then
                    local af = {}
                    local ag = L.Template.Toggle_Radio:Clone()
                    local ah = ag.Interact
                    local ai = ag.Switch
                    local aj = ai.Indicator
                    aj.BackgroundTransparency = 1
                    aj.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
                    ag.Name = ae.Name
                    ag.Title.Text = ae.Name
                    ag.Visible = true
                    ag.Parent = a0
                    a2()
                    ag.Interact.MouseButton1Click:Connect(
                        function()
                            if ae.CurrentValue then
                                ae.CurrentValue = false
                                q:Create(aj, e.Theme.Dark.TweenInfo, {BackgroundTransparency = 1}):Play()
                            else
                                ae.CurrentValue = true
                                q:Create(aj, e.Theme.Dark.TweenInfo, {BackgroundTransparency = 0}):Play()
                            end
                            local a8, a9 =
                                pcall(
                                function()
                                    ae.Callback(ae.CurrentValue)
                                end
                            )
                            if not a8 then
                                q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(103, 0, 0)}):Play(

                                )
                                ag.Title.Text = "Error occurred"
                                print("[AuraIS]: An error occurred: " .. tostring(a9))
                                wait(0.5)
                                ag.Title.Text = ae.Name
                                q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = e.Theme.Dark.SecondaryColor}):Play(

                                )
                            end
                        end
                    )
                    return ae
                elseif ad == "Normal" then
                    local af = {}
                    local ag = L.Template.Toggle:Clone()
                    local ah = ag.Interact
                    local ai = ag.Switch
                    local aj = ai.Indicator
                    ag.Name = ae.Name
                    ag.Title.Text = ae.Name
                    ag.Visible = true
                    ag.Parent = a0
                    a2()
                    ag.Interact.MouseButton1Click:Connect(
                        function()
                            if ae.CurrentValue then
                                ae.CurrentValue = false
                                q:Create(aj, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(139, 139, 139)}):Play(

                                )
                                q:Create(aj, e.Theme.Dark.TweenInfo, {Position = UDim2.new(0.07, 0, 0.5, 0)}):Play()
                            else
                                ae.CurrentValue = true
                                q:Create(aj, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(170, 0, 255)}):Play(

                                )
                                q:Create(aj, e.Theme.Dark.TweenInfo, {Position = UDim2.new(0.537, 0, 0.5, 0)}):Play()
                            end
                            local a8, a9 =
                                pcall(
                                function()
                                    ae.Callback(ae.CurrentValue)
                                end
                            )
                            if not a8 then
                                q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(103, 0, 0)}):Play(

                                )
                                ag.Title.Text = "Error occurred"
                                print("[AuraIS]: An error occurred: " .. tostring(a9))
                                wait(0.5)
                                ag.Title.Text = ae.Name
                                q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = e.Theme.Dark.SecondaryColor}):Play(

                                )
                            end
                        end
                    )
                    ag.MouseEnter:Connect(
                        function()
                            q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                            q:Create(ag, e.Theme.Dark.TweenInfo, {Size = UDim2.new(1.011, -10, 0, 40)}):Play()
                        end
                    )
                    ag.MouseLeave:Connect(
                        function()
                            q:Create(ag, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
                            q:Create(ag, e.Theme.Dark.TweenInfo, {Size = UDim2.new(1, -10, 0, 40)}):Play()
                        end
                    )
                    return ae
                end
            end
            function _:CreateColorPicker(ak)
                local al = L.Template.ColorPicker:Clone()
                local am = al.Switch
                local an = al["RGB"]
                local ao = al.Color
                local ap = ao.SliderPoint
                local aq = al.Darkness
                local ar = aq.SliderPoint
                al.Name = ak.Name
                al.Title.Text = ak.Name
                al.Visible = true
                al.Parent = a0
                local as = {1, 1, 1}
                local at = false
                local au = false
                local av
                local aw = ak.Callback
                a2()
                local function ax(ay)
                    return math.acos(math.cos(ay * math.pi)) / math.pi
                end
                counter = 0
                local function az()
                    return game.Players.LocalPlayer:GetMouse()
                end
                local function aA()
                    if at then
                        local aB = math.clamp(v.X - ao.AbsolutePosition.X, 0, ao.AbsoluteSize.X)
                        local aC = math.clamp(v.Y - ao.AbsolutePosition.Y, 0, ao.AbsoluteSize.Y)
                        local aD = math.floor(ao.AbsoluteSize.X)
                        local aE = math.floor(ao.AbsoluteSize.Y)
                        if aB < 0 then
                            aB = 0
                        end
                        if aB > aD then
                            aB = aD
                        end
                        if aC < 0 then
                            aC = 0
                        end
                        if aC > aE then
                            aC = aE
                        end
                        aB = aB / aD
                        aC = aC / aE
                        local aF = ap.AbsoluteSize.X / 2
                        local aG = ap.AbsoluteSize.Y / 2
                        ap.Position = UDim2.new(math.min(aB, 1 - aF / aD), 0, math.min(aC, 1 - aG / aE), 0)
                        as = {1 - aB, 1 - aC, as[3]}
                        local aH = Color3.fromHSV(as[1], as[2], as[3])
                        aw(aH)
                    end
                    if au then
                        local aI = az()
                        local aC = aI.Y - aq.AbsolutePosition.Y
                        local aE = math.floor(ao.AbsoluteSize.Y) - 1
                        if aC < 0 then
                            aC = 0
                        end
                        if aC > aE then
                            aC = aE
                        end
                        aC = aC / aE
                        local aG = ar.AbsoluteSize.Y / 2
                        ar.Position = UDim2.new(0.5, 0, math.min(aC, 1 - aG / aE), 0)
                        ar.ImageColor3 = Color3.fromHSV(0, 0, aC)
                        as = {as[1], as[2], 1 - aC}
                        local aH = Color3.fromHSV(as[1], as[2], as[3])
                        aw(aH)
                    end
                end
                local function aJ(aK)
                    local aF = ap.AbsoluteSize.X / 2
                    local aG = ap.AbsoluteSize.Y / 2
                    as = {aK[1], aK[2], aK[3]}
                    ap.Position = UDim2.new(as[1], -aF, as[2] - 1, -aG)
                    ar.Position = UDim2.new(0.5, 0, as[3] - 1, -aG)
                    local aH = Color3.fromHSV(as[1], as[2], as[3])
                end
                local function aL(aK)
                    local aD = math.floor(ao.AbsoluteSize.X)
                    local aE = math.floor(ao.AbsoluteSize.Y)
                    local aF = ap.AbsoluteSize.X / 2
                    local aG = ap.AbsoluteSize.Y / 2
                    as = {aK[1], aK[2], as[3]}
                    ap.Position = UDim2.new(math.min(as[1], 1 - aF / aE), 0, math.min(as[2] - 1, 1 - aG / aE))
                    local aH = Color3.fromHSV(as[1], as[2], as[3])
                    aw(aH)
                end
                local function aM()
                    if rainbow then
                        q:Create(am.Indicator, e.Theme.Dark.TweenInfo, {BackgroundTransparency = 1}):Play()
                        rainbow = false
                        av:Disconnect()
                    else
                        q:Create(am.Indicator, e.Theme.Dark.TweenInfo, {BackgroundTransparency = 0}):Play()
                        rainbow = true
                        av =
                            game:GetService("RunService").RenderStepped:Connect(
                            function()
                                aL({ax(counter), 1, 1})
                                counter = counter + 0.01
                            end
                        )
                    end
                end
                am:FindFirstChildWhichIsA("TextButton").MouseButton1Click:Connect(aM)
                game.Players.LocalPlayer:GetMouse().Move:connect(aA)
                ao.MouseButton1Down:connect(
                    function()
                        at = true
                    end
                )
                aq.MouseButton1Down:connect(
                    function()
                        au = true
                    end
                )
                p.InputEnded:Connect(
                    function(m)
                        if
                            m.UserInputType == Enum.UserInputType.MouseButton1 or
                                m.UserInputType == Enum.UserInputType.Touch
                         then
                            if au then
                                au = false
                            end
                            if at then
                                at = false
                            end
                        end
                    end
                )
                return ak
            end
            function _:CreateSlider(aN)
                local aO = false
                local aP = L.Template.Slider:Clone()
                aP.Name = aN.Name
                aP.Title.Text = aN.Name
                aP.Title.TextScaled = false
                aP.Visible = true
                aP.Parent = a0
                a2()
                aP.Main.Progress.Size =
                    UDim2.new(
                    0,
                    aP.Main.AbsoluteSize.X * (aN.CurrentValue + aN.Value[1]) / (aN.Value[2] - aN.Value[1]) > 5 and
                        aP.Main.AbsoluteSize.X * aN.CurrentValue / (aN.Value[2] - aN.Value[1]) or
                        5,
                    1,
                    0
                )
                if not aN.Suffix then
                    aP.Main.Information.Text = tostring(aN.CurrentValue)
                else
                    aP.Main.Information.Text = tostring(aN.CurrentValue) .. " " .. aN.Suffix
                end
                aP.Main.Interact.InputBegan:Connect(
                    function(aQ)
                        if
                            aQ.UserInputType == Enum.UserInputType.MouseButton1 or
                                aQ.UserInputType == Enum.UserInputType.Touch
                         then
                            aO = true
                        end
                    end
                )
                aP.Main.Interact.InputEnded:Connect(
                    function(aQ)
                        if
                            aQ.UserInputType == Enum.UserInputType.MouseButton1 or
                                aQ.UserInputType == Enum.UserInputType.Touch
                         then
                            aO = false
                        end
                    end
                )
                aP.Main.Interact.MouseButton1Down:Connect(
                    function(ay)
                        local aR = aP.Main.Progress.AbsolutePosition.X + aP.Main.Progress.AbsoluteSize.X
                        local aS = aR
                        local aT = ay
                        local aU
                        aU =
                            s.Stepped:Connect(
                            function()
                                if aO then
                                    aT = p:GetMouseLocation().X
                                    aR = aT
                                    if aT < aP.Main.AbsolutePosition.X then
                                        aT = aP.Main.AbsolutePosition.X
                                    elseif aT > aP.Main.AbsolutePosition.X + aP.Main.AbsoluteSize.X then
                                        aT = aP.Main.AbsolutePosition.X + aP.Main.AbsoluteSize.X
                                    end
                                    if aR < aP.Main.AbsolutePosition.X + 5 then
                                        aR = aP.Main.AbsolutePosition.X + 5
                                    elseif aR > aP.Main.AbsolutePosition.X + aP.Main.AbsoluteSize.X then
                                        aR = aP.Main.AbsolutePosition.X + aP.Main.AbsoluteSize.X
                                    end
                                    if aR <= aT and aT - aS < 0 then
                                        aS = aT
                                    elseif aR >= aT and aT - aS > 0 then
                                        aS = aT
                                    end
                                    aP.Main.Progress.Size = UDim2.new(0, aR - aP.Main.AbsolutePosition.X, 1, 0)
                                    local aV =
                                        aN.Value[1] +
                                        (aT - aP.Main.AbsolutePosition.X) / aP.Main.AbsoluteSize.X *
                                            (aN.Value[2] - aN.Value[1])
                                    aV = math.floor(aV / aN.Increment + 0.5) * aN.Increment * 10000000 / 10000000
                                    if not aN.Suffix then
                                        aP.Main.Information.Text = tostring(aV)
                                    else
                                        aP.Main.Information.Text = tostring(aV) .. " " .. aN.Suffix
                                    end
                                    if aN.CurrentValue ~= aV then
                                        local E, F =
                                            pcall(
                                            function()
                                                aN.Callback(aV)
                                            end
                                        )
                                        aN.CurrentValue = aV
                                    end
                                else
                                    aP.Main.Progress.Size =
                                        UDim2.new(
                                        0,
                                        aT - aP.Main.AbsolutePosition.X > 5 and aT - aP.Main.AbsolutePosition.X or 5,
                                        1,
                                        0
                                    )
                                    aU:Disconnect()
                                end
                            end
                        )
                    end
                )
                function aN:Set(aW)
                    aP.Main.Progress.Size =
                        UDim2.new(
                        0,
                        aP.Main.AbsoluteSize.X * (aW + aN.Value[1]) / (aN.Value[2] - aN.Value[1]) > 5 and
                            aP.Main.AbsoluteSize.X * aW / (aN.Value[2] - aN.Value[1]) or
                            5,
                        1,
                        0
                    )
                    aP.Main.Information.Text = tostring(aW) .. " " .. aN.Suffix
                    local E, F =
                        pcall(
                        function()
                            aN.Callback(aW)
                        end
                    )
                    aN.CurrentValue = aW
                end
                return aN
            end
            function _:CreateDropdown(aX)
                local aY = L.Template.Dropdown:Clone()
                if string.find(aX.Name, "closed") then
                    aY.Name = "Dropdown"
                else
                    aY.Name = aX.Name
                end
                aY.Title.Text = aX.Name
                aY.Visible = true
                aY.Parent = a0
                aY.Size = UDim2.new(1, -10, 0, 45)
                aY.Interact.Size = UDim2.new(0, 429, 0, 45)
                aY.Interact.Position = UDim2.new(0, 214, 0, 22)
                aY.List.Visible = false
                if typeof(aX.CurrentOption) == "string" then
                    aX.CurrentOption = {aX.CurrentOption}
                end
                if not aX.MultipleOptions then
                    aX.CurrentOption = {aX.CurrentOption[1]}
                end
                if aX.MultipleOptions then
                    if #aX.CurrentOption == 1 then
                        aY.Selected.Text = aX.CurrentOption[1]
                    elseif #aX.CurrentOption == 0 then
                        aY.Selected.Text = "None"
                    else
                        aY.Selected.Text = "Various"
                    end
                else
                    aY.Selected.Text = aX.CurrentOption[1]
                end
                aY.BackgroundTransparency = 1
                aY.UIStroke.Transparency = 1
                aY.Title.TextTransparency = 1
                aY.Size = UDim2.new(1, -10, 0, 45)
                a2()
                q:Create(aY, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                q:Create(aY.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                q:Create(aY.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                for B, aZ in ipairs(aY.List:GetChildren()) do
                    if aZ.ClassName == "Frame" and aZ.Name ~= "Placeholder" then
                        aZ:Destroy()
                    end
                end
                aY.Toggle.Rotation = 180
                aY.Interact.MouseButton1Click:Connect(
                    function()
                        q:Create(aY.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                        wait(0.1)
                        q:Create(aY.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                        if Debounce then
                            return
                        end
                        if aY.List.Visible then
                            Debounce = true
                            local a_ =
                                q:Create(
                                aY,
                                TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                                {Size = UDim2.new(1, -10, 0, 45)}
                            )
                            local b0 =
                                pcall(
                                function()
                                    a_:Play()
                                end
                            )
                            local b1 = false
                            if b0 then
                                b1 = true
                            end
                            spawn(
                                function()
                                    while b1 do
                                        a2()
                                        wait()
                                    end
                                end
                            )
                            a_.Completed:Connect(
                                function()
                                    b1 = false
                                end
                            )
                            for B, b2 in ipairs(aY.List:GetChildren()) do
                                if b2.ClassName == "Frame" and b2.Name ~= "Placeholder" then
                                    q:Create(
                                        b2,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {BackgroundTransparency = 1}
                                    ):Play()
                                    q:Create(
                                        b2.UIStroke,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {Transparency = 1}
                                    ):Play()
                                    q:Create(
                                        b2.Title,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {TextTransparency = 1}
                                    ):Play()
                                end
                            end
                            q:Create(
                                aY.List,
                                TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                {ScrollBarImageTransparency = 1}
                            ):Play()
                            q:Create(aY.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()
                            wait(0.35)
                            aY.List.Visible = false
                            Debounce = false
                        else
                            local a_ =
                                q:Create(
                                aY,
                                TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                                {Size = UDim2.new(1, -10, 0, 180)}
                            )
                            local b0 =
                                pcall(
                                function()
                                    a_:Play()
                                end
                            )
                            local b1 = false
                            if b0 then
                                b1 = true
                            end
                            spawn(
                                function()
                                    while b1 do
                                        a2()
                                        wait()
                                    end
                                end
                            )
                            a_.Completed:Connect(
                                function()
                                    b1 = false
                                end
                            )
                            aY.List.Visible = true
                            q:Create(
                                aY.List,
                                TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                {ScrollBarImageTransparency = 0.7}
                            ):Play()
                            q:Create(aY.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 0}):Play()
                            for B, b2 in ipairs(aY.List:GetChildren()) do
                                if b2.ClassName == "Frame" and b2.Name ~= "Placeholder" then
                                    q:Create(
                                        b2,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {BackgroundTransparency = 0}
                                    ):Play()
                                    q:Create(
                                        b2.UIStroke,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {Transparency = 0}
                                    ):Play()
                                    q:Create(
                                        b2.Title,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {TextTransparency = 0}
                                    ):Play()
                                end
                            end
                        end
                    end
                )
                for B, b3 in ipairs(aX.Options) do
                    local b4 = L.Template.Dropdown.List.Template:Clone()
                    b4.Name = b3
                    b4.Title.Text = b3
                    b4.Parent = aY.List
                    b4.Visible = true
                    if aX.CurrentOption == b3 then
                        b4.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    end
                    b4.MouseEnter:Connect(
                        function()
                            q:Create(b4, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                            q:Create(b4, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0.921, 0, 0, 38)}):Play()
                        end
                    )
                    b4.MouseLeave:Connect(
                        function()
                            q:Create(b4, e.Theme.Dark.TweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                            q:Create(b4, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0.921, 0, 0, 38)}):Play()
                        end
                    )
                    b4.Interact.ZIndex = 50
                    b4.Interact.MouseButton1Click:Connect(
                        function()
                            if not aX.MultipleOptions and table.find(aX.CurrentOption, b3) then
                                return
                            end
                            if table.find(aX.CurrentOption, b3) then
                                table.remove(aX.CurrentOption, table.find(aX.CurrentOption, b3))
                                if aX.MultipleOptions then
                                    if #aX.CurrentOption == 1 then
                                        aY.Selected.Text = aX.CurrentOption[1]
                                    elseif #aX.CurrentOption == 0 then
                                        aY.Selected.Text = "None"
                                    else
                                        aY.Selected.Text = "Various"
                                    end
                                else
                                    aY.Selected.Text = aX.CurrentOption[1]
                                end
                            else
                                if not aX.MultipleOptions then
                                    table.clear(aX.CurrentOption)
                                end
                                table.insert(aX.CurrentOption, b3)
                                if aX.MultipleOptions then
                                    if #aX.CurrentOption == 1 then
                                        aY.Selected.Text = aX.CurrentOption[1]
                                    elseif #aX.CurrentOption == 0 then
                                        aY.Selected.Text = "None"
                                    else
                                        aY.Selected.Text = "Various"
                                    end
                                else
                                    aY.Selected.Text = aX.CurrentOption[1]
                                end
                                local b5 = b4.Size
                                q:Create(b4, e.Theme.Dark.TweenInfo, {Size = UDim2.new(0.875, 0, 0, 38)}):Play()
                                q:Create(
                                    b4,
                                    TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                                ):Play()
                                Debounce = true
                                wait(0.2)
                                q:Create(b4, e.Theme.Dark.TweenInfo, {Size = b5}):Play()
                            end
                            local E, F =
                                pcall(
                                function()
                                    aX.Callback(aX.MultipleOptions == false and aX.CurrentOption[1] or aX.CurrentOption)
                                end
                            )
                            for B, b6 in ipairs(aY.List:GetChildren()) do
                                if
                                    b6.ClassName == "Frame" and b6.Name ~= "Placeholder" and
                                        not table.find(aX.CurrentOption, b6.Name)
                                 then
                                    q:Create(
                                        b6,
                                        TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                                    ):Play()
                                end
                            end
                            if not aX.MultipleOptions then
                                wait(0.1)
                                local a_ =
                                    q:Create(
                                    aY,
                                    TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                                    {Size = UDim2.new(1, -10, 0, 45)}
                                )
                                local b0 =
                                    pcall(
                                    function()
                                        a_:Play()
                                    end
                                )
                                local b1 = false
                                if b0 then
                                    b1 = true
                                end
                                spawn(
                                    function()
                                        while b1 do
                                            a2()
                                            wait()
                                        end
                                    end
                                )
                                a_.Completed:Connect(
                                    function()
                                        b1 = false
                                    end
                                )
                                for B, b2 in ipairs(aY.List:GetChildren()) do
                                    if b2.ClassName == "Frame" and b2.Name ~= "Placeholder" then
                                        q:Create(
                                            b2,
                                            TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                            {BackgroundTransparency = 1}
                                        ):Play()
                                        q:Create(
                                            b2.UIStroke,
                                            TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                            {Transparency = 1}
                                        ):Play()
                                        q:Create(
                                            b2.Title,
                                            TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                            {TextTransparency = 1}
                                        ):Play()
                                    end
                                end
                                q:Create(
                                    aY.List,
                                    TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    {ScrollBarImageTransparency = 1}
                                ):Play()
                                q:Create(aY.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()
                                wait(0.35)
                                aY.List.Visible = false
                            end
                            Debounce = false
                        end
                    )
                end
                for B, b6 in ipairs(aY.List:GetChildren()) do
                    if b6.ClassName == "Frame" and b6.Name ~= "Placeholder" then
                        if not table.find(aX.CurrentOption, b6.Name) then
                            b6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        else
                            b6.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        end
                    end
                end
                function aX:Set(b7)
                    aX.CurrentOption = b7
                    if typeof(aX.CurrentOption) == "string" then
                        aX.CurrentOption = {aX.CurrentOption}
                    end
                    if not aX.MultipleOptions then
                        aX.CurrentOption = {aX.CurrentOption[1]}
                    end
                    if aX.MultipleOptions then
                        if #aX.CurrentOption == 1 then
                            aY.Selected.Text = aX.CurrentOption[1]
                        elseif #aX.CurrentOption == 0 then
                            aY.Selected.Text = "None"
                        else
                            aY.Selected.Text = "Various"
                        end
                    else
                        aY.Selected.Text = aX.CurrentOption[1]
                    end
                    local E, F =
                        pcall(
                        function()
                            aX.Callback(b7)
                        end
                    )
                    for B, b6 in ipairs(aY.List:GetChildren()) do
                        if b6.ClassName == "Frame" and b6.Name ~= "Placeholder" then
                            if not table.find(aX.CurrentOption, b6.Name) then
                                b6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                            else
                                b6.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            end
                        end
                    end
                end
                return aX
            end
            function _:CreateTextbox(b8)
                local aQ = L.Template.Input:Clone()
                aQ.Name = b8.Name
                aQ.Title.Text = b8.Name
                aQ.Visible = true
                aQ.Parent = a0
                a2()
                aQ.InputFrame.InputBox.PlaceholderText = b8.PlaceholderText
                aQ.InputFrame.Size = UDim2.new(0, aQ.InputFrame.InputBox.TextBounds.X + 24, 0, 30)
                aQ.InputFrame.InputBox.FocusLost:Connect(
                    function()
                        local E, F =
                            pcall(
                            function()
                                b8.Callback(aQ.InputFrame.InputBox.Text)
                            end
                        )
                        if b8.RemoveTextAfterFocusLost then
                            aQ.InputFrame.InputBox.Text = ""
                        end
                        aQ.InputFrame.Size = UDim2.new(0, aQ.InputFrame.InputBox.TextBounds.X + 24, 0, 30)
                    end
                )
                aQ.InputFrame.InputBox:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        q:Create(
                            aQ.InputFrame,
                            TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, aQ.InputFrame.InputBox.TextBounds.X + 24, 0, 30)}
                        ):Play()
                    end
                )
                local b8 = {}
                function b8:Set(b9)
                    aQ.InputFrame.InputBox.Text = b9
                end
                return b8
            end
function _:CreateParagraph(ba)
    local bb = L.Template.Paragraph:Clone()
    bb.Name = ba.Title
    bb.Title.Text = ba.Title
    bb.Content.Text = ba.Description
    bb.Visible = true
    bb.Parent = a0
    a2()

    function bb:SetValue(bTitle, bDesc)
        bb.Title.Text = bTitle
        bb.Content.Text = bDesc
    end

    return bb
end

 function _:CreateLabel(bc)
    local bb6 = {Func = bc.Callback, CopyAble = bc.CopyAble or false}  -- Add CopyAble with a default of false
    
    local bb = L.Template.Label:Clone()
    bb.Name = bc.Description
    bb.Title.Text = bc.Description
    bb.Visible = true
    bb.Parent = a0
    a2()
    
    function bb6:SetValue(Desc)
        bb.Title.Text = Desc  -- Update label text
        bb.Name = Desc        -- Update label name
    end
    
    bb.MouseButton1Click:Connect(function()
        if bb6.CopyAble then
            -- Copy text to clipboard
            setclipboard(bb.Title.Text)
            print("Text copied: " .. bb.Title.Text)
        else
            print("Copy is disabled.")
        end
    end)
    
    return bb6  -- Return the controller with SetValue method
end           
            
function _:CreateCard(bd)
    local be = L.Template.Card:Clone()
    be.Name = bd.Title
    be.Title.Text = bd.Title
    be.Description.Text = bd.Description
    be.State.Text = bd.SecondaryTitle or ""
    be.PreviewImage.Image = bd.Image or "rbxassetid://14167800463"
    be.Parent = a0
    a2()
    be.Button1.Visible = false
    be.Button2.Visible = false
    if bd.Buttons then
        if bd.Buttons.Button1 then
            local a7 = be.Button1
            a7.Visible = true
            a7.Name = bd.Buttons.Button1.Name
            a7.Text = bd.Buttons.Button1.Name
            a7.MouseButton1Click:Connect(
            function()
                local E, F = pcall(bd.Buttons.Button1.Callback)
                    end
                        )
                    end
                    if bd.Buttons.Button2 then
                        local a7 = be.Button2
                        a7.Visible = true
                        a7.Name = bd.Buttons.Button2.Name
                        a7.Text = bd.Buttons.Button2.Name
                        a7.MouseButton1Click:Connect(
                            function()
                                local E, F = pcall(bd.Buttons.Button2.Callback)
                            end
                        )
                    end
                end
            end
            return _
        end
        return X
    end
    return M
end
return e
