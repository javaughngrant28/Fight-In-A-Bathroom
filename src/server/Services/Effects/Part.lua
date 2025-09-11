local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(0.2,0.2,0.2)
part.Transparency = 0.8
part.BrickColor = BrickColor.new('Really red')


return {
    Clone = function(): Part
        return part:Clone()
    end
}