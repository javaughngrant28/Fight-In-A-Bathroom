local Debris = game:GetService("Debris")

local function CreateHitEffect(part: Part, position: Vector3, duration: number?)
    local duration = duration or 20

    part:SetAttribute('EffectName','Hit1')
    part:SetAttribute('SoundName','Landed')

    part:AddTag('PlaySound')
    part:AddTag('EmitParticleModel')
    part.Position = position
    part.Parent = workspace

    Debris:AddItem(part,duration)
end



return {
    Create = CreateHitEffect,
}