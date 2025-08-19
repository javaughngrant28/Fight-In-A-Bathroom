local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')

local MobileButtons = PlayerGui:WaitForChild('MobileButtons',20)
local Frame = MobileButtons:WaitForChild('HolderFrame',20)
local PunchButton = Frame:WaitForChild('Punch',20)

local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local ContextAction = require(script.Parent.Parent.Parent.Modules.ContextAction)
local Punch = require(script.Punch)

local PUNCH_DEBOUNCE = 0.4

local PUNCH_KEYBIND_INDEX = 'Punch'
local XBOX_ATTRIBUTE_NAME = 'XboxKeybind'
local PC_ATTRIBUTE_NAME = 'PCKeybind'

local KeybindInput = {}
local CombatEnabled = false


local function PunchRequest(_, inputState: Enum.UserInputState)
    if not CombatEnabled then return end
    if inputState and  inputState == Enum.UserInputState.End then return end
    Throttle(PUNCH_KEYBIND_INDEX,PUNCH_DEBOUNCE,function()
         Punch.Fire()
    end)
end

local function CreateBind()
    ContextAction.BindKeybind(PUNCH_KEYBIND_INDEX,KeybindInput,1,PunchRequest)
end

local function RemoveBind()
    ContextAction.UnbindKeybind(PUNCH_KEYBIND_INDEX,PunchRequest)
end

local function KeybindUpdated()
    if not Player:GetAttribute(PC_ATTRIBUTE_NAME) or  not Player:GetAttribute(XBOX_ATTRIBUTE_NAME) then return end
    KeybindInput = { PC = Player:GetAttribute(PC_ATTRIBUTE_NAME), Xbox = Player:GetAttribute(XBOX_ATTRIBUTE_NAME),}
    if CombatEnabled then
        RemoveBind()
        CreateBind()
    end
end


local function CombatEnabledUpdated(value: boolean)
    CombatEnabled = value
    if value then CreateBind() else RemoveBind() end
end

local function PlayerAttributesChanged(name: string, value: string)
    if name == XBOX_ATTRIBUTE_NAME or name == PC_ATTRIBUTE_NAME then
        KeybindUpdated()
    end

    if name == XBOX_ATTRIBUTE_NAME and Player:GetAttribute(PC_ATTRIBUTE_NAME) ~= nil then
        KeybindUpdated()
    end

    if name == 'CombatEnabled' then
        CombatEnabledUpdated(value)
    end
end

PunchButton.Activated:Connect(PunchRequest)
Observers.observeAllAttributes(Player,PlayerAttributesChanged)



