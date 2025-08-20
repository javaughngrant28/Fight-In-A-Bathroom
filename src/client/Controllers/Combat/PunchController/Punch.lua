local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimationSequence = require(script.Parent.Parent.Parent.Parent.Modules.AnimationSequence)
local HitboxModule = require(script.Parent.Parent.Parent.Parent.Modules.Hitbox)

local AnimationFolder = ReplicatedStorage.Assets.Animations
local FightEvents = ReplicatedStorage.Events.Fight
local Player = Players.LocalPlayer


local PunchAnimation = AnimationSequence.new({
    [1] = AnimationFolder.M1,
    [2] = AnimationFolder.M2,
})

local function HandleHitResults(result: {HitboxModule.Target?})
    if not result or not result['Target'] then return end
    FightEvents.Punch:FireServer(result.Target)
end

local function Punch()
    local HitResults = HitboxModule.Fire(Player.Character)

    PunchAnimation:Play()
    HandleHitResults(HitResults)
end


return {
    Fire = Punch
}