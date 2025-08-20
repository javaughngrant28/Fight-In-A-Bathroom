local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local ParticleUtil = require(game.ReplicatedStorage.Shared.Utils.ParticleUtil)


local EffectFolder = ReplicatedStorage.Assets.Effects



local EmitParticleModel = {}
EmitParticleModel.__index = EmitParticleModel

export type EmitParticleModelType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,

    PART: Part,
    EFFECT_NAME: string,

}, EmitParticleModel))

function EmitParticleModel.new(part: Part): EmitParticleModelType
    local self = setmetatable({

        _MAID = MaidModule.new(),

        PART = part,
        EFFECT_NAME = part:GetAttribute('EffectName')

    }, EmitParticleModel)

    self:Fire()
    
    return self
end

function EmitParticleModel.Fire(self: EmitParticleModelType)
    local effectModel = EffectFolder:FindFirstChild(self.EFFECT_NAME,true) :: Model
    assert(effectModel,`{self.EFFECT_NAME} Effect Model Not Found In Effect Folder`)
    assert(effectModel.PrimaryPart,`{self.EFFECT_NAME} Effect Model Has No PrimaryPart`)

    local modelClone: Model = effectModel:Clone()
    local weld = Instance.new('Motor6D')

    weld.Parent = modelClone.PrimaryPart
    weld.Part0 = self.PART
    weld.Part1 = modelClone.PrimaryPart

    self._MAID['Model'] = modelClone
    modelClone.Parent = workspace

    ParticleUtil.EmitAllParticles(modelClone)
end

function EmitParticleModel.Destroy(self: EmitParticleModelType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return EmitParticleModel