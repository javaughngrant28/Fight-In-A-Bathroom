local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimationFolder = ReplicatedStorage.Assets.Animations
local AnimationSequence = require(script.Parent.Parent.Parent.Parent.Modules.AnimationSequence)

local PunchAnimation = AnimationSequence.new({
    [1] = AnimationFolder.M1,
    [2] = AnimationFolder.M2,
})


local function Punch()
    PunchAnimation:Play()
end


return {
    Fire = Punch
}