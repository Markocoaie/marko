-- Premium Menu GUI + Load ESP button

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui
frame.ClipsDescendants = true
frame.BackgroundTransparency = 1

-- UI corner for roundness
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Title label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Premium ESP Loader"
title.TextColor3 = Color3.fromRGB(230, 230, 230)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Load button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 140, 0, 50)
button.Position = UDim2.new(0.5, -70, 1, -70)
button.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
button.Text = "Load ESP"
button.Font = Enum.Font.GothamBold
button.TextSize = 24
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = button

-- Fade-in animation for frame
frame:TweenBackgroundTransparency(0, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
for _, obj in pairs(frame:GetChildren()) do
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        obj.TextTransparency = 1
        obj:TweenTextTransparency(0, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
    end
end

-- The simple ESP function you liked
local function runESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            if character and not character:FindFirstChildOfClass("Highlight") then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0) -- red
                highlight.OutlineColor = Color3.new(1, 1, 1) -- white
                highlight.Adornee = character
                highlight.Parent = character
            end
        end
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            if not char:FindFirstChildOfClass("Highlight") then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.Adornee = char
                highlight.Parent = char
            end
        end)
    end)
end

-- Button click runs ESP and disables GUI
button.MouseButton1Click:Connect(function()
    button.Text = "Loading..."
    button.Active = false
    runESP()
    wait(0.3)
    frame:TweenPosition(UDim2.new(0.5, -175, 1.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true)
    wait(0.5)
    screenGui:Destroy()
end)
