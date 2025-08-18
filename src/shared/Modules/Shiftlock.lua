
assert(game:GetService("RunService"):IsClient(),`Shitlock Modudle Can Only Be Rquired On Client`)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')

local playerModule = require(PlayerScripts:WaitForChild('PlayerModule'))

Player:SetAttribute('ShiftlockEnabled',false)



local function EnableShiftlock(value: boolean)
    local activeCameraController = playerModule:GetCameras().activeCameraController
	if activeCameraController and activeCameraController.SetIsMouseLocked then
		activeCameraController:SetIsMouseLocked(value)
	end

	Player:SetAttribute('ShiftlockEnabled',value)
end


local function ToggleShiftlock()
	local value = not Player:GetAttribute('ShiftlockEnabled')
	EnableShiftlock(value)
end


return {
    SetEnabled = EnableShiftlock,
	Toggle = ToggleShiftlock,
}