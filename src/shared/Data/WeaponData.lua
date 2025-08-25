
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

export type WeaponDataType =  {
    Type: string,
    Stackable: boolean,
    Cost: number,
    Model: Model?,
    CustomAnimations: CustomAnimationType?,
}

export type WeaponListType = {
    WeaponName: WeaponDataType
}

local WeaponData: WeaponListType = {
    Fist = {
        Type = 'Melee',
        Stackable = false,
        Cost = 0,
    }
}

return WeaponData
