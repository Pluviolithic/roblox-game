local ReplicatedStorage = game:GetService "ReplicatedStorage"

local immut = require(ReplicatedStorage.Common.lib.immut)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)

export type StatsProducer = Reflex.Producer<StatsState, StatsActions>

export type StatsState = {
	stats: { [string]: {
		[string]: number,
	} },
}

export type StatsActions = {
	addPlayerData: (player: Player, data: any) -> (),
	incrementPlayerStat: (player: Player, stat: string, amount: number) -> (),
}

local initialState: StatsState = {
	stats = {},
}

local statsSlice = Reflex.createProducer(initialState, {
	addPlayerData = function(state: StatsState, player: Player, data: any): StatsState
		return immut.produce(state, function(draft)
			draft[player.Name] = data.stats
		end) :: StatsState
	end,
	incrementPlayerStat = function(state: StatsState, player: Player, stat: string, amount: number): StatsState
		return immut.produce(state, function(draft)
			draft[player.Name][stat] = (draft[player.Name][stat] or 0) + amount
		end) :: StatsState
	end,
}) :: StatsProducer

return {
	statsSlice = statsSlice,
}
