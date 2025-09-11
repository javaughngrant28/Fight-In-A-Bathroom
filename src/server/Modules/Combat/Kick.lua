
local EffectAPI = require(game.ServerScriptService.Services.Effects.EffectAPI)
local EffectTypes = require(game.ReplicatedStorage.Shared.Data.Effects.EffectType)
local GetDistance = require(script.Parent.GetDistance)
local State = require(script.Parent.State)
local Cooldown = require(script.Parent.Cooldown)


local MAX_DISTANCE = 8
local DAMAGE = 20


local function DealDameg(target: Model, EffectData: EffectTypes.EffetData)
    if not target then return end
    local humanoid = target:FindFirstChildWhichIsA('Humanoid')

    if not humanoid then return end
    humanoid:TakeDamage(DAMAGE)

    EffectAPI.Create(EffectData)
end


local function KickRequest(character: Model, target: Model, EffectData: EffectTypes.EffetData)
    if Cooldown.Active(character,State.Enum.Kick) then return end
    if GetDistance.BetweenModels(character,target) > MAX_DISTANCE then return end
    Cooldown.Start(character,State.Enum.Kick,State.Enum.None)
    DealDameg(target)
end

return {
    Fire = KickRequest
}