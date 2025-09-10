local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)

local LeftAnimtion = require(script.LeftAnimation)
local RightAnimtion = require(script.RightAnimation)

local INDEX = CombatEnum.Weave
local LeftAnimtionPlayed = false

local function PlayAnimation()
    if LeftAnimtionPlayed then
        RightAnimtion.Play()
        else
            LeftAnimtion.Play()
    end

    LeftAnimtionPlayed = not LeftAnimtionPlayed
end

local function Weave(remote: RemoteEvent)
    remote:FireServer(INDEX)
    PlayAnimation()
end

local function WeaveRequest(remote: RemoteEvent)
    local state = Player.Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    if state ~= StateEnum.None then return end

    Throttle('Weave',0.08,Weave,remote)
end

return {
    Pressed = WeaveRequest
}