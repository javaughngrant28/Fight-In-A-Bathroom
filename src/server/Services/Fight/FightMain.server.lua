
local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local FightAttributes = require(script.Parent.FightAttributes)

local function onPlayeradded(player: Player)
    FightAttributes.Create(player)
end

Observers.observePlayer(onPlayeradded)