local RATE = 1 	-- The percentage of max health that will be healed every x seconds.
local DELAY = 1		-- The delay before every heal.

local Char = script.Parent
local Hum = Char.Humanoid

while wait(DELAY) do
	Hum.Health = Hum.Health + (Hum.MaxHealth * RATE/100)
end