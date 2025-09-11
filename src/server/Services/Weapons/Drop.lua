
local WeaponData = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponData)
local InventoryAPI = require(game.ServerScriptService.Services.Inventory.InventoryAPI)
local WeaponAPI = require(script.Parent.WeaponAPI)

local DROPPED_ITEM_LIFETIME = 10


local function CreatePrompt(parentModel: Model): ProximityPrompt
    local ProximityPrompt = Instance.new('ProximityPrompt')
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Name = 'Prompt'
    ProximityPrompt.HoldDuration = 1
    ProximityPrompt.ActionText = "PICK UP"
    ProximityPrompt.Parent = parentModel:FindFirstChildWhichIsA('BasePart',true)
    return ProximityPrompt
end

local function MakeVisiblePartsCollidable(Model: Model)
    for _, child: Part in Model:GetDescendants() do
        if not child:IsA('BasePart') then continue end
        if child.Transparency == 1 then return end
        child.CanCollide = true
        child.CanTouch = false
        child.CanQuery = false
    end
end

local function onPickUp(player: Player, weaponName: string)
    InventoryAPI.Weapon.Add(player,weaponName)
    WeaponAPI.CreateAllEquipped(player)
end

local function PromptTriggeredConnection(parentModel: Model, weaponName: string)
    local Prompt = CreatePrompt(parentModel)

    local TriggeredConnection: RBXScriptConnection
    local DetroyedConnection: RBXScriptConnection

    local function CleanupConnections()
        TriggeredConnection:Disconnect()
        TriggeredConnection = nil
        DetroyedConnection:Disconnect()
        DetroyedConnection = nil
    end

    TriggeredConnection = Prompt.Triggered:Once(function(player: Player)
        CleanupConnections()
        onPickUp(player,weaponName)
        parentModel:Destroy()
    end)

    DetroyedConnection = parentModel.AncestryChanged:Connect(function(_, parent)
        if not parent then
            CleanupConnections()
        end
    end)
end

local function DestroyDroppedItemAfterDuration(model: Model)
    task.delay(DROPPED_ITEM_LIFETIME,function()
        if not model or model.Parent == nil then return end
        model:Destroy()
    end)
end

local function DropWeapon(weaponName: string, position: Vector3)
    local data = WeaponData.Get(weaponName)
    local model = data.Model:Clone()

    MakeVisiblePartsCollidable(model)
    PromptTriggeredConnection(model)

    model.PrimaryPart.CFrame = CFrame.new(position)
    model.Parent = workspace
    
    DestroyDroppedItemAfterDuration(model)
end


return {
    Fire = DropWeapon
}