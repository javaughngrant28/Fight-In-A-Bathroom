local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local GrabAnimation = require(script.GrabAnimation)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

local INDEX = CombatEnum.Grab


local function GrabRequest(remote: RemoteEvent)
    local state = Player.Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    local grabCooldownAttribute = Player:GetAttribute(CombatCooldowns.Grab.ATTRIBUTE_NAME)

    if state ~= StateEnum.None then return end
    if grabCooldownAttribute and grabCooldownAttribute == true then return end

    remote:FireServer(INDEX)
    GrabAnimation.Play()
end



return {
    Pressed = GrabRequest
}