
local ThrowAtPosition = function(part: Part, position: Vector3, duration: number?)
    local speed = duration or 0.4

    local mass = part:GetMass()
    local origin = part.Position
    local direction = (position - origin).Unit

    local velocity = direction * speed
    local impulse = velocity * mass

    part:ApplyImpulse(impulse)
end

return {
    AtPosition = ThrowAtPosition
}
