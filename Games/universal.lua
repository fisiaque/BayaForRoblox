local test0 = shared.baya:CreateCategory({
	Name = "Test0",
	Icon = "Baya/Assets/ActionIcon.png",
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

test0:CreateTextBox({
	Name = 'Text Here',
	Placeholder = 'Any Text Boy',
	Function = function(...)
		local text, enterPressed = table.unpack(...)

		shared.baya:CreateNotification("TextBox: " .. tostring(enterPressed), text, 2, "Alert")
	end,
	Tooltip = "What text are you going to write!"
})

ESP = test0:CreateModule({
	Name = 'ESP',
	Function = function(callback)
		print("ESP: " .. tostring(callback))
	end,
	Tooltip = 'Highlights players or entities through walls'
})
Mode = ESP:CreateDropdown({
	Name = 'Mode',
	List = {'Box', 'Chams'},
	Function = function(val)
		print("MODE: " .. tostring(val))
	end,
	Tooltip = 'Box - Draws a box around players\nChams - Highlights players with see-through colors'
})
Opacity = ESP:CreateSlider({
	Name = 'Opacity',
	Min = 0,
	Max = 1,
	Default = 1,
	Decimal = 4,
	Function = function(val)
		print("OPACITY: " .. tostring(val))
	end,
})