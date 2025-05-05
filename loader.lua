-- variable
local marked = "--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.\n"

-- funcs
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)

	return suc and res ~= nil and res ~= ""
end
local delfile = delfile or function(file)
	writefile(file, "")
end

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

local function WipeFolder(path)
	print(isfolder(path))
	if not isfolder(path) then return end

	for _, file in listfiles(path) do
		if file:find("loader") then continue end
		if isfile(file) and select(1, readfile(file):find("--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.")) == 1 then
			print(file)
			delfile(file)
		end
	end
end

-- create neccessary folders
for _, folder in {"Baya/Hub", "Baya/Hub/Games"} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- update BayaForRoblox
local _, subbed = pcall(function()
    return game:HttpGet("https://github.com/fisiaque/BayaForRoblox")
end)
local commit = subbed:find("currentOid")
commit = commit and subbed:sub(commit + 13, commit + 52) or nil
commit = commit and #commit == 40 and commit or "main"

if commit == "main" or (isfile("Baya/Hub/commit.txt") and readfile("Baya/Hub/commit.txt") or "") ~= commit then
    WipeFolder("Baya/Hub/commit.txt")
	WipeFolder("Baya/Hub/Games")
end

writefile("Baya/Hub/commit.txt", commit)

return loadstring(downloadFile("Baya/Hub/main.lua"), "main")()