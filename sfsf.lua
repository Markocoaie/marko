if game.GameId == 2160907981 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/refs/heads/main/main/Scripts/SprayPaintPreLoad.lua"))()
end

-- Directly load the main script without key system
local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/main/main/Scripts/" .. game.GameId .. ".lua")
end)

if success then
    loadstring(result)()
else
    warn("Failed to load the main script:", result)
end
