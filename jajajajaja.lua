-- Premium Left Sidebar GUI with ESP toggle

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumSidebar"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main container frame (sidebar)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 250, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = sidebar

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 60)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Vopti Premium"
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = sidebar

-- ESP Toggle button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, -40, 0, 50)
espButton.Position = UDim2.new(0, 20, 0, 100)
espButton.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
espButton.Text = "Enable ESP"
espButton.Font = Enum.Font.GothamBold
espButton.TextSize = 22
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.AutoButtonColor = true
espButton.Parent = sidebar

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = espButton

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 25)
statusLabel.Position = UDim2.new(0, 20, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "ESP: Disabled"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 18
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = sidebar

-- Function to add ESP highlights
local highlights = {}

local function enableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character or player.CharacterAdded:Wait()
            if char and not highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.Adornee = char
                highlight.Parent = char
                highlights[player] = highlight
            end
        end
    end
end

local function disableESP()
    for player, highlight in pairs(highlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
        highlights[player] = nil
    end
end

-- Connect new players and their characters for ESP
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if espEnabled and player ~= LocalPlayer then
            if not highlights[player] then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.Adornee = char
                highlight.Parent = char
                highlights[player] = highlight
            end
        end
    end)
end)

-- Toggle ESP on button click
local espEnabled = false
espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "Disable ESP"
        statusLabel.Text = "ESP: Enabled"
        enableESP()
    else
        espButton.Text = "Enable ESP"
        statusLabel.Text = "ESP: Disabled"
        disableESP()
    end
end)

-- Optional: Make sidebar draggable (if you want)
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    sidebar.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

sidebar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = sidebar.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

sidebar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
