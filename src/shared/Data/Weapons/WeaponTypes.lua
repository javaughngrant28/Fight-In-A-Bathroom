
type WeaveAnimation = {
    Left: Animation,
    Right: Animation,
}

type CustomAnimation = {
    Punch: {Animation}?,
    Throw: Animation?,
    Weave: WeaveAnimation?,
    Walk: Animation?,
    Jump: Animation?,
    Fall: Animation?,
    Idle: Animation?,
    Block: Animation?,
    Grab: Animation?,
    Kick: Animation?,
}

export type Data =  {
    Type: string,
    Cost: number,
    Model: Model?,
    Animations: CustomAnimation,
}

export type List = {
    WeaponName: Data
}

return {}