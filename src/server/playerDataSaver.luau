local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Reflex = require(ReplicatedStorage.Common.lib.reflex)
local producer = require(ServerScriptService.Server.producer)
local documents = require(ServerScriptService.Server.documents)

local function selectStats(state: producer.RootState)
	return state.stats
end

local function getPlayerId(_, index: string)
	return index
end

local function selectStatsById(id: string)
	return function(state: producer.RootState)
		return state.stats[id]
	end
end

local function selectPlayerData(id: string)
	return Reflex.createSelector(selectStatsById(id), function(stats)
		print(stats)
		if not stats then
			return
		end
		return {
			stats = stats,
		}
	end)
end

producer:observe(selectStats, getPlayerId, function(_, index)
	print("Player added:", index)
	local unsubscribe = producer:subscribe(selectPlayerData(index), function(data)
		print(data)
		if documents[index] then
			documents[index]:write(data)
		end
	end)
	return unsubscribe
end)

return 0
