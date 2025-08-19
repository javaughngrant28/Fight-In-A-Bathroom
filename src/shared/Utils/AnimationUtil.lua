local AnimationUtil = {}

function AnimationUtil.LoadAnimationTrack(character: Model, animation: string | Animation): AnimationTrack
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("No Humanoid found in character")
        return nil
    end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        warn(`No animator found in {character}`)
        return nil
    end

    local newAnimaton: Animation

    if animation:IsA('Animation') then
        newAnimaton = animation:Clone()
        else
            newAnimaton = Instance.new('Animation')
            newAnimaton.AnimationId = animation
    end

    local track = animator:LoadAnimation(newAnimaton)
    animation:Destroy()
    return track
end

function AnimationUtil.CreateAnimationTracks(character: Model, animations: {[string | number]: Animation | string}): {[string | number]: AnimationTrack}
    local animationTracks = {}
    for index, id in pairs(animations) do
        local track = AnimationUtil.LoadAnimationTrack(character, id)
        if not track then continue end
        animationTracks[index] = track
    end
    return animationTracks
end

function AnimationUtil.PlayTrackForDuration(animationTrack: AnimationTrack, duration: number)
    if not animationTrack or not animationTrack:IsA("AnimationTrack") then
        warn("Invalid AnimationTrack provided.")
        return
    end

    local animationLength = animationTrack.Length
    if animationLength <= 0 then
        warn("Animation length is invalid or zero.")
        return
    end

    local playbackSpeed = animationLength / duration
    animationTrack:Play()
    animationTrack:AdjustSpeed(playbackSpeed)
end

return AnimationUtil
