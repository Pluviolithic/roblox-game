local ReplicatedStorage = game:GetService "ReplicatedStorage"

local slices = require(ReplicatedStorage.Common.slices)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)

export type RootProducer = Reflex.Producer<RootState, RootActions>

export type RootState = slices.SharedState

type RootActions = slices.SharedActions

local rootSlices = {}

for name, slice in slices do
	rootSlices[name] = slice
end

return Reflex.combineProducers(rootSlices) :: RootProducer
