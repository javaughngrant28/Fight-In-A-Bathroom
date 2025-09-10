
export type Values  = {
    ATTRIBUTE_NAME: string,
    DURATION: number,
}

export type Cooldown = {
    string: Values
}

return {
    Block = {
        ATTRIBUTE_NAME = 'BlockCooldown',
        DURATION = 4,
    },
    Throw = {
        ATTRIBUTE_NAME = 'ThrowCooldown',
        DURATION = 2,
    },

    Grab = {
        ATTRIBUTE_NAME = 'GrabCooldown',
        DURATION = 6,
    },
}