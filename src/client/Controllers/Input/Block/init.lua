local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local BlockAnimation = require(script.BlockAnimation)
local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()

local INDEX = `{CombatEnum.Block}`
local PRESS_DELAY = 0.2

local function FireEvent(value: boolean,remoteEvent: RemoteEvent)
    remoteEvent:FireServer(INDEX,value)
end

local function BlockPressRequest(remoteEvent: RemoteEvent)
    local Character = Player.Character
    local State = Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    if State ~= StateEnum.None then return end
    Throttle('BlockPressed',PRESS_DELAY,FireEvent,true,remoteEvent)
end

local function BlockReleasedRequest(remoteEvent: RemoteEvent)
    local Character = Player.Character
    local State = Character:GetAttribute(StateEnum.ATTRIBUTE_NAME)
    if State ~= StateEnum.Blocking then return end
    FireEvent(false,remoteEvent)
end


local function onCharacterAdded(character: Model)
    local stopObserving = Observers.observeAttribute(character,StateEnum.ATTRIBUTE_NAME,function(value)
        if value == StateEnum.Blocking then
            BlockAnimation.Play()
            else
                BlockAnimation.Stop()
        end
    end)

    Maid['AncestryChanged'] = character.AncestryChanged:Connect(function(_, parent)
        if not parent or parent == nil then
            stopObserving()
        end
    end)
end

Player.CharacterAdded:Connect(onCharacterAdded)

if Player.Character then
    onCharacterAdded(Player.Character)
end

return{
    Pressed = BlockPressRequest,
    Released = BlockReleasedRequest,
}