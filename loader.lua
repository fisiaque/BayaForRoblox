-- variable
local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n"
local hubFolders = {"Baya/Hub", "Baya/Hub/Games"}

-- funcs
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)

	return suc and res ~= nil and res ~= ""
end
local delfile = delfile or function(file)
	writefile(file, "");
end

local function DownloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function() 
			print("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/"..readfile("Baya/Hub/commit.txt").."/"..select(1, path:gsub("Baya/", "")))
			return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/"..readfile("Baya/Hub/commit.txt").."/"..select(1, path:gsub("Baya/", "")), true)
		end)

		if not suc or res == "404: Not Found" then
			error(res);
		end

		if path:find(".lua") then
			res = marked .. res;
		end

		writefile(path, res);
	end
	return (func or readfile)(path)
end

local function WipeFolder(path)
	if not isfolder(path) then return end

	for _, file in listfiles(path) do
		if file:find("loader") then continue end

		local string = string.gsub(marked, "\n", "")
		
		if isfile(file) and select(1, readfile(file):find(string)) == 1 then
			delfile(file);
		end
	end
end

local function CreateFolders()
	for _, folder in hubFolders do
		if not isfolder(folder) then
			makefolder(folder);
		end
	end
end

-- create neccessary folders if they don't exist
CreateFolders();

-- update BayaForRoblox
local _, subbed = pcall(function()
    return game:HttpGet("https://github.com/fisiaque/BayaForRoblox")
end)
local commit = subbed:find("currentOid");
commit = commit and subbed:sub(commit + 13, commit + 52) or nil;
commit = commit and #commit == 40 and commit or "main";

if commit == "main" or (isfile("Baya/Hub/commit.txt") and readfile("Baya/Hub/commit.txt") or "") ~= commit then
	WipeFolder("Baya/Hub/Games");
    WipeFolder("Baya/Hub");
end

writefile("Baya/Hub/commit.txt", commit);

CreateFolders(); -- recreate any delete folders i.e Games Folder sincce it got wiped

return loadstring(DownloadFile("Baya/Hub/main.lua"), "main")()