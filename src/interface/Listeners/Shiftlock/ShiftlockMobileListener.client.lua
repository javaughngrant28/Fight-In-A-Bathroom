
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shiftlock = require(ReplicatedStorage.Shared.Modules.Shiftlock)
local Observers = require(ReplicatedStorage.Shared.Libraries.Observers)
local Throttle = require(ReplicatedStorage.Shared.Libraries.Throttle)

local Player = Players.LocalPlayer
local PlayerGui = script.Parent.Parent.Parent.Parent


local ButtonImages = {
	OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
	ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
}



local function ButtonActivatedConnection(button: ImageButton) : RBXScriptConnection
    return button.Activated:Connect(function()
       Shiftlock.Toggle()
    end)
end

-- Updates Button Image When Shiftlock Attribute Changes
local function ShiftlockAttributeObserver(button: ImageButton): () -> ()
    return Observers.observeAttribute(Player,"ShiftlockEnabled",function(value: boolean)
        button.Image = value and ButtonImages.ON or ButtonImages.OFF
    end)
end

-- Toggles Visiblity Of Shiflock button depending on player input type
local function InputAttributeObserver(button: ImageButton): () -> ()
    return Observers.observeAttribute(Player,'InputType',function(value: Enum.PreferredInput)
        button.Visible = value ~= Enum.PreferredInput.KeyboardAndMouse
    end)
end

local function ScreenAdded(screen: ScreenGui)
    local button = screen:FindFirstChildWhichIsA('ImageButton',true) :: ImageButton
    assert(button,`{Player} {screen} No Image Button Found`)

    local Connection = ButtonActivatedConnection(button)
    local StopShiftlockObserver = ShiftlockAttributeObserver(button)
    local StopInputObserver = InputAttributeObserver(button)

    return function ()
        Connection:Disconnect()
        Connection = nil

        StopShiftlockObserver()
        StopInputObserver()
    end
end


Observers.observeChildren(PlayerGui,ScreenAdded,function(child: Instance)
    return child.Name == "Shiftlock"
end)
