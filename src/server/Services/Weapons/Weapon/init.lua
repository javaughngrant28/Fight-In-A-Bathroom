
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local WeaponTypes = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponTypes)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local ToolConstrocter = require(script.Parent.ToolConstrocter)
local Combat = require(game.ServerScriptService.Modules.Combat)
local InputUtil = require(game.ReplicatedStorage.Shared.Utils.InputUtil)
local PlayerDataAPI = require(game.ServerScriptService.Services.Data.PlayerDataAPI)
local TransformData = require(game.ReplicatedStorage.Shared.Modules.TransformData)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)

-- TODO: Get Actual button Names
local BUTTON_SCREEN_NAME = 'Mobile Buttons'
local PUNCH_BUTTON_NAME = 'PunchBTN'
local KICK_BUTTON_NAME = 'KickBTN'
local BLOCK_BUTTON_NAME = 'BlockBTN'
local GRAB_BUTTON_NAME = 'GrabBTN'
local WEAVE_LEFT_BUTTON_NAME = 'WeaveLeftBTN'
local WEAVE_RIGHT_BUTTON_NAME = 'WeaveRightBTN'

local Weapon = {}
Weapon.__index = Weapon

export type WeaponInterface = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    PLAYER: Player,
    WEAPON_DATA: WeaponTypes.Data,
    WEAPON_NAME: string,
    TOOL: ToolConstrocter.ToolControllerType,
    INPUT_CONTEXT: InputContext,
}, Weapon))

function Weapon.new(player: Player, weaponName: string, weaponData: WeaponTypes.Data): WeaponInterface
    local self = setmetatable({
        _MAID = MaidModule.new(),
        PLAYER = player,
        WEAPON_NAME = weaponName,
        WEAPON_DATA = weaponData,
        TOOL = ToolConstrocter.new(weaponName,weaponData.Type)
    }, Weapon)

    self._MAID['Tool'] = self.TOOL
    self:_CreateModel()
    self:_CreateInputContext()

    self:_CreateEvent()
    self:_ConnectToEvent()

    self:_LoadAnimations()

    self.TOOL.INSTANCE.Parent = player.Backpack

    return self
end


function Weapon.Punch(self: WeaponInterface,player: Player, target: Model)
    local PunchData = {
        Player = player, 
        Target = target,
        Damage = self.WEAPON_DATA.Damage,
        EffectName = 'Hit1',
    }
    Combat.Punch.Fire(PunchData)
end

function Weapon.Kick(self: WeaponInterface, player: Player)
    
end

function Weapon.Grab(self: WeaponInterface, player: Player,target: Model?)
    local weaponData = self.WEAPON_DATA
    local cutseneInfo = weaponData.GrabCutscene
    local Character =player.Character
    assert(cutseneInfo,`{player} Wapon Has No Cutscene Data`)

    if Character:GetAttribute(StateEnum.ATTRIBUTE_NAME) ~= StateEnum.None then return end

    Combat.Grab.Fire(player.Character,target,cutseneInfo)
end

function Weapon.Weave(self: WeaponInterface, player: Player)
    
end

function Weapon.Block(self: WeaponInterface, player: Player, value: boolean)
    local Character: Model = self.PLAYER.Character

    if typeof(value) ~="boolean" then return end
    if Combat.State.Get(Character) == Combat.Enum.Block and value == false then return end
    if Combat.State.Get(Character) ~= Combat.Enum.Block and value == true then return end

    if value then
        Combat.Block.Activate(Character)
        else
            Combat.Block.Deactivate(Character)
    end
end

function Weapon.Throw(self: WeaponInterface, player: Player, lootAt: Vector3)
    local weaponData = self.WEAPON_DATA
    assert(lootAt and typeof(lootAt) == "Vector3",`{lootAt} Must Be Vetore3 To Throws`)

    local throwInfo = {
        Character = self.Character,
        Model = weaponData.Model,
        BodyPartName = weaponData.ThrowOriginName,
        LookAt = lootAt,
        Duration = weaponData.ThrowDuration,
        Distance = weaponData.ThrowDistance,
        Damage = weaponData.Damage,
        AOE = weaponData.AOE,
        DamageRadius = weaponData.AOE_Radius,
    }

    Combat.Throw.Fire(throwInfo)
end

function Weapon._ConnectToEvent(self: WeaponInterface)
    local function onEventFired(player: Player, index: string,...)
        local ActionMethod = self:__GetActionMethod(index)
        assert(ActionMethod,`{player} {self.WEAPON_NAME} {self.WEAPON_DATA.Type} {index} No Action Method Found`)

        ActionMethod(self,player,...)
    end

    self._MAID['EventConenction'] = self.TOOL.EVENT.OnServerEvent:Connect(onEventFired)
end

function Weapon._CreateInputContext(self: WeaponInterface)
    if self.WEAPON_DATA.Type ~= WeaponEnum.Types.Melee then return end
    local keybinds = PlayerDataAPI.GetKeybinds(self.PLAYER)
    local ScreenGui = self.PLAYER.PlayerGui:FindFirstChild(BUTTON_SCREEN_NAME)

    local inputTable = {
        [Combat.Enum.Punch] = {
           table.unpack(keybinds.Punch),
           ScreenGui:FindFirstChild(PUNCH_BUTTON_NAME,true)
        },
        [Combat.Enum.Block] = {
           table.unpack(keybinds.Block),
           ScreenGui:FindFirstChild(BLOCK_BUTTON_NAME,true)
        },
        [Combat.Enum.Kick] = {
           table.unpack(keybinds.Kick),
           ScreenGui:FindFirstChild(KICK_BUTTON_NAME,true)
        },
        [Combat.Enum.Grab] = {
           table.unpack(keybinds.Grab),
           ScreenGui:FindFirstChild(GRAB_BUTTON_NAME,true)
        },
        [Combat.Enum.WeaveLeft] = {
           table.unpack(keybinds.WeaveLeft),
           ScreenGui:FindFirstChild(WEAVE_LEFT_BUTTON_NAME,true)
        },
        [Combat.Enum.WeaveRight] = {
           table.unpack(keybinds.WeaveRight),
           ScreenGui:FindFirstChild(WEAVE_RIGHT_BUTTON_NAME,true)
        },
    }

    local inputContext = InputUtil.Create(self.WEAPON_NAME,inputTable)
    
    inputContext.Parent = self.PLAYER
    self.INPUT_CONTEXT = inputContext
    self._MAID['InputContext'] =  inputContext
end

function Weapon._CreateEvent(self: WeaponInterface)
    local Event = Instance.new('RemoteEvent')
    self._MAID['Event'] = Event
    self.EVENT = Event

    local weaponType = self.WEAPON_DATA.Type
    local enumTypes = WeaponEnum.Types
    local tool: Tool = self.TOOL.INSTANCE
    local inputContext = self.INPUT_CONTEXT
    
    Event.Parent = weaponType == enumTypes.Range and tool or inputContext
end

function Weapon._CreateModel(self: WeaponInterface)
    local weaponModel: Model? = self.WEAPON_DATA.Model
    if not weaponModel then return end
    assert(weaponModel.PrimaryPart,`{weaponModel} Does Not Have A PrimaryPart`)
    
    local modelClone = weaponModel:Clone()
    modelClone.Parent = self.TOOL.INSTANCE

    self._MAID['Model'] = modelClone
end


function Weapon._LoadAnimations(self: WeaponInterface)
    local animations = self.WEAPON_DATA.Animations
    local folder = Instance.new('Folder')

    TransformData.ToInstance(folder,animations,true)
    
    folder.Name = 'Animations'
    folder.Parent = self.TOOL.INSTANCE
end

function Weapon.__GetActionMethod(self: WeaponInterface, eventIndex: string): (self: WeaponInterface,player: Player,...any?)->()?
    local weaponType = self.WEAPON_DATA.Type
    local Method: (self: WeaponInterface,player: Player,...any?)->()?

    if eventIndex == Combat.Enum.Punch and weaponType == WeaponEnum.Types.Melee then
        Method = self.Punch
    end

    if eventIndex == Combat.Enum.Grab and weaponType == WeaponEnum.Types.Melee then
        Method = self.Grab
    end

    if eventIndex == Combat.Enum.Kick and weaponType == WeaponEnum.Types.Melee then
        Method = self.Kick
    end

    if eventIndex == Combat.Enum.Weave and weaponType == WeaponEnum.Types.Melee then
        Method = self.Weave
    end

    if eventIndex == Combat.Enum.Block and weaponType == WeaponEnum.Types.Melee then
        Method = self.Block
    end

    if eventIndex == Combat.Enum.Throw and weaponType == WeaponEnum.Types.Range then
        Method = self.Throw
    end

    return Method
end

function Weapon.Destroy(self: WeaponInterface)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return Weapon

