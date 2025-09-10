

local LoadAnimations = require(script.Parent.Parent.Parent.Parent.Components.LoadAnimations)
local ToolDetectore = require(script.Parent.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()
local WeaveLeftAnimationTracks: {AnimationTrack}


local function UpdateAnimation(animation: Animation)
    local loadAnimations = LoadAnimations.new({animation})
    Maid['LoadedAnimations'] = loadAnimations
    WeaveLeftAnimationTracks = loadAnimations.ANIMATIONTRACKS
end

ToolDetectore.EquippedSignal:Connect(function(tool: Tool)
    local toolType = tool:GetAttribute('Type')
    if toolType ~= WeaponEnum.Types.Melee then return end
    
    local AnimationFolder = tool:FindFirstChild('Weave',true)
    assert(AnimationFolder,`{tool} Has No Weave Animation Folder`)

    local Animation = AnimationFolder:FindFirstChild('Righ')
    assert(Animation,`{tool} {Animation} Has No Weave Left Animation`)

    UpdateAnimation(Animation)
end)


local function PlayAnimation()
    WeaveLeftAnimationTracks[1]:Play()
end

return {
    Play = PlayAnimation,
}