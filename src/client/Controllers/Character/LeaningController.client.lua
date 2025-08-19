local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ROLL_ANGLE = math.rad(15)
local PITCH_ANGLE = math.rad(15)
local LEAN_SPEED = 10

local player = Players.LocalPlayer
local stepConnection: RBXScriptConnection? = nil

local function setupCharacter(character: Model)
    if stepConnection then
        stepConnection:Disconnect()
        stepConnection = nil
    end

    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")
    local rootJoint = character:WaitForChild("LowerTorso"):WaitForChild("Root")

    local leanCFrame = CFrame.new()

    local function onStepped(_: number, deltaTime: number)
        if not humanoid.Parent then
            -- Character was removed, clean up
            stepConnection:Disconnect()
            stepConnection = nil
            return
        end

        local moveVelocity = humanoid:GetMoveVelocity()
        local relativeVelocity = root.CFrame:VectorToObjectSpace(moveVelocity)

        -- Calculate pitch and roll
        local pitch = 0
        local roll = 0
        if humanoid.WalkSpeed ~= 0 then
            pitch = math.clamp(relativeVelocity.Z / humanoid.WalkSpeed, -1, 1) * PITCH_ANGLE
            roll = -math.clamp(relativeVelocity.X / humanoid.WalkSpeed, -1, 1) * ROLL_ANGLE
        end

        leanCFrame = leanCFrame:Lerp(CFrame.Angles(pitch, 0, roll), math.min(deltaTime * LEAN_SPEED, 1))
        rootJoint.Transform = leanCFrame * rootJoint.Transform
    end

    stepConnection = RunService.Stepped:Connect(onStepped)
end

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
    setupCharacter(player.Character)
end
