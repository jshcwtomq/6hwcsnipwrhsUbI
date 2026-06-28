function library:FormatWindows()
	format_windows()
end

function library:AddWindow(title, options)
	windows = windows + 1
	local dropdown_open = false
	title = tostring(title or "New Window")
	options = (typeof(options) == "table") and options or ui_options
	options.tween_time = 0.1

	local Window = Prefabs:FindFirstChild("Window"):Clone()
	Window.Parent = Windows
	Window:FindFirstChild("Title").Text = title
	Window.Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)
	Window.ZIndex = Window.ZIndex + (windows * 10)  
	Window.BackgroundTransparency = ui_options.window_transparency
	Window.ImageTransparency = ui_options.window_transparency

	do -- Altering Window Color
		local Title = Window:FindFirstChild("Title")
		local Bar = Window:FindFirstChild("Bar")
		local Base = Bar:FindFirstChild("Base")
		local Top = Bar:FindFirstChild("Top")
		local SplitFrame = Window:FindFirstChild("TabSelection"):FindFirstChild("Frame")
		local Toggle = Bar:FindFirstChild("Toggle")

		spawn(function()
			while true do
				Bar.BackgroundColor3 = options.main_color
				Base.BackgroundColor3 = options.main_color
				Base.ImageColor3 = options.main_color
				Top.ImageColor3 = options.main_color
				SplitFrame.BackgroundColor3 = options.main_color

				RS.Heartbeat:Wait()
			end
		end)

	end

	do -- Rainbow Border sa Toggle Button
		local Toggle = Window:FindFirstChild("Bar"):FindFirstChild("Toggle")
		local SEGMENT_COUNT = 12
		local BORDER_THICKNESS = 3
		local SPEED = 0.003
		local rainbowContainer = Instance.new("Frame")
		rainbowContainer.Name = "RainbowBorder"
		rainbowContainer.Parent = Toggle
		rainbowContainer.BackgroundTransparency = 1
		rainbowContainer.BorderSizePixel = 0
		rainbowContainer.Size = UDim2.new(1, BORDER_THICKNESS * 2, 1, BORDER_THICKNESS * 2)
		rainbowContainer.Position = UDim2.new(0, -BORDER_THICKNESS, 0, -BORDER_THICKNESS)
		rainbowContainer.ZIndex = Toggle.ZIndex - 1
		rainbowContainer.ClipsDescendants = false
		local segments = {}
		for i = 1, SEGMENT_COUNT do
			local seg = Instance.new("Frame")
			seg.Parent = rainbowContainer
			seg.BorderSizePixel = 0
			seg.Size = UDim2.new(1 / SEGMENT_COUNT, 0, 0, BORDER_THICKNESS)
			seg.Position = UDim2.new((i - 1) / SEGMENT_COUNT, 0, 0, 0)
			seg.ZIndex = Toggle.ZIndex - 1
			table.insert(segments, seg)
		end
		for i = 1, SEGMENT_COUNT do
			local seg = Instance.new("Frame")
			seg.Parent = rainbowContainer
			seg.BorderSizePixel = 0
			seg.Size = UDim2.new(0, BORDER_THICKNESS, 1 / SEGMENT_COUNT, 0)
			seg.Position = UDim2.new(1, -BORDER_THICKNESS, (i - 1) / SEGMENT_COUNT, 0)
			seg.ZIndex = Toggle.ZIndex - 1
			table.insert(segments, seg)
		end
		for i = 1, SEGMENT_COUNT do
			local seg = Instance.new("Frame")
			seg.Parent = rainbowContainer
			seg.BorderSizePixel = 0
			seg.Size = UDim2.new(1 / SEGMENT_COUNT, 0, 0, BORDER_THICKNESS)
			seg.Position = UDim2.new(1 - (i / SEGMENT_COUNT), 0, 1, -BORDER_THICKNESS)
			seg.ZIndex = Toggle.ZIndex - 1
			table.insert(segments, seg)
		end
		for i = 1, SEGMENT_COUNT do
			local seg = Instance.new("Frame")
			seg.Parent = rainbowContainer
			seg.BorderSizePixel = 0
			seg.Size = UDim2.new(0, BORDER_THICKNESS, 1 / SEGMENT_COUNT, 0)
			seg.Position = UDim2.new(0, 0, 1 - (i / SEGMENT_COUNT), 0)
			seg.ZIndex = Toggle.ZIndex - 1
			table.insert(segments, seg)
		end
		local totalSegments = #segments
		local hueOffset = 0
		spawn(function()
			while rainbowContainer and rainbowContainer.Parent do
				hueOffset = (hueOffset + SPEED) % 1
				for i, seg in ipairs(segments) do
					local hue = (hueOffset + (i / totalSegments)) % 1
					seg.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				end
				RS.Heartbeat:Wait()
			end
		end)
	end

	local Resizer = Window:WaitForChild("Resizer")

	local window_data = {}
	Window.Draggable = true

	do -- Resize Window
		local oldIcon = mouse.Icon
		local Entered = false
		Resizer.MouseEnter:Connect(function()
			Window.Draggable = false
			if options.can_resize then
				oldIcon = mouse.Icon
			end
			Entered = true
		end)

		Resizer.MouseLeave:Connect(function()
			Entered = false
			if options.can_resize then
				mouse.Icon = oldIcon
			end
			Window.Draggable = true
		end)

		local Held = false
		UIS.InputBegan:Connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				Held = true

				spawn(function() -- Loop check
					if Entered and Resizer.Active and options.can_resize then
						while Held and Resizer.Active do

							local mouse_location = gMouse()
							local x = mouse_location.X - Window.AbsolutePosition.X
							local y = mouse_location.Y - Window.AbsolutePosition.Y

							if x >= options.min_size.X and y >= options.min_size.Y then
								Resize(Window, {Size = UDim2.new(0, x, 0, y)}, options.tween_time)
							elseif x >= options.min_size.X then
								Resize(Window, {Size = UDim2.new(0, x, 0, options.min_size.Y)}, options.tween_time)
							elseif y >= options.min_size.Y then
								Resize(Window, {Size = UDim2.new(0, options.min_size.X, 0, y)}, options.tween_time)
							else
								Resize(Window, {Size = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)}, options.tween_time)
							end

							RS.Heartbeat:Wait()
						end
					end
				end)
			end
		end)
		UIS.InputEnded:Connect(function(inputObject)
			if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
				Held = false
			end
		end)
	end

	do -- [Open / Close] Window
		local open_close = Window:FindFirstChild("Bar"):FindFirstChild("Toggle")
		local open = true
		local canopen = true

		local oldwindowdata = {}
		local oldy = Window.AbsoluteSize.Y
		open_close.MouseButton1Click:Connect(function()
			if canopen then
				canopen = false

				if open then
					-- Close

					oldwindowdata = {}
					for i,v in next, Window:FindFirstChild("Tabs"):GetChildren() do
						oldwindowdata[v] = v.Visible
						v.Visible = false
					end

					Resizer.Active = false

					oldy = Window.AbsoluteSize.Y
					Resize(open_close, {Rotation = 0}, options.tween_time)
					Resize(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, 26)}, options.tween_time)
					open_close.Parent:FindFirstChild("Base").Transparency = 1

				else
					-- Open

					for i,v in next, oldwindowdata do
						i.Visible = v
					end

					Resizer.Active = true

					Resize(open_close, {Rotation = 90}, options.tween_time)
					Resize(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, oldy)}, options.tween_time)
					open_close.Parent:FindFirstChild("Base").Transparency = 0

				end

				open = not open
				wait(options.tween_time)
				canopen = true

			end
		end)
	end
