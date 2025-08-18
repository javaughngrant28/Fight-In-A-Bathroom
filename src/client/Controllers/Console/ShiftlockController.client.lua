local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shiftlock = require(ReplicatedStorage.Shared.Modules.Shiftlock)
local Observers = require(ReplicatedStorage.Shared.Libraries.Observers)
local Throttle = require(ReplicatedStorage.Shared.Libraries.Throttle)
local ContextAction = require(script.Parent.Parent.Parent.Modules.ContextAction)

local Player = Players.LocalPlayer

local function KeybindActivated()
    Throttle('XboxKeybind',0.4,function()
        Shiftlock.Toggle()
    end)
end

local function OnKeybindAttributeChanged(value: string)
    local keyName = Player:GetAttribute('XboxKeybind')
    ContextAction.BindKeybind('XboxKeybind',{ Xbox = keyName},1,KeybindActivated)

    return function ()
        ContextAction.UnbindKeybind('XboxKeybind',KeybindActivated)
    end
end

Observers.observeAttribute(Player,'XboxKeybind',OnKeybindAttributeChanged)
