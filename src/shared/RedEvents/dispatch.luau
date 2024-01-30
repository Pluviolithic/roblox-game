local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Red = require(ReplicatedStorage.Common.lib.Red)
local Guard = require(ReplicatedStorage.Common.lib.guard)

local actionCheck = Guard.Map(Guard.String, Guard.Any)

return Red.Event("dispatch", function(action)
	return actionCheck(action)
end)
