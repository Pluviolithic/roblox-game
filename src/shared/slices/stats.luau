local ReplicatedStorage = game:GetService "ReplicatedStorage"

local immut = require(ReplicatedStorage.Common.lib.immut)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)

export type StatsProducer = Reflex.Producer<StatsState, StatsActions>

export type StatsState = {
	[string]: {
		[string]: number,
	},
}

export type StatsActions = {
	addPlayerData: (id: string, data: { [any]: any }) -> (),
	incrementStat: (id: string, stat: string, amount: number) -> (),
}

local initialState: StatsState = {}

local statsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: StatsState, id: string, data: any): StatsState
		return immut.produce(state, function(draft)
			draft[id] = data.stats
		end) :: StatsState
	end,
	incrementStat = function(state: StatsState, id: string, stat: string, amount: number): StatsState
		return immut.produce(state, function(draft)
			draft[id][stat] = (draft[id][stat] or 0) + amount
		end) :: StatsState
	end,
}) :: StatsProducer

return {
	statsSlice = statsSlice,
}
