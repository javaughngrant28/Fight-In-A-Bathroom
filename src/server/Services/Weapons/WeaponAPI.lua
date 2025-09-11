local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local CreateAllEquippedSignal = Signal.new()
local DestroyAllSignal = Signal.new()

local API = {
    Drop = Signal.new()
}

function API._GetCreateAllEquippedSignal(): Signal.SignalType
    return CreateAllEquippedSignal
end

function API._GetDestroyAllSignal(): Signal.SignalType
    return DestroyAllSignal
end

function API.CreateAllEquipped(player: Player)
    CreateAllEquippedSignal:Fire(player)
end

function API.DestroyAll(playerName: string)
    DestroyAllSignal:Fire(playerName)
end

return API