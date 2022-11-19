local spawn1 = false

AddEventHandler("ev-base:spawnInitialized", function()
	if not spawn1 then
		ShutdownLoadingScreenNui()
		ShutdownLoadingScreen()
		spawn1 = true
	end
end)