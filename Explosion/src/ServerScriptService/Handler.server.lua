local Explode = require(game.ServerScriptService.Explode)

workspace.Button.ClickDetector.MouseClick:Connect(function()
	Explode.Start()
end)