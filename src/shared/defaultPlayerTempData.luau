local ReplicatedStorage = game:GetService "ReplicatedStorage"

local t = require(ReplicatedStorage.Common.lib.t)

return {
	data = {
		stats = {
			Health = 0,
		},
	},
	validate = t.strictInterface {
		stats = t.strictInterface {
			Health = t.number,
		},
	},
}
