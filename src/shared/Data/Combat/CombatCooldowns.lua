
local CombatEnum = require(script.Parent.CombatEnum)

export type Values  = {
    ATTRIBUTE_NAME: string,
    DURATION: number,
}

export type Cooldown = {
    string: Values
}

return {
    [CombatEnum.Block] = {
        ATTRIBUTE_NAME = 'BlockCooldown',
        DURATION = 4,
    },

    [CombatEnum.Throw] = {
        ATTRIBUTE_NAME = 'ThrowCooldown',
        DURATION = 2,
    },

    [CombatEnum.Grab] = {
        ATTRIBUTE_NAME = 'GrabCooldown',
        DURATION = 6,
    },

    [CombatEnum.Weave] = {
        ATTRIBUTE_NAME = 'WeaveCooldown',
        DURATION = 1,
    },

    [CombatEnum.Kick] = {
        ATTRIBUTE_NAME = 'KickCooldown',
        DURATION = 0.4,
    },
}