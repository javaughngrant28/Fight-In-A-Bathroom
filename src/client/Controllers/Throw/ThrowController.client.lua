
local Players = game:GetService("Players")

local ToolDetectore = require(script.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)

local Player = Players.LocalPlayer

local Maid: MaidModule.Maid = MaidModule.new()
local INDEX = CombatEnum.Throw

local function onToolActivaed(event: RemoteEvent)
    local character = Player.Character :: Model
    local rootPart = character:FindFirstChild('HumanoidRootPart') :: Part
    local throwAttributeCooldown = Player:GetAttribute(CombatCooldowns.Throw.ATTRIBUTE_NAME)

    if throwAttributeCooldown and throwAttributeCooldown == true then return end
    
    event:FireServer(INDEX,rootPart.CFrame.LookVector)
end

local function ValidateTool(tool: Tool)
    assert(tool:FindFirstChildWhichIsA('RemoteEvent'),`{tool} Has No Remote Event`)
    assert(tool:FindFirstChildWhichIsA('Model'),`{tool} Has No Model To Throw`)
end

ToolDetectore.AddedSignal:Connect(function(tool: Tool)
    local toolType = tool:GetAttribute('Type')
    if toolType ~= WeaponEnum.Types.Range then return end

    ValidateTool(tool)
    local event = tool:FindFirstChildWhichIsA('RemoteEvent')
    
    Maid[tool.Name] = tool.Activated:Connect(function()
        Throttle('Throw',0.4,onToolActivaed,tool,event)
    end)    
end)

