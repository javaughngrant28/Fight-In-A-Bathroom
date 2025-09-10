
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

return{
    Enum = CombatEnum,
    State = require(script.State),
    Punch = require(script.Punch),
    Block = require(script.Block),
    Throw = require(script.Throw),
    Grab = require(script.Grab)
}