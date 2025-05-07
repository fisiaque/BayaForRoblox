local test0 = libraryapi:CreateCategory({
	Name = "Test0",
	Icon = "Baya/UIAssets/ActionIcon.png",
	Size = UDim2.fromOffset(13, 14)
});

test0:CreateButton({Name = 'Hello World',
	Function = function(callback)
		shared.library:CreateNotification("test0", "Hello World pressed", 2, "Warning")
	end,
	Tooltip = "Notify the WORLD!"
})

test0:CreateButton({Name = 'Hello Rehad',
	Function = function(callback)
		shared.library:CreateNotification("test0", "Hello Rehad pressed", 2, "Alert")
	end,
	Tooltip = "Rehad is cool huh!"
})
