-- wait for game full loaded
repeat task.wait() until game:IsLoaded()

if shared.baya then shared.baya:Uninject() end
if shared.Init then return end

shared.Init = true -- prevents multiple intances

-- maybe add kill switch here is not allowed? Using Whitelist!
if identifyexecutor then
    if table.find({"Argon", "Wave"}, ({identifyexecutor()})[1]) then
		getgenv().setthreadidentity = nil;
	end
end

local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n";
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaUILibrary/main/src.lua", true))();

local loadstring = function(...)
	local res, err = loadstring(...)
	if err and library then
		library:CreateNotification("Baya", "Failed to load : " .. err, 30, "Alert")
	end
	return res
end

local queue_on_teleport = queue_on_teleport or function() end

local function DownloadFile(path, func)
	if not isfile(path) then
		local correct = select(1, path:gsub("Baya/", ""));

		local suc, res = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/" .. readfile("Baya/Commits/Hub.txt") .. "/" .. correct, true)
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

local function WipeFolder(path)
	if not isfolder(path) then return end

	local string = string.gsub(marked, "\n", "")

	for _, file in listfiles(path) do
		if file:find("loader") then continue end

		local search = select(1, readfile(file):find(string))

		if isfile(file) and search == 1 then
			delfile(file);
		end
	end
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
	if not shared.baya then return end
	
    library:Load() -- load

    local teleportedServers

    library:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
        if (not teleportedServers) then
            teleportedServers = true

            local teleportScript = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/" .. readfile("Baya/Commits/Hub.txt") .. "/loader.lua", true), "loader")()
            ]]

            queue_on_teleport(teleportScript);
        end
    end))
end

-- get hub
local _, subbed = pcall(function()
    return game:HttpGet("https://github.com/fisiaque/BayaForRoblox")
end)

local commit = subbed:find("currentOid");
commit = commit and subbed:sub(commit + 13, commit + 52) or nil;
commit = commit and #commit == 40 and commit or "main";

if commit == "main" or (isfile("Baya/Commits/Hub.txt") and readfile("Baya/Commits/Hub.txt") or "") ~= commit then
	WipeFolder("Baya/Games");

	if isfile("Baya/Commits/Hub.txt") then
		delfile("Baya/Commits/Hub.txt")
	end
end

writefile("Baya/Commits/Hub.txt", commit);

-- create main library gui
local main = library:CreateGUI();

-- bind library to global variable: shared.baya
shared.baya = library;

-- load Universal
loadstring(DownloadFile('Baya/Games/universal.lua'), 'universal')()

-- load games
local suc, res = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/" .. readfile("Baya/Commits/Hub.txt") .. "/Games/" .. game.PlaceId .. ".lua", true)
end)
if suc and res ~= "404: Not Found" then
    loadstring(DownloadFile("Baya/Games/" .. game.PlaceId .. ".lua"), tostring(game.PlaceId))(...);
end

-- Information
local info = main:CreateInfoPane()

-- create divider
info:CreateDivider({
	Text = playersService.LocalPlayer.Name; -- test for now
	Alignment = Enum.TextXAlignment.Center;
})

-- Settings
libraryapi.Categories.Main:CreateSettingBar()

local uiSettings = libraryapi:CreateSetting({
	Name = "Test";
	Icon = getcustomasset("Baya/Assets/Cog.png");
	Size = UDim2.fromOffset(16, 12);
	Position = UDim2.fromOffset(12, 14);
	Function = function(val)
		library:CreateNotification("Settings[test]", tostring(val), 2, "Alert")
	end
});

-- finish load
FinishLoading();