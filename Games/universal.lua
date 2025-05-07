local test0 = shared.baya:CreateCategory({
	Name = "Test0",
	Icon = "Baya/UIAssets/ActionIcon.png",
	Size = UDim2.fromOffset(13, 14)
});

test0:CreateButton({Name = 'Hello World',
	Function = function(callback)
		shared.baya:CreateNotification("test0", "Hello World pressed", 2, "Warning")
	end,
	Tooltip = "Notify the WORLD!"
})

test0:CreateToggle({Name = 'Hello Rehad',
	Function = function(callback)
		if callback then
			shared.baya:CreateNotification("test0", "Rehad ON", 2, "Alert")
		else
			shared.baya:CreateNotification("test0", "Rehad OFF", 2, "Alert")
		end
	end,
	Tooltip = "Rehad is cool huh!"
})
