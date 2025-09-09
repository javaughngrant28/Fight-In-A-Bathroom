local Workspace = game:GetService("Workspace")


local Throw = require(game.ReplicatedStorage.Shared.Modules.Throw)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local AOE = require(script.Parent.AOE)
local Player = require(script.Parent.Player)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)

local Maid: MaidModule.Maid = MaidModule.new()

export type ThrowInfo = {
    Character : Model,
    Model: Model,
    BodyPartName: string?,
    LookAt: Vector3,
    Duration: number,
    Distance: number,
    Damge: number,
    AOE: boolean?,
    DamageRadius: Vector3?,
}

local function Hit(hit: BasePart, throwInfo: ThrowInfo)
    if not hit.Parent:IsA("Model") then return end
    local Humanoid = hit:FindFirstChildWhichIsA('Humanoid') :: Humanoid
    assert(Humanoid,`{hit} Has No Humanoid`)

    Humanoid:TakeDamage(throwInfo.Damge)
end



local function CreateHitConnection(part: BasePart, throwInfo: ThrowInfo)
    local Character: Model = throwInfo.Character
    local Connection: RBXScriptSignal

    Connection = part.Touched:Connect(function(hit: BasePart)
        if hit.Parent == Character then return end
        Connection:Disconnect()
        Connection = nil

        if throwInfo.AOE then
            AOE.Fire(part.CFrame.Position,throwInfo)
            else
                Hit(hit,throwInfo)
        end

        part:Destroy()
    end)
end

local function ThrowDebounce(Character: Model)
    local player: Player? = Player.Get(Character)
    if not player then return end

    player:SetAttribute(CombatCooldowns.Throw.ATTRIBUTE_NAME,true)

    task.delay(CombatCooldowns.Throw.DURATION,function()
        player:SetAttribute(CombatCooldowns.Throw.ATTRIBUTE_NAME,false)
    end)
end


local function ThrowModel(throwInfo: ThrowInfo)
    local originPart = throwInfo.Character:FindFirstChild(throwInfo.BodyPartName) or throwInfo.Character:FindFirstChild('HumanoidRootPart') :: Part
    assert(originPart,`{throwInfo.Character} Has No Humanoid Root Part`)
    assert(throwInfo.Model.PrimaryPart,`{throwInfo.Model} Has No PrimaryPart`)

    local targetPosition = throwInfo.LookAt * throwInfo.Distance
    local modelClone: Model = throwInfo.Model:Clone()

    modelClone.Parent = Workspace
    modelClone.PrimaryPart.CFrame = originPart.CFrame

    ThrowDebounce(throwInfo.Character)
    
    CreateHitConnection(modelClone.PrimaryPart,throwInfo)
    Throw.AtPosition(modelClone.PrimaryPart,targetPosition,throwInfo.Duration)
end


return {
    Fire = ThrowModel,
    Damge = Hit,
}