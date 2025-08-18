local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")


local Player = Players.LocalPlayer

local function OnPreferredInputChanged()
    Player:SetAttribute('InputType',UserInputService.PreferredInput)
end


UserInputService:GetPropertyChangedSignal('PreferredInput'):Connect(OnPreferredInputChanged)
OnPreferredInputChanged()