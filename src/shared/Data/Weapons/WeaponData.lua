local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WeaponTypes = require(script.Parent.WeaponTypes)
local WeaponEnum = require(script.Parent.WeaponEnum)
local AnimationFolder = ReplicatedStorage.Assets.Animations


local WeaponData: WeaponTypes.List = {
    Fist = {
        Type = WeaponEnum.Types.Melee,
        Cost = 0,
        Animations = {
            Punch = {
                AnimationFolder.M1,
                AnimationFolder.M2,
            },
            Weave = {
                Left = AnimationFolder.Wave1,
                Righ = AnimationFolder.Wave2,
            },
            Walk = AnimationFolder.Run1,
            Fall = AnimationFolder.Fall1,
            Jump = AnimationFolder.Jump1,
            Block = AnimationFolder.Block,
            Grab = AnimationFolder.Grab1,
            Kick = AnimationFolder.Kick1,
            Idle = AnimationFolder.Idle1,
        },
    },
}

return WeaponData
