
local KeyMapper = require(script.Parent.Parent.Modules.KeyMapper)

type InputName = string
type ActionName = string

type InputData = {
    string | GuiButton
}
type InputTable = { [InputName]: InputData}

local function CreateInput(contextName: string, inputTable: InputTable): InputContext
    local inputContext = Instance.new('InputContext')
    inputContext.Name = contextName
    inputContext.Enabled = false

    for inputName: string, data: InputTable in inputTable do
        local InputAction = Instance.new('InputAction')
        InputAction.Parent = inputContext
        InputAction.Name = inputName

        for _, value in data[inputName] do
            local InputBinding = Instance.new("InputBinding")
            InputBinding.Parent = InputAction

            if typeof(value) == "Instance" and value:IsA('GuiButton') then
               InputBinding.UIButton = value
               continue
            end

            if typeof(value) =="string" then
                local key = KeyMapper.GetEnumFromString(value)
                InputBinding.Down = key
                continue
            end

            warn(`{inputName} Unsoported Type {typeof(value)} {value}`)
        end
    end

    return inputContext
end


return {
    Create = CreateInput
}