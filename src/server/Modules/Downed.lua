
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)

local function EnableRagdollState(character: Model)
    local humanoid = character:FindFirstChildWhichIsA('Humanoid') :: Humanoid

    if humanoid.Health <= 0 then return end
    if humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then return end

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
    humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
end

local function DisableRagdollState(character: Model)
    local humanoid = character:FindFirstChildWhichIsA('Humanoid') :: Humanoid

    if humanoid.Health <= 0 then return end
    if humanoid:GetState() ~= Enum.HumanoidStateType.Ragdoll then return end

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    humanoid:ChangeState(Enum.HumanoidStateType.Landed)
end

local function DownCharacter(character: Model)
    if character:HasTag(StateEnum.Downed) then return end
    character:AddTag(StateEnum.Downed)
    character:SetAttribute(StateEnum.ATTRIBUTE_NAME,StateEnum.Downed)
    pcall(EnableRagdollState,character)
end

local function DisabledDowned(character: Model)
    if not character:HasTag(StateEnum.Downed) then return end
    character:RemoveTag(StateEnum.Downed)
    character:SetAttribute(StateEnum.ATTRIBUTE_NAME,StateEnum.None)
    pcall(DisableRagdollState,character)
end

return {
    Enabled = DownCharacter,
    Diabled = DisabledDowned
}