
local WeaponTypes = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponTypes)
local Cooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local Cutscene = require(game.ServerScriptService.Modules.Cutscene)
local Player = require(script.Parent.Player)
local Downed = require(game.ServerScriptService.Modules.Downed)

local ATTRIBUTE_NAME = Cooldowns.Grab.ATTRIBUTE_NAME

local function ActivateCooldown(character: Model)
    local player = Player.Get(character) :: Player
    player:SetAttribute(ATTRIBUTE_NAME,true)
    task.delay(Cooldowns.Grab.DURATION,function()
        player:SetAttribute(ATTRIBUTE_NAME,false)
    end)
end

local function CoolDownActive(character: Model): boolean
    local player = Player.Get(character)
    if not player then return true end
    if player:GetAttribute(ATTRIBUTE_NAME) and player:GetAttribute(ATTRIBUTE_NAME) == true then
        return true
    end
    return false
end

local function CutsceneEned(target: Model)
    Downed.Enabled(target)
end

local function CutscenePlaying(target: Model, animationTrack: AnimationTrack)
    local endedConnection: RBXScriptSignal

    endedConnection = animationTrack.Ended:Once(function()
        CutsceneEned(target)
        endedConnection:Disconnect()
        endedConnection = nil
    end)

    if not animationTrack.IsPlaying then
        CutsceneEned(target)
        endedConnection:Disconnect()
        endedConnection = nil
    end
end

local function PlayCutsene(character: Model, target: Model, cutseneData: WeaponTypes.CutseneData)
    local cutseneInfo: Cutscene.CutseneInfo = {
        Character1 = character,
        Character2 = target,
        Animation1 = cutseneData.Animation1,
        Animation2 = cutseneData.Animation2,
        DistanceBetween = cutseneData.DistanceBetween
    }
    local success, error_message, targetAnimationTrack = pcall(Cutscene.Play,cutseneInfo)
    if not success then
        warn(error_message)
        else
            CutscenePlaying(target,targetAnimationTrack)
    end
end

local function GrabTarget(character: Model, target: Model, cutseneData: WeaponTypes.CutseneData)
    if CoolDownActive(character) then return end
    ActivateCooldown(character)

    if target then 
        PlayCutsene(character,target,cutseneData)
    end
end


return {
    Fire = GrabTarget
}