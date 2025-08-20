local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local CreateSignal = Signal.new()
local RemoveSignal = Signal.new()

local API = {}

function API._GetCreateSignal(): Signal.SignalType
    return CreateSignal
end

function API._GetRemoveSignal(): Signal.SignalType
    return RemoveSignal
end

function API.Create(effectName: string,...: any?)
    CreateSignal:Fire(effectName,...)
end

function API.Remove(effectName: string,...: any)
    RemoveSignal:Fire(effectName,...)
end

return API