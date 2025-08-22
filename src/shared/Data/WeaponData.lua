
type WeaveAnimationType = {
    LeftWeave: Animation,
    RightWave: Animation,
}

type CustomAnimationType = {
    AttackAnimations: {Animation}?,
    Weave: WeaveAnimationType?,
    Walk: Animation?,
    Equip: Animation?,
    Idle: Animation?,
    Block: Animation?,
    Grab: Animation?,
}

export type WeaponDataType = {
    WeaponName: {
        Type: string,
        Stackable: boolean,
        Cost: number,
        Model: Model?,
        CustomAnimations: CustomAnimationType?,
    }
}

local WeaponData: WeaveAnimationType = {
    Fist = {
        Type = 'Melee',
        Stackable = false,
        Cost = 0,
    }
}

return WeaponData
