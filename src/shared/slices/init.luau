local stats = require(script.stats)

export type SharedState = {
	stats: stats.StatsState,
}

export type SharedActions = stats.StatsActions

return {
	stats = stats.statsSlice,
}
