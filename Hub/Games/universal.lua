local test0 = shared.library:CreateCategory({
	Name = "Test0",
 	Icon = "Baya/UIAssets/ActionIcon.png",
 	Size = UDim2.fromOffset(13, 14)
});

local hello = test0:CreateModule({
	Name = 'Hello World',
})

hello:CreateButton({Name = 'sh00t',
	Function = function(callback)
		print("BAM BAM BAM")
	end,
	Tooltip = '!!!'
})

hello:CreateButton({Name = 'Auto Boom',
	Function = function(callback)
		print("gg ff gg")
	end,
	Tooltip = "Sdawdsadwadswwwwwwwwwwwwwwwwwwwwwwwwwww"
})
