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

function API.Create(...: any?)
    CreateSignal:Fire(...)
end

function API.Destroy(...: any?)
    DestroySignal:Fire(...)
end

return API