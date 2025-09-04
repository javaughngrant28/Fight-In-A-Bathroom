
local EffectAPI = require(game.ServerScriptService.Services.Effects.EffectAPI)
local GetDistance = require(script.Parent.GetDistance)

local MAX_DISTANCE = 8

type PunchData = {
    Player: Player, 
    Target: Model, 
    Damage: number, 
    EffectName: string
}

local function DealDamage(target: Model, damage: number)
    local Humanoid = target:FindFirstChildWhichIsA('Humanoid',true) :: Humanoid
    Humanoid:TakeDamage(damage)
end

function Punch(data: PunchData)
    local character = data.Player.Character
    
    if not character or character.Parent == nil then return end
    if not data.Target or data.Target.Parent == nil then return end

    local targetRootPart = data.Target:FindFirstChild('HumanoidRootPart') or data.Target.PrimaryPart :: BasePart
    local characterHumanoid = character:FindFirstChildWhichIsA('Humanoid',true) :: Humanoid

    local Distance = GetDistance.BetweenModels(character,data.Target)
    if Distance > MAX_DISTANCE then return end
    if characterHumanoid.Health <= 0 then return end

    DealDamage(data.Target,data.Damage)
    EffectAPI.Create(data.EffectName,targetRootPart.CFrame.Position)
end


return {
    Fire = Punch
}