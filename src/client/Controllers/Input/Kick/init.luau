




local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)
local Hitbox = require(script.Parent.Parent.Parent.Modules.Hitbox)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local KickAnimation = require(script.AnimationKick)


local INDEX = CombatEnum.Kick

local function FilterFunction(target: Model): boolean
    local state = target:GetAttribute(CombatEnum.ATTRIBUTE_NAME)
    return state ~= nil and state == CombatEnum.Downed
end

local function FireHitDetection(remote: RemoteEvent)
    local hitboxInfo: Hitbox.HitboxInfo = {
        Character = Player.Character,
        Filter = FilterFunction,
    }
    
    local results = Hitbox.Fire(hitboxInfo)
    local target = results['Target'] or nil

    remote:FireServer(INDEX,target)
end


local function KickRequest(remote: RemoteEvent)
    local state = Player.Character:GetAttribute(CombatEnum.ATTRIBUTE_NAME)
    local KickCooldownAttribute = Player:GetAttribute(CombatCooldowns[INDEX].ATTRIBUTE_NAME)
    
    if state ~= CombatEnum.None then return end
    if KickCooldownAttribute then return end
    
    Throttle('KickHitDetection',0.4,FireHitDetection,remote)
    KickAnimation.Play()
end

return {
    Pressed = KickRequest
}