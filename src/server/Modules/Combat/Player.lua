local Players = game:GetService("Players")

local function GetPlayer(Character: Model): Player?
    local player: Player?

    if Character then
        player = Players:GetPlayerFromCharacter(Character)
    end

    return player
end


return {
    Get = GetPlayer,
}