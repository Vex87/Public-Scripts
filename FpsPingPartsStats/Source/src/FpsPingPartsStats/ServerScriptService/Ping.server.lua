-- // Variables \\ --

local RemoteEvent = game.ReplicatedStorage.Ping

-- // Functions \\ --

RemoteEvent.OnServerInvoke = function()
	return true
end