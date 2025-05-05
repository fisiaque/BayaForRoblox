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
			return game:HttpGet("https://raw.githubusercontent.com/fisiaque/BayaForRoblox/"..readfile("Baya/commit.txt").."/"..select(1, path:gsub("Baya/", "")), true)
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

	for _, file in listfiles(path) do
		if file:find("loader") then continue end
		if isfile(file) and select(1, readfile(file):find("--MARKED: DELETE IF CACHED INCASE BAYA UPDATES.")) == 1 then
			delfile(file)
		end
	end
end

-- create neccessary folders
for _, folder in {'Baya/Games'} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

-- update BayaForRoblox
local _, subbed = pcall(function()
    return game:HttpGet('https://github.com/fisiaque/BayaForRoblox')
end)
local commit = subbed:find('currentOid')
commit = commit and subbed:sub(commit + 13, commit + 52) or nil
commit = commit and #commit == 40 and commit or 'main'

if commit == 'main' or (isfile('Baya/commit2.txt') and readfile('Baya/commit2.txt') or '') ~= commit then
    wipeFolder('Baya/commit2.txt') -- hub commit
    wipeFolder('Baya/Games')
end

writefile('Baya/commit2.txt', commit) -- write commit for hub (1=library, 2=hub)

return loadstring(downloadFile('Baya/main.lua'), 'main')()