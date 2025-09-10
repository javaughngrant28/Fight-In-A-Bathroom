
export type CutseneInfo = {
    Character1: Model,
    Character2: Model,
    Animation1: Animation,
    Animation2: Animation,
    DistanceBetween: number,
}

local function GetHumanoid(character: Model): Humanoid?
    return character:FindFirstChildWhichIsA('Humanoid')
end

local function GetRootPart(character: Model): Part?
    return character:FindFirstChild('HumanoidRootPart') or character.PrimaryPart
end

local function CreateWeld(rootPart1: Part, rootPart2: Part): Weld
    local Weld = Instance.new('Weld')
    Weld.Part0 = rootPart1
    Weld.Part1 = rootPart2
    Weld.Parent = Weld
end

local function LoadAnimation(character: Model,animation: Animation): AnimationTrack
    local animator = character:FindFirstChildWhichIsA('Animator') :: Animator
    local AnimationTrack = animator:LoadAnimation(animation)
    return AnimationTrack
end

local function PlayCutsene(cutseneInfo: CutseneInfo): (AnimationTrack, AnimationTrack)
    local humanoid1 = GetHumanoid(cutseneInfo.Character1)
    local humanoid2 = GetHumanoid(cutseneInfo.Character2)
    local rootPart1 = GetRootPart(cutseneInfo.Character1)
    local rootPart2 = GetRootPart(cutseneInfo.Character2)

    humanoid1:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid2:ChangeState(Enum.HumanoidStateType.Physics)

    local animationTrack1 = LoadAnimation(cutseneInfo.Character1,cutseneInfo.Animation1)
    local animationTrack2 = LoadAnimation(cutseneInfo.Character2,cutseneInfo.Animation2)

    local weld = CreateWeld(rootPart1,rootPart2)

    local facingCFrame = rootPart1.CFrame
    local offsetCFrame = facingCFrame * CFrame.new(0,0, -cutseneInfo.DistanceBetween)
    rootPart2.CFrame = offsetCFrame

    animationTrack1:Play()
    animationTrack2:Play()

    animationTrack1.Stopped:Once(function()
        weld:Destroy()
        humanoid1:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        humanoid2:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    end)

    return animationTrack1, animationTrack2
end

return {
    Play = PlayCutsene
}