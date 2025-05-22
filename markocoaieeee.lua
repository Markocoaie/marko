-- Ensure the fake key file exists
if not isfile("Xrer_key.txt") then
    writefile("Xrer_key.txt", game:HttpGet("https://raw.githubusercontent.com/Markocoaie/marko/refs/heads/main/Xrer_key.txt"))
end

if game.GameId == 2160907981 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NOOBARMYSCRIPTER/SirHub/refs/heads/main/main/Scripts/SprayPaintPreLoad.lua"))()
end

local success, result = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/Markocoaie/marko/refs/heads/main/2160907981.lua")
end)

if success then
    loadstring(result)()
else
    warn("Failed to load the main script:", result)
end
