-- FacingBack.lua
-- Utility module for checking if one character is facing the back of another

local FacingBack = {}

-- Default strictness: 0.5 ≈ 60° cone
local DEFAULT_THRESHOLD = 0.5

--[[
    IsFacingBack(charA: Model, charB: Model, threshold: number?): boolean
    Checks if charA is facing the back of charB.
    
    @param charA The character model doing the looking
    @param charB The character model being looked at
    @param threshold (optional) Value between -1 and 1, higher = stricter
    @returns boolean
]]
function FacingBack.Fire(charA: Model, charB: Model, threshold: number?): boolean
    threshold = threshold or DEFAULT_THRESHOLD

    local hrpA = charA:FindFirstChild("HumanoidRootPart")
    local hrpB = charB:FindFirstChild("HumanoidRootPart")

    if not (hrpA and hrpB) then
        warn("FacingBack: One of the characters has no HumanoidRootPart")
        return false
    end

    local forwardA = hrpA.CFrame.LookVector
    local forwardB = hrpB.CFrame.LookVector
    local directionAtoB = (hrpB.Position - hrpA.Position).Unit

    -- A must be facing towards B
    local facingAtoB = forwardA:Dot(directionAtoB)

    -- B must be facing away from A
    local facingBAwayFromA = forwardB:Dot(directionAtoB)

    return facingAtoB > threshold and facingBAwayFromA > threshold
end

return FacingBack
