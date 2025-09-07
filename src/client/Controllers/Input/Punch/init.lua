local Players = game:GetService("Players")

local Hitbox = require(script.Parent.Parent.Parent.Modules.Hitbox)
local PunchAnimation = require(script.PunchAnimation)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

local INDEX = `{CombatEnum.Punch}`
local DEBOUNCE = 0.4


local function HitBoxResults(results: {}, remoteEvent: RemoteEvent)
    local Target = results['Target']
    if not Target then return end

    remoteEvent:FireServer(INDEX,Target)
end

local function Filter(Target: Model): boolean
    return true
end

local function Punch(remoteEvent: RemoteEvent)
    local Character: Model = Players.LocalPlayer.Character

    local hitboxInfo: Hitbox.HitboxInfo = {
        Character = Character,
        Filter = Filter,
    }

    local results = Hitbox.Fire(Character)
    HitBoxResults(results,remoteEvent)

    PunchAnimation.Play()
end

local function PunchRequest(remoteEvent: RemoteEvent)
    if not Players.LocalPlayer.Character then return end
    Throttle(INDEX,DEBOUNCE,Punch,remoteEvent)
end


return{
    Fire = PunchRequest,
}