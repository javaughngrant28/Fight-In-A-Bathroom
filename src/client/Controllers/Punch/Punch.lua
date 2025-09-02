local Players = game:GetService("Players")

local Hitbox = require(script.Parent.Parent.Parent.Modules.Hitbox)
local AnimationSequence = require(script.Parent.Parent.Parent.Modules.AnimationSequence)
local ContextAction = require(script.Parent.Parent.Parent.Modules.ContextAction)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)

local INDEX = "Punch"
local DEBOUNCE = 0.4

local Event: RemoteEvent?

local Keybinds = {
    PC = 'M1',
    Xbox = 'L2',
}


local function HitBoxResults(results: {})
    assert(Event,`{INDEX} Event Nil`)

    local Target = results['Target']
    if not Target then return end

    Event:FireServer(Target)
end

local function Punch()
    local Character: Model = Players.LocalPlayer.Character
    local results = Hitbox.Fire(Character)
    HitBoxResults(results)
end

local function PunchRequest(_, inputState: Enum.UserInputState)
    if inputState and inputState ~= Enum.UserInputState.End then return end
    if not Players.LocalPlayer.Character then return end
    Throttle(INDEX,DEBOUNCE,Punch)
end

local function SetPunchEnabled(value: boolean)
    if value then
         ContextAction.BindKeybind(INDEX,Keybinds,1,PunchRequest)
        else
            ContextAction.UnbindKeybind(INDEX,PunchRequest)
    end
end



return{
    SetEnabled = SetPunchEnabled,
}