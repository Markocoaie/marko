-- Basic Roblox cheat script with ESP, Silent Aim, Speed

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ESP Function
local function createESP(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function(char)
        wait(1)
        local highlight = Instance.new("Highlight")
        highlight.Name = "CheatESP"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.Adornee = char
        highlight.Parent = char
    end)
    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Name = "CheatESP"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
    end
end

for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end

Players.PlayerAdded:Connect(createESP)

-- Silent Aim basics
local mouse = LocalPlayer:GetMouse()
local targetPartName = "Head"  -- Aim at head by default
local aiming = false

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = false
    end
end)

local function getClosestTarget()
    local closestDist = math.huge
    local closestPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(targetPartName) then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(player.Character[targetPartName].Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
            if dist < closestDist and dist < 100 then  -- 100 pixel radius
                closestDist = dist
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Hook shooting function (example only, varies by game)
-- This part is game-specific. You have to modify the shooting logic or replace mouse.Target before firing.
-- Here's a very basic example of aiming assistance by moving mouse target.

RunService.RenderStepped:Connect(function()
    if aiming then
        local target = getClosestTarget()
        if target and target.Character and target.Character:FindFirstChild(targetPartName) then
            local headPos = target.Character[targetPartName].Position
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(headPos)
            if onScreen then
                mouse.X = screenPos.X
                mouse.Y = screenPos.Y
            end
        end
    end
end)

-- Speed hack
local speedAmount = 50
local isSpeedOn = false

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        isSpeedOn = true
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speedAmount
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        isSpeedOn = false
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- default
        end
    end
end)
