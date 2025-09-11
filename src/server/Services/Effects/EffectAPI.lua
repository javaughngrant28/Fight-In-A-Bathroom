local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)
local EffectTypes = require(game.ReplicatedStorage.Shared.Data.Effects.EffectType)

local CreateSignal = Signal.new()
local RemoveSignal = Signal.new()

local API = {}

function API._GetCreateSignal(): Signal.SignalType
    return CreateSignal
end

function API._GetRemoveSignal(): Signal.SignalType
    return RemoveSignal
end

function API.Create(EffetData: EffectTypes.EffetData)
    CreateSignal:Fire(EffetData)
end

function API.Remove(effectName: string,...: any)
    RemoveSignal:Fire(effectName,...)
end

return API