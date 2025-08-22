local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimationSequence = require(script.Parent.Parent.Parent.Parent.Modules.AnimationSequence)
local HitboxModule = require(script.Parent.Parent.Parent.Parent.Modules.Hitbox)

local AnimationFolder = ReplicatedStorage.Assets.Animations
local FightEvents = ReplicatedStorage.Events.Fight
local Player = Players.LocalPlayer


local PunchAnimationSequence: AnimationSequence.AnimationSequenceType?

local function HandleHitResults(result: {HitboxModule.Target?})
    if not result or not result['Target'] then return end
    FightEvents.Punch:FireServer(result.Target)
end

local function Punch()
    if PunchAnimationSequence == nil then warn('No PunchAnimationSequence Found') return end
    local HitResults = HitboxModule.Fire(Player.Character)

    PunchAnimationSequence:Play()
    HandleHitResults(HitResults)
end

local function ChanageAnimations(animaionList: {Animation})
    PunchAnimationSequence:Destroy()
    PunchAnimationSequence = AnimationSequence.new(animaionList)
end


FightEvents.ChangePunchAnimation(ChanageAnimations)

return {
    Fire = Punch
}