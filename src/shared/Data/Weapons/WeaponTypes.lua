
local EffectTypes = require(script.Parent.Parent.Effects.EffectType)

type WeaveAnimation = {
    Left: Animation,
    Right: Animation,
}


export type CutseneData = {
    Animation1: Animation,
    Animation2: Animation,
    DistanceBetween: number,
}

type CustomAnimation = {
    Punch: {Animation}?,
    Throw: Animation?,
    Weave: WeaveAnimation?,
    Block: Animation?,
    Grab: Animation?,
    Kick: Animation?,
    RunAnim: string?,
    WalkAnim: string?,
    Animation1: string?,
    Animation2: string?,
    JumpAnim: string?,
    FallAnim: string?,
    Swim: string?,
    SwimIdle: string?,
    ClimbAnim: string?,
}





export type Data =  {
    Type: string,
    Cost: number,
    Damage: number,
    Animations: CustomAnimation,
    Model: Model?,
    GrabCutscene: CutseneData?,
    
    --Throwing Stuff
    AOE: boolean?,
    AOE_Radius: number?,
    ThrowOriginName: string?,
    ThrowDuration: number?,
    ThrowDistance: number?,
    
    EffectList: EffectTypes.EffectList
}

export type List = {
    WeaponName: Data
}

return {}