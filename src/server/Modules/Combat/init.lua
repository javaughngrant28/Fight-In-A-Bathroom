
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

return{
    Enum = CombatEnum,
    State = require(script.State)
    Punch = require(script.Punch),
    Block = require(script.Block)
}