local test0 = shared.baya:CreateCategory({
	Name = "Test0",
	Icon = "Baya/UIAssets/ActionIcon.png",
	Size = UDim2.fromOffset(13, 14)
});

test0:CreateButton({Name = 'Hello World',
	Function = function(callback)
		shared.baya:CreateNotification("Button", "Hello World pressed", 2, "Warning")
	end,
	Tooltip = "Notify the WORLD!"
})

test0:CreateToggle({Name = 'Hello Rehad',
	Function = function(callback)
		if callback then
			shared.baya:CreateNotification("Toggle", "Rehad ON", 2, "Alert")
		else
			shared.baya:CreateNotification("Toggle", "Rehad OFF", 2, "Alert")
		end
	end,
	Tooltip = "Rehad is cool huh!"
})

test0:CreateDropdown({
	Name = 'Hello Haque',
	List = {"Rehad", "Ricon", "Rehan", "Risheta"},
	Function = function(value)
		shared.baya:CreateNotification("Dropdown", value, 2, "Alert")
	end,
	Tooltip = "Haque Family!"
})

test0:CreateSlider({
	Name = 'Coolness',
	Min = 1,
	Max = 100,
	Default = math.random(1, 100),
	Function = function(value)
		shared.baya:CreateNotification("Slider", tostring(value), 2, "Alert")
	end,
	Tooltip = "Are you COOL!"
})
