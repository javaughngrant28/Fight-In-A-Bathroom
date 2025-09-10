
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

return {
    Enum = StateEnum,
    
    Get = function(Character: Model): string
        return Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    end,

    Set = function(Character: Model, state: string)
        Character:SetAttribute(StateEnum.ATTRIBUTE_NAME,state)
    end,
}