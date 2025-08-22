
local EffectAPI = require(script.Parent.EffectAPI)

local CreatEffectSigal = EffectAPI._GetCreateSignal()
local RemoveEffectSigal = EffectAPI._GetRemoveSignal()


local Effects: {
    [string]: { Create: (part: Part, ...any?)->(), Remove: (...any)->()?}
} = {}

local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(0.2,0.2,0.2)
part.Transparency = 0.8
part.BrickColor = BrickColor.new('Really red')



local function Create(effectName: string,...)
    local EffectModule = Effects[effectName]
    assert(EffectModule,`{effectName} Effect Module Not Found`)

    local partClone = part:Clone()
    EffectModule.Create(partClone,...)
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
