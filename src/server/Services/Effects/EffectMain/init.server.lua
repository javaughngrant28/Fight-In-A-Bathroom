
local EffectAPI = require(script.Parent.EffectAPI)
local EffectTypes = require(game.ReplicatedStorage.Shared.Data.Effects.EffectType)

local CreatEffectSigal = EffectAPI._GetCreateSignal()
local RemoveEffectSigal = EffectAPI._GetRemoveSignal()


local Effects = {}:: {
    [string]: { 
        Create: (EffectData: EffectTypes.EffetData)->(), 
        Remove: (...any)->()?
    }
}



local function Create(EffectData: EffectTypes.EffetData)
    if not EffectData then warn('Empty Effect Data') return end

    local EffectModule = Effects[EffectData.EffectName]
    assert(EffectModule,`{EffectData.EffectName} Effect Module Not Found`)

    EffectModule.Create(EffectData.Asstes)
end

local function Remove(effectName: string,...)
    local EffectModule = Effects[effectName]
    assert(EffectModule,`{effectName} Effect Module Not Found`)
    assert(EffectModule.Remove,`{effectName} Effect Has No Remove Function`)
    EffectModule.Remove(...)
end


CreatEffectSigal:Connect(Create)
RemoveEffectSigal:Connect(Remove)

for _, module: ModuleScript in script:GetChildren() do
    if not module:IsA('ModuleScript') then continue end
    Effects[module.Name] = require(module)
end
