local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WeaponTypes = require(script.Parent.WeaponTypes)
local WeaponEnum = require(script.Parent.WeaponEnum)
local AnimationFolder = ReplicatedStorage.Assets.Animations


local WeaponData: WeaponTypes.List = {
    Fist = {
        Type = WeaponEnum.Types.Melee,
        Cost = 0,
        Damage = 10,
        Animations = {
            Punch = {
                AnimationFolder.M1,
                AnimationFolder.M2,
            },
            Weave = {
                Left = AnimationFolder.Wave1,
                Righ = AnimationFolder.Wave2,
            },
            WalkAnim = AnimationFolder.Run1,
            FallAnim = AnimationFolder.Fall1,
            JumpAnim = AnimationFolder.Jump1,
            Block = AnimationFolder.Block,
            Grab = AnimationFolder.Grab1,
            Kick = AnimationFolder.Kick1,
            Animation1 = AnimationFolder.Idle1,
            Animation2 = AnimationFolder.Idle1,

        },
    },

    SpitBall = {
        Type = WeaponEnum.Types.Range,
        Cost = 0,
        Damage = 10,
        Model = ReplicatedStorage.Assets.Models.Shade,
        AOE = false,
        ThrowOriginName = 'Head',
        ThrowDuration = 0.4,
        ThrowDistance = 20,
        Animations = {
            Punch = {
                AnimationFolder.M1,
                AnimationFolder.M2,
            },
            Weave = {
                Left = AnimationFolder.Wave1,
                Righ = AnimationFolder.Wave2,
            },
            WalkAnim = AnimationFolder.Run1,
            FallAnim = AnimationFolder.Fall1,
            JumpAnim = AnimationFolder.Jump1,
            Block = AnimationFolder.Block,
            Grab = AnimationFolder.Grab1,
            Kick = AnimationFolder.Kick1,
            Animation1 = AnimationFolder.Idle1,
            Animation2 = AnimationFolder.Idle1,

        },
    },
}

return WeaponData
