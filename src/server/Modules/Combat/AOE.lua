local Players = game:GetService("Players")

local Throw = require(script.Parent.Throw)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)

local DURATION = 0.4

local PART = Instance.new('Part')
PART.Anchored = true
PART.CanCollide = false
PART.CanQuery = false
PART.CanTouch = true
PART.BrickColor = BrickColor.new('Really red')
PART.Transparency = 0.8

local function GetPlayer(Character: Model): Player?
    local player: Player?

    if Character then
        player = Players:GetPlayerFromCharacter(Character)
    end

    return player
end


local function Damge(hit: BasePart, damge: number)
    if not hit.Parent:IsA("Model") then return end
    local Humanoid = hit:FindFirstChildWhichIsA('Humanoid') :: Humanoid
    assert(Humanoid,`{hit} Has No Humanoid`)

    Humanoid:TakeDamage(damge)
end

local function ClearConnecctionOnDestred(hitbox: Part, connection: RBXScriptSignal)
    local ancestryChangedConnection: RBXScriptSignal
    ancestryChangedConnection = hitbox.AncestryChanged:Connect(function(_, parent)
        if not parent or parent == nil then
            connection:Disconnect()
            ancestryChangedConnection:Disconnect()
            ancestryChangedConnection = nil
        end
    end)
end

local function hitDetection(Character: Model, hitbox: Part,damgeAmount: number)
    local connection: RBXScriptSignal

    connection = hitbox.Touched:Connect(function(hit: BasePart)
        if hit.Parent == Character then return end
        Throttle(hit.Parent.Name..'AOE',0.4,function()
            Damge(hit,damgeAmount)
        end)
    end)

    ClearConnecctionOnDestred(hitbox,connection)
end

local function CreateAOE(spawnPosition: Vector3, throwInfo: Throw.ThrowInfo)
    local hitbox: Part = PART:Clone()
    hitbox.Position = spawnPosition
    hitbox.Size = throwInfo.DamageRadius
    hitbox.Parent = workspace

    hitDetection(throwInfo.Character,hitbox,throwInfo.Damge)
    task.delay(DURATION,function()
        hitbox:Destroy()
    end)
end

return {
    Fire = CreateAOE,
}