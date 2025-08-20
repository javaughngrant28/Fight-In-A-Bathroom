local Debris = game:GetService("Debris")

export type Target = {
	Name: string,
	Humanoid: Humanoid,
	HumanoidRootPart: BasePart,
	PrimaryPart: BasePart?,
}

local HitboxPart = Instance.new('Part')
HitboxPart.Transparency = 0.8
HitboxPart.Massless = true
HitboxPart.Anchored = false
HitboxPart.CanCollide = false
HitboxPart.CanQuery = false
HitboxPart.BrickColor = BrickColor.new('Really red')

local DEFAULT_OFFSET = Vector3.new(0,0,-(6.2 * 0.2))
local DEFAULT_SIZE = Vector3.new(6,6,6)


local Hitbox = {}

function Hitbox.Fire(character: Model,size: Vector3?, offset: Vector3?): {Target: Target} | {}
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoidRootPart or not humanoid then return {} end
	
	local offset = offset or DEFAULT_OFFSET
	local size = size or DEFAULT_SIZE

	local part = HitboxPart:Clone()
	part.Parent = workspace
	part.Size = size
	part.CFrame = humanoidRootPart.CFrame * CFrame.new(offset)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = humanoidRootPart
	weld.Part1 = part
	weld.Parent = part

	local nearestCharacter = nil
	local touchConnection = part.Touched:Connect(function() end)
	local touchingParts = part:GetTouchingParts()

	for _, touchedPart in ipairs(touchingParts) do
		local char = touchedPart.Parent
		local targetHumanoid: Humanoid = char:FindFirstChild("Humanoid")
		local charHRP: Part = char:FindFirstChild("HumanoidRootPart")
		local forceFeild: ForceField = char:FindFirstChild('ForceField')

		if forceFeild then continue end
		if char == character then continue end
		if not charHRP then continue end
		if not targetHumanoid then continue end
		if targetHumanoid.Health <= 0 then continue end

		if not nearestCharacter then
			nearestCharacter = char
			continue
		end

		local nearestHRP: Part = nearestCharacter:FindFirstChild("HumanoidRootPart")
		if (humanoidRootPart.Position - nearestHRP.Position).Magnitude > (humanoidRootPart.Position - charHRP.Position).Magnitude then
			nearestCharacter = char
		end
	end

	touchConnection:Disconnect()
	Debris:AddItem(part, 0.4)

	if nearestCharacter then
		return { Target = nearestCharacter}
	end

	return {}
end

return Hitbox