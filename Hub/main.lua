-- wait for game full loaded
repeat task.wait() until game:IsLoaded()

-- maybe add kill switch here is not allowed? Using Whitelist!

if identifyexecutor then
    if table.find({"Argon", "Wave"}, ({identifyexecutor()})[1]) then
		getgenv().setthreadidentity = nil;
	end
end

local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n";
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/main/src.lua", true))();
shared.library = library;

local loadstring = function(...)
	local res, err = loadstring(...)
	if err and library then
        print("Baya", "Failed to load : "..err, 30, "alert") -- REMOVE
	--	library:CreateNotification("Baya", "Failed to load : "..err, 30, "alert")
	end
	return res
end

local queue_on_teleport = queue_on_teleport or function() end

local function DownloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/"..readfile("Baya/Hub/commit.txt").."/"..select(1, path:gsub("Baya/", "")), true)
		end)

		if not suc or res == "404: Not Found" then
			error(res)
		end

		if path:find(".lua") then
			res = marked .. res
		end

		writefile(path, res)
	end

	return (func or readfile)(path)
end

local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ""
end

local cloneref = cloneref or function(obj)
	return obj
end

-- service
local playersService = cloneref(game:GetService("Players"))

-- local func
local function FinishLoading()
    library:Load() -- load

    local teleportedServers

    library:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
        if (not teleportedServers) then
            teleportedServers = true

            local teleportScript = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/" .. readfile("Baya/Hub/commit.txt") .. "/loader.lua", true), "loader")()
            ]]

            queue_on_teleport(teleportScript);
        end
    end))
end

-- load universal
loadstring(DownloadFile('Baya/Hub/Games/universal.lua'), 'universal')()

-- load games
local suc, res = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/"..readfile("Baya/Hub/commit.txt") .. "/Games/" .. game.PlaceId .. ".lua", true)
end)
if suc and res ~= "404: Not Found" then
    loadstring(DownloadFile("Baya/Hub/Games/" .. game.PlaceId .. ".lua"), tostring(game.PlaceId))(...);
end

-- finish load
FinishLoading();

-- testing
library:CreateGUI();
 
library:CreateCategory({
	Name = "Test0",
 	Icon = "Baya/UIAssets/ActionIcon.png",
 	Size = UDim2.fromOffset(13, 14)
});
 
library:CreateCategory({
 	Name = "Test1",
 	Icon = "Baya/UIAssets/PrayerIcon.png",
 	Size = UDim2.fromOffset(13, 14)
});
 
library:CreateCategory({
 	Name = "Test2",
 	Icon = "Baya/UIAssets/PrayerIcon.png",
 	Size = UDim2.fromOffset(13, 14)
});