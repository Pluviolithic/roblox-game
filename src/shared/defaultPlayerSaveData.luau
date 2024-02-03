local ReplicatedStorage = game:GetService "ReplicatedStorage"

local t = require(ReplicatedStorage.Common.lib.t)

return {
	data = {
		stats = {
			Money = 0,
			Gems = 0,
		},
	},
	validate = t.strictInterface {
		stats = t.strictInterface {
			Money = t.number,
			Gems = t.number,
		},
	},
}
