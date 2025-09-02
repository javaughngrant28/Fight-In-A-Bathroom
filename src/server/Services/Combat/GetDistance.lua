
local function GetDistanceBetweenModels(a: Model, b: Model): number
    local rootPartA = a:FindFirstChild("HumanoidRootPart") or a.PrimaryPart
    local rootPartB = b:FindFirstChild("HumanoidRootPart") or b.PrimaryPart

    return (rootPartA.Position - rootPartB.Position).Magnitude
end

return {
    BetweenModels = GetDistanceBetweenModels
}
