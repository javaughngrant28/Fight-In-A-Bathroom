local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local GrabAnimation = require(script.GrabAnimation)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)
local Hitbox = require(script.Parent.Parent.Parent.Modules.Hitbox)


local INDEX = CombatEnum.Grab

local function FilterFunction(target: Model): boolean
    local state = target:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    return state == nil or state ~= StateEnum.Downed
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


local function GrabRequest(remote: RemoteEvent)
    local state = Player.Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    local grabCooldownAttribute = Player:GetAttribute(CombatCooldowns.Grab.ATTRIBUTE_NAME)
    
    if state ~= StateEnum.None then return end
    if grabCooldownAttribute and grabCooldownAttribute == true then return end
    
    FireHitDetection(remote)
    GrabAnimation.Play()
end



return {
    Pressed = GrabRequest
}