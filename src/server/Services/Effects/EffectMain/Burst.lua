local Debris = game:GetService("Debris")
local PartModule = require(script.Parent.Parent.Part)


type Data = {
    ParticleModelName: string,
    SoundName: string,
    Duration: number,
    Position: Vector3
}

local function CreateHitEffect(data: Data)
    local part = PartModule.Clone()
    local duration = data.Duration

    part:SetAttribute('EffectName',data.ParticleModelName)
    part:SetAttribute('SoundName',data.SoundName)

    part:AddTag('PlaySound')
    part:AddTag('EmitParticleModel')
    part.Position = data.Position
    part.Parent = workspace

    Debris:AddItem(part,duration)
end



return {
    Create = CreateHitEffect,
}