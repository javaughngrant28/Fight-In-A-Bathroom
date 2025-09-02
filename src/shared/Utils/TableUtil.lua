
-- Returns A new Table With Only The Indexes That Start With The Given Filter
local function FilterIndex(filter: string, theTable: {[string]: any}) :{string}
    local indexTable = {}
    
    for key, _ in pairs(theTable) do
        if string.sub(key, 1, #filter) == filter then
            table.insert(indexTable, key)
        end
    end
    
    return indexTable
end

return {
    GetIndexListByFilter = FilterIndex
}