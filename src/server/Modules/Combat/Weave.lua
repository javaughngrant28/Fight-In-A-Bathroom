
local State = require(script.Parent.State)
local Cooldown = require(script.Parent.Cooldown)

local function Weave(Character: Model)
    Cooldown.Start(Character,State.Enum.Weave,State.Enum.None)
end

local function WeaveRequest(Character: Model)
    local currentState = State.Get(Character)
    if currentState ~= State.Enum.None then return end
    if Cooldown.Active(Character,State.Enum.Weave) then return end
    Weave(Character)
end

return {
    Fire = WeaveRequest
}