--[[
    SirHub Spray Paint Script
    Cleaned version with key system bypassed.
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Bypassed key check, so just print success
print("[SirHub]: Key check bypassed. Running Spray Paint script.")

local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local spraying = false
local sprayPart = nil

local function CreateSpray(position)
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Size = Vector3.new(0.5, 0.5, 0.1)
    part.Position = position
    part.BrickColor = BrickColor.new("Bright red")
    part.Parent = workspace
    return part
end

local function StartSpraying()
    spraying = true
    sprayPart = CreateSpray(Mouse.Hit.p)
end

local function StopSpraying()
    spraying = false
    if sprayPart then
        sprayPart:Destroy()
        sprayPart = nil
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        StartSpraying()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        StopSpraying()
    end
end)

RunService.Heartbeat:Connect(function()
    if spraying and sprayPart then
        sprayPart.Position = Mouse.Hit.p
    end
end)

print("[SirHub]: Spray Paint script running without key system.")
