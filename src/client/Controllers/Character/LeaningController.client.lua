local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local tiltConnection: RBXScriptConnection = nil  -- Connection to manage RenderStepped

local MaxTiltAngle = 8

-- Function to start the tilting effect
local function startTilting(character: Model)
	local humanoid = character:WaitForChild('Humanoid', 30)
	local rootPart = character:WaitForChild('HumanoidRootPart', 30)
	local rootJoint = rootPart:WaitForChild('RootJoint', 30)
	local rootC0 = rootJoint.C0

	local tilt = CFrame.new()

	tiltConnection = RunService.RenderStepped:Connect(function(delta)
		local moveDirection = rootPart.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
		tilt = tilt:Lerp(CFrame.Angles(math.rad(-moveDirection.Z) * MaxTiltAngle, math.rad(-moveDirection.X) * MaxTiltAngle, 0), 0.2 ^ (1 / (delta * 60)))
		rootJoint.C0 = rootC0 * tilt
	end)
end

-- Function to stop the tilting effect
local function stopTilting()
	if tiltConnection then
		tiltConnection:Disconnect()
		tiltConnection = nil
	end
end

-- Character added/removed event handlers
local function onCharacterAdded(character: Model)
	if not character then return end
	startTilting(character)
end

local function onCharacterRemoving()
	stopTilting()
end


onCharacterAdded(LocalPlayer.Character)

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
