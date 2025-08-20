
export type FightAttributesType = {
    CombatEnabled: boolean,
}

local function CreateFightAttributes(player: Player)
    player:SetAttribute('CombatEnabled',true)
end


local function GetFightAttributes(player: Player) : FightAttributesType
    return player:GetAttributes()
end

return {
    Create = CreateFightAttributes,
    Get = GetFightAttributes,
}