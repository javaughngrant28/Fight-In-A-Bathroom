

local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)


return {
    Weapon = {
        Add = Signal.new(),
        Remove = Signal.new(),
    }
}