local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local CreateSignal = Signal.new()
local DestroySignal = Signal.new()

local API = {}

function API._GetCreateSignal(): Signal.SignalType
    return CreateSignal
end

function API._GetDestroySignal(): Signal.SignalType
    return DestroySignal
end

function API.Create(player: Player,WeaponName: string)
    CreateSignal:Fire(player,WeaponName)
end

function API.Destroy(playerName: string, WeaponName: string)
    DestroySignal:Fire(playerName,WeaponName)
end

return API