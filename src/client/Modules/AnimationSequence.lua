

local AnimationLoader = require(script.Parent.Parent.Components.LoadAnimations)



local AnimationSequence = {}
AnimationSequence.__index = AnimationSequence

export type AnimationSequenceType = typeof(setmetatable({} :: {
    AnimationLoader: AnimationLoader.AnimationLoaderType,
    Combo: number,
}, AnimationSequence))



function AnimationSequence.new(animationList: {Animation}): AnimationSequenceType
    local self = setmetatable({
        AnimationLoader = AnimationLoader.new(animationList),
        Combo = 1,
    }, AnimationSequence)
    
    return self
end

function AnimationSequence.Play(self: AnimationSequenceType, playbackSpeed: number?, weight: number?, fadeTime: number)
    local animationTracks = self.AnimationLoader.ANIMATIONTRACKS
    local animationTrack = animationTracks[self.Combo] :: AnimationTrack
    if not animationTrack then warn(`Animation Tack Not Found Combo: {self.Combo}`,animationTracks) return end

    animationTrack:Play(fadeTime,weight,playbackSpeed)
    print(self.Combo,#self.AnimationLoader.ANIMATIONTRACKS)

    local newCombo = self.Combo + 1
    if newCombo > #self.AnimationLoader.ANIMATIONTRACKS then
        self.Combo = 1
        else
            self.Combo = newCombo
    end
end

function AnimationSequence.Destroy(self: AnimationSequenceType)
    self.AnimationLoader:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return AnimationSequence

