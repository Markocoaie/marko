-- Simple ESP example
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        local highlight = Instance.new("Highlight", player.Character or player.CharacterAdded:Wait())
        highlight.FillColor = Color3.new(1, 0, 0)  -- red highlight
        highlight.OutlineColor = Color3.new(1, 1, 1) -- white outline
    end
end
