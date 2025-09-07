
local AnimationSequence = require(script.Parent.Parent.Parent.Parent.Modules.AnimationSequence)
local ToolDetectore = require(script.Parent.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()

local PunchAnimations : AnimationSequence.AnimationSequenceType

local function PlayAnimation(playbackSpeed: number?, weight: number?, fadeTime: number?)
    PunchAnimations:Play(playbackSpeed,weight,fadeTime)
end

local function UpdateAnimations(animations: {Animation})
    local animationSequence = AnimationSequence.new(animations)
    Maid['AnimationSequence'] = animationSequence
    PunchAnimations = animationSequence
end

ToolDetectore.EquippedSignal:Connect(function(tool: Tool)
    if tool:GetAttribute('Type') == nil or tool:GetAttribute('Type') ~= WeaponEnum.Types.Melee then return end
    local AnimationFolder = tool:FindFirstChild('Punch',true)
    if not AnimationFolder then warn(`{tool} Has No Punch Folder`) return end

    local animations = {}

    for _, animation: Animation? in AnimationFolder:GetChildren() do
        if not animation:IsA('Animation') then continue end
        table.insert(animations,animation)
    end

    if #animations >= 1 then
        UpdateAnimations(animations)
        else
            warn(`{tool} Punch Folder Has No Animations`)
    end
end)


return {
    Play = PlayAnimation
}