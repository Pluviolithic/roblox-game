local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Rodux = require(ReplicatedStorage.Common.lib.Rodux)
local reducers = {}

for _, reducer in script:GetChildren() do
	reducers[reducer.Name] = require(reducer)
end

return Rodux.combineReducers(reducers)
