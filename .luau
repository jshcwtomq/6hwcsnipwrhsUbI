-- COMPLETE ROBLOX UI LIBRARY - FULL VERSION WITH IMPROVEMENTS
-- Features: Better tab effects, icon support, smooth transitions, all original functions

a = {
	Theme = {
        ['lunahubontop'] = {
	['Background'] = Color3.fromRGB(18, 10, 25),
	['Background Transparency'] = 0.05,
	['Color Main'] = Color3.fromRGB(200, 100, 255),
	['Color Tab'] = {
		[1] = Color3.fromRGB(180, 80, 255),
		[2] = Color3.fromRGB(220, 120, 255)
	},
	['Top Bar'] = Color3.fromRGB(25, 15, 35),
	['Text Color'] = Color3.fromRGB(255, 240, 255),
	['Text Tab Select'] = Color3.fromRGB(255, 255, 255),
	['Tab Bar'] = Color3.fromRGB(20, 12, 28),
	['Background Page'] = Color3.fromRGB(22, 12, 30),
	['Line Page'] = Color3.fromRGB(200, 100, 255),
	['Top Bar Page'] = Color3.fromRGB(28, 18, 38),
	['Search'] = Color3.fromRGB(40, 25, 55),
	['Background Function'] = Color3.fromRGB(100, 50, 150),
	['Background Function Transparency'] = 0.8,
	['Background Function Transparency Moved'] = 0.6,
	['Dropdown Color'] = Color3.fromRGB(45, 28, 60),
	['Dropdown Select Background'] = Color3.fromRGB(30, 18, 42),
	['Dropdown Select Stroke'] = Color3.fromRGB(150, 80, 200),
	['Dropdown Item'] = Color3.fromRGB(80, 45, 120),
	['Textbox Color'] = Color3.fromRGB(45, 28, 60),
	['Slider Color'] = Color3.fromRGB(45, 28, 60),
	['Toggle Color'] = Color3.fromRGB(25, 15, 35),
	['Diglog Top Bar'] = Color3.fromRGB(28, 18, 38),
	['Diglog Background'] = Color3.fromRGB(20, 12, 28)
		}, 
		['Quizzy'] = {
			['Background'] = Color3.fromRGB(16, 16, 16),
			['Background Transparency'] = 0.1,
			['Color Main'] = Color3.fromRGB(249, 43, 134),
			['Color Tab'] = {
				[1] = Color3.fromRGB(213, 63, 128),
				[2] = Color3.fromRGB(209, 102, 198)
			},
			['Top Bar'] = Color3.fromRGB(21, 21, 21),
			['Text Color'] = Color3.fromRGB(255, 255, 255),
			['Text Tab Select'] = Color3.fromRGB(0, 0, 0),
			['Tab Bar'] = Color3.fromRGB(16, 16, 16),
			['Background Page'] = Color3.fromRGB(24, 24, 24),
			['Line Page'] = Color3.fromRGB(132, 132, 132),
			['Top Bar Page'] = Color3.fromRGB(21, 21, 21),
			['Search'] = Color3.fromRGB(47, 47, 47),
			['Background Function'] = Color3.fromRGB(88, 88, 88),
			['Background Function Transparency'] = 0.9,
			['Background Function Transparency Moved'] = 0.8,
			['Dropdown Color'] = Color3.fromRGB(47, 47, 47),
			['Dropdown Select Background'] = Color3.fromRGB(24, 24, 24),
			['Dropdown Select Stroke'] = Color3.fromRGB(43, 43, 43),
			['Dropdown Item'] = Color3.fromRGB(88, 88, 88),
			['Textbox Color'] = Color3.fromRGB(47, 47, 47),
			['Slider Color'] = Color3.fromRGB(47, 47, 47),
			['Toggle Color'] = Color3.fromRGB(16, 16, 16),
			['Diglog Top Bar'] = Color3.fromRGB(22, 22, 22),
			['Diglog Background'] = Color3.fromRGB(17, 17, 17)
		},
		['Dark'] = {
			['Background'] = Color3.fromRGB(16, 16, 16),
			['Background Transparency'] = 0.1,
			['Color Main'] = Color3.fromRGB(17, 110, 249),
			['Color Tab'] = {
				[1] = Color3.fromRGB(2, 69, 213),
				[2] = Color3.fromRGB(7, 155, 209)
			},
			['Top Bar'] = Color3.fromRGB(21, 21, 21),
			['Text Color'] = Color3.fromRGB(255, 255, 255),
			['Text Tab Select'] = Color3.fromRGB(0, 0, 0),
			['Tab Bar'] = Color3.fromRGB(16, 16, 16),
			['Background Page'] = Color3.fromRGB(24, 24, 24),
			['Line Page'] = Color3.fromRGB(132, 132, 132),
			['Top Bar Page'] = Color3.fromRGB(21, 21, 21),
			['Search'] = Color3.fromRGB(47, 47, 47),
			['Background Function'] = Color3.fromRGB(88, 88, 88),
			['Background Function Transparency'] = 0.9,
			['Background Function Transparency Moved'] = 0.8,
			['Dropdown Color'] = Color3.fromRGB(47, 47, 47),
			['Dropdown Select Background'] = Color3.fromRGB(24, 24, 24),
			['Dropdown Select Stroke'] = Color3.fromRGB(43, 43, 43),
			['Dropdown Item'] = Color3.fromRGB(88, 88, 88),
			['Textbox Color'] = Color3.fromRGB(47, 47, 47),
			['Slider Color'] = Color3.fromRGB(47, 47, 47),
			['Toggle Color'] = Color3.fromRGB(16, 16, 16),
			['Diglog Top Bar'] = Color3.fromRGB(22, 22, 22),
			['Diglog Background'] = Color3.fromRGB(17, 17, 17)
		},
		['Darkness'] = {
			['Background'] = Color3.fromRGB(16, 16, 16),
			['Background Transparency'] = 0.1,
			['Color Main'] = Color3.fromRGB(0, 0, 0),
			['Color Tab'] = {
				[1] = Color3.fromRGB(57, 57, 57),
				[2] = Color3.fromRGB(57, 57, 57)
			},
			['Top Bar'] = Color3.fromRGB(21, 21, 21),
			['Text Color'] = Color3.fromRGB(255, 255, 255),
			['Text Tab Select'] = Color3.fromRGB(0, 0, 0),
			['Tab Bar'] = Color3.fromRGB(16, 16, 16),
			['Background Page'] = Color3.fromRGB(24, 24, 24),
			['Line Page'] = Color3.fromRGB(132, 132, 132),
			['Top Bar Page'] = Color3.fromRGB(21, 21, 21),
			['Search'] = Color3.fromRGB(47, 47, 47),
			['Background Function'] = Color3.fromRGB(88, 88, 88),
			['Background Function Transparency'] = 0.9,
			['Background Function Transparency Moved'] = 0.8,
			['Dropdown Color'] = Color3.fromRGB(47, 47, 47),
			['Dropdown Select Background'] = Color3.fromRGB(24, 24, 24),
			['Dropdown Select Stroke'] = Color3.fromRGB(43, 43, 43),
			['Dropdown Item'] = Color3.fromRGB(88, 88, 88),
			['Textbox Color'] = Color3.fromRGB(47, 47, 47),
			['Slider Color'] = Color3.fromRGB(47, 47, 47),
			['Toggle Color'] = Color3.fromRGB(16, 16, 16),
			['Diglog Top Bar'] = Color3.fromRGB(22, 22, 22),
			['Diglog Background'] = Color3.fromRGB(17, 17, 17)
		},
		['Light'] = {
			['Background'] = Color3.fromRGB(241, 241, 241),
			['Background Transparency'] = 0.1,
			['Color Main'] = Color3.fromRGB(17, 110, 249),
			['Color Tab'] = {
				[1] = Color3.fromRGB(2, 69, 213),
				[2] = Color3.fromRGB(7, 155, 209)
			},
			['Top Bar'] = Color3.fromRGB(209, 209, 209),
			['Text Color'] = Color3.fromRGB(0, 0, 0),
			['Text Tab Select'] = Color3.fromRGB(255, 255, 255),
			['Tab Bar'] = Color3.fromRGB(152, 152, 152),
			['Background Page'] = Color3.fromRGB(176, 176, 176),
			['Line Page'] = Color3.fromRGB(54, 54, 54),
			['Top Bar Page'] = Color3.fromRGB(150, 150, 150),
			['Search'] = Color3.fromRGB(127, 127, 127),
			['Background Function'] = Color3.fromRGB(102, 102, 102),
			['Background Function Transparency'] = 0.6,
			['Background Function Transparency Moved'] = 0.4,
			['Dropdown Color'] = Color3.fromRGB(113, 113, 113),
			['Dropdown Select Background'] = Color3.fromRGB(90, 90, 90),
			['Dropdown Select Stroke'] = Color3.fromRGB(76, 76, 76),
			['Dropdown Item'] = Color3.fromRGB(116, 116, 116),
			['Textbox Color'] = Color3.fromRGB(113, 113, 113),
			['Slider Color'] = Color3.fromRGB(113, 113, 113),
			['Toggle Color'] = Color3.fromRGB(52, 52, 52),
			['Diglog Top Bar'] = Color3.fromRGB(209, 209, 209),
			['Diglog Background'] = Color3.fromRGB(241, 241, 241)
		}
	},
}

b = {
	[1] = function()
		local x = {}
		function x.n(a, b, c, d)
			local e = Instance.new(a)
			if b then
				for f, g in pairs(b) do
					e[f] = g
				end
			end
			if c then
				for f, g in pairs(c) do
					g.Parent = e
				end
			end
			if d then
				d(e)
			end
			return e
		end
		function x.gl(i)
			if type(i) == 'string' and not i:find('rbxassetid://') then
				return "rbxassetid://".. i
			elseif type(i) == 'number' then
				return "rbxassetid://".. i
			else
				return i
			end
		end
		function x.tw(info)
			return game:GetService"TweenService":Create(info.v,TweenInfo.new(info.t,Enum.EasingStyle[info.s],Enum.EasingDirection[info.d]),info.g)
		end
		function x.lak(o)
			local a, b, c, d
			local function u(i)
				local dt = i.Position - c
				game:GetService"TweenService":Create(o, TweenInfo.new(0.3), {Position = UDim2.new(d.X.Scale, d.X.Offset + dt.X, d.Y.Scale, d.Y.Offset + dt.Y)}):Play()
			end
			o.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then a = true c = i.Position d = o.Position; i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then a = false end end) end end)
			o.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then b = i end end)
			game:GetService"UserInputService".InputChanged:Connect(function(i) if i == b and a then u(i) end end)
		end
		function x.dialog(p, t, d, call, theme)
			local f, cancel, confirm, tw = b[1]().n, nil, nil, game:GetService "TweenService"
			assert(t, "Dialog - Missing Title")
			if p:FindFirstChild("Dialog") then
				return
			end
			local hf = f("Frame", {
				Parent = p,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Size = UDim2.new(1, 0, 1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Name = "Dialog"
			}, {
				f("CanvasGroup", {
					BorderSizePixel = 0,
					BackgroundColor3 = a.Theme[theme.Theme or 'Quizzy']['Diglog Background'],
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0, 300, 0, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					GroupTransparency = 1
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 11)}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = a.Theme[theme.Theme or 'Quizzy']['Diglog Top Bar'],
						Size = UDim2.new(1, 0, 0, 50),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
					}, {
						f("TextLabel", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 20,
							FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
							TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
							BackgroundTransparency = 1,
							RichText = true,
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0, 200, 0, 50),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Text = t,
							Position = UDim2.new(0.5, 0, 0.5, 0)
						})
					}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						AnchorPoint = Vector2.new(0.5, 1),
						Size = UDim2.new(0, 120, 0, 50),
						Position = UDim2.new(0.5, 0, 1, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1
					}, {
						f("UIPadding",{PaddingBottom = UDim.new(0, 15)}),
						f("UIListLayout", {
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							Padding = UDim.new(0, 5),
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							FillDirection = Enum.FillDirection.Horizontal
						}),
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(9, 255, 58),
							Size = UDim2.new(0, 120, 0, 40),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1
						}, {
							f("UIStroke", {Color = Color3.fromRGB(9, 255, 58), Thickness = 0.6}, {
								f("UIGradient", {Rotation = 90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(19, 180, 0))}}),
							}),
							f("UICorner", {CornerRadius = UDim.new(0, 11)}),
							f("UIGradient", {Rotation = 90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(19, 180, 0))}}),
							f("TextLabel", {
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 18,
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
								TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 1, 0),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								Text = 'Confirm',
								TextTransparency = 0.5
							}),
							f("TextButton", {
								BorderSizePixel = 0,
								TextSize = 14,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
								Size = UDim2.new(1, 0, 1, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								Text = ""
							})
						}, function(a)
							confirm = a
						end),
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 52, 0),
							Size = UDim2.new(0, 120, 0, 40),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1
						}, {
							f("UIStroke", {Color = Color3.fromRGB(255, 52, 0), Thickness = 0.6}, {
								f("UIGradient", {Rotation = 90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(180, 0, 0))}}),
							}),
							f("UICorner", {CornerRadius = UDim.new(0, 11)}),
							f("UIGradient", {Rotation = 90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(180, 0, 0))}}),
							f("TextLabel", {
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 18,
								FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
								TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 1, 0),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								Text = 'Cancel',
								TextTransparency = 0.5
							}),
							f("TextButton", {
								BorderSizePixel = 0,
								TextSize = 14,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
								Size = UDim2.new(1, 0, 1, 0),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								Text = ""
							})
						}, function(a)
							cancel = a
						end)
					}),
				})
			})

			if d ~= nil then
				local gfdgd = f("TextLabel", {
					Parent = hf.CanvasGroup,
					TextWrapped = true,
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextTransparency = 0.5,
					TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 10,
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
					BackgroundTransparency = 1,
					RichText = true,
					Size = UDim2.new(0, 245, 0, 68),
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = d,
					Position = UDim2.new(0.09167, 0, 0, 0),
					Name = "Desc"
				}, {
					f("UIPadding",{PaddingTop = UDim.new(0, 63)}),
				})
				if gfdgd.TextBounds then
					hf.CanvasGroup.Size = UDim2.new(0, 300, 0, gfdgd.TextBounds.Y + 130)
				end
			else
				hf.CanvasGroup.Size = UDim2.new(0, 300, 0, 120)
			end

			local isDestroyed = false

			local function c()
				isDestroyed = true
				b[1]().tw({
					v = hf,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {BackgroundTransparency = 1}
				}):Play()
				local gf = b[1]().tw({
					v = hf.CanvasGroup,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {GroupTransparency = 1}
				})
				gf:Play()
				gf.Completed:Wait()
				hf:Destroy()
			end

			local function ml(g)
				g.MouseMoved:Connect(function()
					b[1]().tw({
						v = g,
						t = 0.1,
						s = "Back",
						d = "Out",
						g = {Size = UDim2.new(0, 125, 0, 45)}
					}):Play()
					b[1]().tw({
						v = g.TextLabel,
						t = 0.1,
						s = "Back",
						d = "Out",
						g = {TextTransparency = 0}
					}):Play()
				end)
				g.MouseLeave:Connect(function()
					b[1]().tw({
						v = g,
						t = 0.1,
						s = "Back",
						d = "Out",
						g = {Size = UDim2.new(0, 120, 0, 40)}
					}):Play()
					b[1]().tw({
						v = g.TextLabel,
						t = 0.1,
						s = "Back",
						d = "Out",
						g = {TextTransparency = 0.5}
					}):Play()
				end)
			end

			ml(confirm)
			ml(cancel)

			b[1]().tw({v = hf, t = 0.2, s = "Linear", d = "Out", g = {BackgroundTransparency = 0.4}}):Play()
			b[1]().tw({v = hf.CanvasGroup, t = 0.2, s = "Linear", d = "Out", g = {GroupTransparency = 0}}):Play()

			game:GetService "UserInputService".InputBegan:Connect(function(A)
				if not isDestroyed and A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
					local B, C = hf.CanvasGroup.AbsolutePosition, hf.CanvasGroup.AbsoluteSize
					if game:GetService "Players".LocalPlayer:GetMouse().X < B.X or game:GetService "Players".LocalPlayer:GetMouse().X > B.X + C.X or game:GetService "Players".LocalPlayer:GetMouse().Y < (B.Y - 20 - 1) or game:GetService "Players".LocalPlayer:GetMouse().Y > B.Y + C.Y then
						c()
					end
				end
			end)

			confirm.TextButton.MouseButton1Click:Connect(function()
				tw:Create(confirm.TextLabel, TweenInfo.new(0.06, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true, 0), {Position = UDim2.new(0, 0, 0.1, 0)}):Play()
				b[1]().tw({v = confirm, t = 0.1, s = "Back", d = "Out", g = {Size = UDim2.new(0, 115, 0, 30)}}):Play()
				c()
				call()
			end)

			cancel.TextButton.MouseButton1Click:Connect(function()
				tw:Create(cancel.TextLabel, TweenInfo.new(0.06, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true, 0), {Position = UDim2.new(0, 0, 0.1, 0)}):Play()
				b[1]().tw({v = cancel, t = 0.1, s = "Back", d = "Out", g = {Size = UDim2.new(0, 115, 0, 30)}}):Play()
				c()
			end)
		end
		function x.desc(p, t, theme)
			return b[1]().n("TextLabel", {
				Parent = p,
				TextWrapped = true,
				BorderSizePixel = 0,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTransparency = 0.5,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 9,
				Font = Enum.Font.Gotham,
				TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
				BackgroundTransparency = 1,
				RichText = true,
				Size = UDim2.new(1, 0, 0, math.floor(16)),
				AutomaticSize = Enum.AutomaticSize.Y,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Text = t,
				LayoutOrder = 1,
				Name = "Desc",
			})
		end
		function x.background(parent, text, desc, ghfd, theme)
			local f = b[1]().n

			local hg = f("Frame", {
				Parent = parent,
				BorderSizePixel = 0,
				BackgroundColor3 = a.Theme[theme.Theme or 'Quizzy']['Background Function'],
				Size = UDim2.new(1, 0, 0, 40),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = a.Theme[theme.Theme or 'Quizzy']['Background Function Transparency'],
				ClipsDescendants = true
			}, {
				f("UICorner", {CornerRadius = UDim.new(0, 4)}),
				f("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1,
					Name = "TextDesc"
				}, {
					f("UIPadding", {PaddingLeft = UDim.new(0, 13), PaddingRight = UDim.new(0, 90)}),
					f("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("TextLabel", {
						TextWrapped = true,
						BorderSizePixel = 0,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextTransparency = 0.4,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12,
						Font = Enum.Font.Gotham,
						TextColor3 = a.Theme[theme.Theme or 'Quizzy']['Text Color'],
						BackgroundTransparency = 1,
						RichText = true,
						Size = UDim2.new(1, 0, 0, math.floor(16)),
						AutomaticSize = Enum.AutomaticSize.Y,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = text,
					})
				}),
			})

			if desc and desc ~= "" then
				b[1]().desc(hg.TextDesc, desc, theme)
			end

			if not ghfd then
				hg.MouseMoved:Connect(function()
					b[1]().tw({
						v = hg,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = a.Theme[theme.Theme or 'Quizzy']['Background Function Transparency Moved']}
					}):Play()
				end)
				hg.MouseLeave:Connect(function()
					b[1]().tw({
						v = hg,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = a.Theme[theme.Theme or 'Quizzy']['Background Function Transparency']}
					}):Play()
				end)
			end

			hg.TextDesc.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				hg.TextDesc.Size = UDim2.new(1, 0, 0, hg.TextDesc.UIListLayout.AbsoluteContentSize.Y + 15)
				hg.Size = UDim2.new(1, 0, 0, hg.TextDesc.UIListLayout.AbsoluteContentSize.Y + 15)
			end)

			return hg
		end
		function x.click(i)
			return b[1]().n("TextButton", {
				Name = "Click",
				Parent = i,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255,255,255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0,0,0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0,1, 0),
				Font = Enum.Font.SourceSans,
				Text = "",
				TextSize = 14,
				ZIndex = 2
			})
		end
		function x.jc(c, p)
			local Mouse = game.Players.LocalPlayer:GetMouse()

			local relativeX = Mouse.X - c.AbsolutePosition.X
			local relativeY = Mouse.Y - c.AbsolutePosition.Y

			if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
				return
			end

			local ClickButtonCircle = b[1]().n("ImageLabel", {
				Parent = p,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0, relativeX, 0, relativeY),
				Size = UDim2.new(0, 0, 0, 0),
				Image = "rbxassetid://136860536582612",
				ImageTransparency = 0.7,
				ImageColor3 = Color3.fromRGB(126, 126, 126),
				ZIndex = 10
			})

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = ClickButtonCircle

			local expandTween = game:GetService("TweenService"):Create(ClickButtonCircle, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
				ImageTransparency = 1
			})

			expandTween.Completed:Connect(function()
				ClickButtonCircle:Destroy()
			end)

			expandTween:Play()
		end
		function x.init(gf)
			local binds = {}
			local root = b[1]().n('Folder', {Parent = workspace.CurrentCamera})

			local DepthOfField = b[1]().n('DepthOfFieldEffect', {
				Parent = game:GetService('Lighting'),
				FarIntensity = 0,
				FocusDistance = 51.6,
				InFocusRadius = 50,
				NearIntensity = 1,
			})

			local frame = b[1]().n('Frame', {
				Parent = gf,
				Size = UDim2.new(0.95, 0, 0.95, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1
			})

			local GenUid; do
				local id = 0
				function GenUid()
					id = id + 1
					return 'neon::'..tostring(id)
				end
			end

			do
				local function IsNotNaN(x)
					return x == x
				end
				local continue = IsNotNaN(workspace.CurrentCamera:ScreenPointToRay(0,0).Origin.x)
				while not continue do
					game:GetService('RunService').RenderStepped:wait()
					continue = IsNotNaN(workspace.CurrentCamera:ScreenPointToRay(0,0).Origin.x)
				end
			end

			local DrawQuad; do
				local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
				local sz = 0.2

				local function DrawTriangle(v1, v2, v3, p0, p1)
					local s1 = (v1 - v2).magnitude
					local s2 = (v2 - v3).magnitude
					local s3 = (v3 - v1).magnitude
					local smax = max(s1, s2, s3)
					local A, B, C
					if s1 == smax then
						A, B, C = v1, v2, v3
					elseif s2 == smax then
						A, B, C = v2, v3, v1
					elseif s3 == smax then
						A, B, C = v3, v1, v2
					end

					local para = ( (B-A).x*(C-A).x + (B-A).y*(C-A).y + (B-A).z*(C-A).z ) / (A-B).magnitude
					local perp = sqrt((C-A).magnitude^2 - para*para)
					local dif_para = (A - B).magnitude - para

					local st = CFrame.new(B, A)
					local za = CFrame.Angles(pi/2,0,0)

					local cf0 = st

					local Top_Look = (cf0 * za).lookVector
					local Mid_Point = A + CFrame.new(A, B).lookVector * para
					local Needed_Look = CFrame.new(Mid_Point, C).lookVector
					local dot = Top_Look.x*Needed_Look.x + Top_Look.y*Needed_Look.y + Top_Look.z*Needed_Look.z

					local ac = CFrame.Angles(0, 0, acos(dot))

					cf0 = cf0 * ac
					if ((cf0 * za).lookVector - Needed_Look).magnitude > 0.01 then
						cf0 = cf0 * CFrame.Angles(0, 0, -2*acos(dot))
					end
					cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))

					local cf1 = st * ac * CFrame.Angles(0, pi, 0)
					if ((cf1 * za).lookVector - Needed_Look).magnitude > 0.01 then
						cf1 = cf1 * CFrame.Angles(0, 0, 2*acos(dot))
					end
					cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)

					if not p0 then
						p0 = b[1]().n('Part', {
							FormFactor = 'Custom',
							TopSurface = 0,
							BottomSurface = 0,
							Anchored = true,
							CanCollide = false,
							CastShadow = false,
							Material = "Glass",
							Size = Vector3.new(sz, sz, sz)
						})
						local mesh = b[1]().n('SpecialMesh', {
							Parent = p0,
							MeshType = 2,
							Name = "WedgeMesh"
						})
					end
					p0.WedgeMesh.Scale = Vector3.new(0, perp/sz, para/sz)
					p0.CFrame = cf0

					if not p1 then
						p1 = p0:clone()
					end
					p1.WedgeMesh.Scale = Vector3.new(0, perp/sz, dif_para/sz)
					p1.CFrame = cf1

					return p0, p1
				end

				function DrawQuad(v1, v2, v3, v4, parts)
					parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
					parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
				end
			end

			if binds[frame] then
				return binds[frame].parts
			end

			local uid = GenUid()
			local parts = {}
			local f = b[1]().n('Folder', {Parent = root, Name = frame.Name})

			local parents = {}
			do
				local function add(child)
					if child:IsA'GuiObject' then
						parents[#parents + 1] = child
						add(child.Parent)
					end
				end
				add(frame)
			end

			local function UpdateOrientation(fetchProps)
				local properties = {
					Transparency = 0.98;
					BrickColor = BrickColor.new('Institutional white');
				}
				local zIndex = 1 - 0.05 * frame.ZIndex

				local tl, br = frame.AbsolutePosition, frame.AbsolutePosition + frame.AbsoluteSize
				local tr, bl = Vector2.new(br.x, tl.y), Vector2.new(tl.x, br.y)
				do
					local rot = 0;
					for _, v in ipairs(parents) do
						rot = rot + v.Rotation
					end
					if rot ~= 0 and rot % 180 ~= 0 then
						local mid = tl:lerp(br, 0.5)
						local s, c = math.sin(math.rad(rot)), math.cos(math.rad(rot))
						local vec = tl
						tl = Vector2.new(c * (tl.x - mid.x) - s * (tl.y - mid.y), s * (tl.x - mid.x) + c * (tl.y - mid.y)) + mid
						tr = Vector2.new(c * (tr.x - mid.x) - s * (tr.y - mid.y), s * (tr.x - mid.x) + c * (tr.y - mid.y)) + mid
						bl = Vector2.new(c * (bl.x - mid.x) - s * (bl.y - mid.y), s * (bl.x - mid.x) + c * (bl.y - mid.y)) + mid
						br = Vector2.new(c * (br.x - mid.x) - s * (br.y - mid.y), s * (br.x - mid.x) + c * (br.y - mid.y)) + mid
					end
				end
				DrawQuad(
					workspace.CurrentCamera:ScreenPointToRay(tl.x, tl.y, zIndex).Origin, 
					workspace.CurrentCamera:ScreenPointToRay(tr.x, tr.y, zIndex).Origin, 
					workspace.CurrentCamera:ScreenPointToRay(bl.x, bl.y, zIndex).Origin, 
					workspace.CurrentCamera:ScreenPointToRay(br.x, br.y, zIndex).Origin, 
					parts
				)
				if fetchProps then
					for _, pt in pairs(parts) do
						pt.Parent = f
					end
					for propName, propValue in pairs(properties) do
						for _, pt in pairs(parts) do
							pt[propName] = propValue
						end
					end
				end
			end

			UpdateOrientation(true)
			game:GetService('RunService'):BindToRenderStep(uid, 2000, UpdateOrientation)
			return {
				DepthOfField,
				frame,
			}
		end
		return x
	end,
	[2] = function()
		local f = b[1]().n
		return f('ScreenGui', {Parent = not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
	end,
	[3] = function()
		local ConfigSystem = {}
		ConfigSystem.Elements = {}
		ConfigSystem.ConfigName = "DefaultConfig"
		
		function ConfigSystem:Register(key, getValue, setValue)
			self.Elements[key] = {
				GetValue = getValue,
				SetValue = setValue
			}
		end
		
		function ConfigSystem:SaveConfig()
			local HttpService = game:GetService("HttpService")
			local config = {}
			
			for key, data in pairs(self.Elements) do
				config[key] = data.GetValue()
			end
			
			local json = HttpService:JSONEncode(config)
			
			if writefile then
				writefile(self.ConfigName .. ".json", json)
				return true
			end
			return false
		end
		
		function ConfigSystem:LoadConfig()
			local HttpService = game:GetService("HttpService")
			
			if readfile and isfile and isfile(self.ConfigName .. ".json") then
				local json = readfile(self.ConfigName .. ".json")
				local config = HttpService:JSONDecode(json)
				
				for key, value in pairs(config) do
					if self.Elements[key] then
						self.Elements[key].SetValue(value)
					end
				end
				return true
			end
			return false
		end
		
		return ConfigSystem
	end, 
	
	CreateWindow = function(self, op)
		local f, g, CloseUI, patab, of, scl, KeyCloseUI, isopen = self[1]().n, {}, nil, nil, false ,nil, op.Keybind or Enum.KeyCode.LeftControl, false
		assert(op.Title, "Window - Missing Title")
		assert(op.Icon, "Window - Missing Icon")
		local fo = f("CanvasGroup", {
			Parent = b[2](),
			BorderSizePixel = 0,
			BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Background'],
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(0, 510, 0, 300),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			GroupTransparency = a.Theme[op.Theme or 'Quizzy']['Background Transparency'],
		}, {
			f("UICorner", {CornerRadius = UDim.new(0, 11)}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Top Bar'],
				Size = UDim2.new(1, 0, 0, 50),
				BorderColor3 = Color3.fromRGB(0, 0, 0)
			}, {
				f("UIPadding",{
					PaddingTop = UDim.new(0, 7),
					PaddingLeft = UDim.new(0, 16)
				}),
				f("Frame", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(0, 200, 0, 35),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1
				}, {
					f("UIPadding", {PaddingLeft = UDim.new(0, 50)}),
					f("UIListLayout", {
						Padding = UDim.new(0, -2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("TextLabel", {
						BorderSizePixel = 0,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 11,
						FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
						TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 16),
						AutomaticSize = Enum.AutomaticSize.Y,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = string.upper(op.Title),
						LayoutOrder = 1
					}),
					f("TextLabel", {
						BorderSizePixel = 0,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 9,
						FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
						TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
						BackgroundTransparency = 1,
						TextTransparency = 0.6,
						Size = UDim2.new(1, 0, 0, 10),
						AutomaticSize = Enum.AutomaticSize.Y,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = op.Subtitle or "",
						LayoutOrder = 2
					})
				}),
				f("ImageLabel", {
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 0,
					Image = b[1]().gl(op.Icon),
					Size = UDim2.new(0, 35, 0, 35),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1
				}),
			}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Tab Bar'],
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.new(0, 0, 0, 50),
				Size = UDim2.new(0, 130, 1, -50),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
			}, {
				f("ScrollingFrame", {
					Active = true,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 2, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ScrollBarImageColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 2,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					BackgroundTransparency = 1
				}, {
					f("UIPadding", {
						PaddingTop = UDim.new(0, 10),
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8)
					}),
					f("CanvasGroup", {
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(16, 16, 16),
						AnchorPoint = Vector2.new(0, 0),
						Size = UDim2.new(1, 0, 0, 0),
						AutomaticSize = Enum.AutomaticSize.Y,
						Position = UDim2.new(0, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1
					}, {
						f("UIListLayout", {
							Padding = UDim.new(0, 8),
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							FillDirection = Enum.FillDirection.Vertical
						})
					}, function(a)
						patab = a
					end)
				}, function(a)
					scl = a
				end)
			}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0, 50),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
			}, {
				f("ImageLabel", {
					Active =  false,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					ImageColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
					Selectable = false,
					Image = "rbxassetid://105506802034513",
					Size = UDim2.new(0, 20, 0, 20),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ImageTransparency = 1
				}, {
					f("ImageButton", {
						Active = true,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255,255,255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0,0.5, 0),
						Size = UDim2.new(0.91, 0,0.91, 0),
						Image = "rbxassetid://15196662130",
						ImageColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main']
					}),
					f("UIGradient", {
						Rotation = 90,
						Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)}
					})
				}, function(a)
					CloseUI = a
				end),
				f("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal
				}),
				f("UIPadding", {PaddingRight = UDim.new(0, 16)})
			}),
			f("TextButton", {
				AnchorPoint = Vector2.new(1,1),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0, 20, 0 ,20),
				Text = "",
				ZIndex = 2
			})
		})

		local isfoui = b[1]().init(fo)

		local isResizing = false
		local hasAdjustedAnchor = false

		fo.TextButton.MouseButton1Down:Connect(function()
			isResizing = true
		end)

		if not hasAdjustedAnchor then
			local absolutePosition, parentAbsoluteSize = fo.AbsolutePosition, fo.Parent.AbsoluteSize
			local newPosition = UDim2.new((absolutePosition.X / parentAbsoluteSize.X), fo.Position.X.Offset, (absolutePosition.Y / parentAbsoluteSize.Y), fo.Position.Y.Offset)
			fo.AnchorPoint = Vector2.new(0, 0)
			fo.Position = newPosition
			hasAdjustedAnchor = true
		end

		game:GetService"UserInputService".InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				isResizing = false
			end
		end)

		game:GetService"UserInputService".InputChanged:Connect(function(input)
			if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
				local newWidth = math.max(360, input.Position.X - fo.AbsolutePosition.X)
				local newHeight = math.max(200, input.Position.Y - fo.AbsolutePosition.Y)
				local newSize = UDim2.new(0, newWidth, 0, newHeight)
				game:GetService("TweenService"):Create(fo, TweenInfo.new(0.15), {Size = newSize}):Play()
			end
		end)

		CloseUI.MouseMoved:Connect(function()
			b[1]().tw({
				v = CloseUI,
				t = 0.2,
				s = "Linear",
				d = "Out",
				g = {ImageTransparency = 0.5}
			}):Play()
		end)

		CloseUI.MouseLeave:Connect(function()
			b[1]().tw({
				v = CloseUI,
				t = 0.2,
				s = "Linear",
				d = "Out",
				g = {ImageTransparency = 1}
			}):Play()
		end)

		CloseUI.ImageButton.MouseButton1Click:Connect(function()
			b[1]().dialog(fo ,
				'Do you want to <font color="#ff0000"><b>close?</b></font>',
				'You just press <font color="#3eff00">confirm</font> and this ui will close immediately. and <font color="#ff3200">cannot be opened again</font> until you execute it again',
				function()
					local gf = b[1]().tw({
						v = fo,
						t = 0.2,
						s = "Linear",
						d = "Out",
						g = {GroupTransparency = 1}
					})
					gf:Play()
					gf.Completed:Wait()
					fo.Parent:Destroy()
				end
				, op)
		end)

		b[1]().lak(fo)

        -- ANIMATED GLOW EFFECT
		if op.Theme == 'lunahubontop' then
			local glowFrame = f("Frame", {
				Parent = fo,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 0
			}, {
				f("UICorner", {CornerRadius = UDim.new(0, 11)}),
				f("ImageLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 40, 1, 40),
					Position = UDim2.new(0, -20, 0, -20),
					Image = "rbxassetid://5028857084",
					ImageColor3 = Color3.fromRGB(200, 100, 255),
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(10, 10, 118, 118),
					ImageTransparency = 0.5
				})
			})
			
			-- Breathing glow animation
			spawn(function()
				while glowFrame and glowFrame.Parent do
					b[1]().tw({
						v = glowFrame.ImageLabel,
						t = 2,
						s = "Sine",
						d = "InOut",
						g = {ImageTransparency = 0.3}
					}):Play()
					wait(2)
					b[1]().tw({
						v = glowFrame.ImageLabel,
						t = 2,
						s = "Sine",
						d = "InOut",
						g = {ImageTransparency = 0.7}
					}):Play()
					wait(2)
				end
			end)
		end

		function g:CreateTab(gfjd)
			assert(gfjd.Title, "Tab - Missing Title")

			local tabIcon = gfjd.Icon or nil
			local Scroll, Search = nil, nil

			local Tab = f("Frame", {
				Parent = patab,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(1, 0, 0, 34),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1
			}, {
				f("UICorner", {
					CornerRadius = UDim.new(0, 8)
				}),
				f("UIGradient", {
					Rotation = 0,
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, a.Theme[op.Theme or 'Quizzy']['Color Tab'][1]),ColorSequenceKeypoint.new(1.000, a.Theme[op.Theme or 'Quizzy']['Color Tab'][2])}
				}),
				f("Frame", {
					Name = "Accent",
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(0, 3, 0.55, 0),
					BackgroundTransparency = 1
				}, {
					f("UICorner", {CornerRadius = UDim.new(1, 0)})
				}),
				f("Frame", {
					Name = "Content",
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
				}, {
					f("UIListLayout", {
						Padding = UDim.new(0, 5),
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("UIPadding", {
						PaddingLeft = UDim.new(0, 8),
						PaddingRight = UDim.new(0, 8)
					})
				}),
				f("TextButton", {
					BorderSizePixel = 0,
					TextSize = 14,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					ZIndex = 2
				})
			})
			
			-- Add icon if provided
			if tabIcon then
				f("ImageLabel", {
					Parent = Tab.Content,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Image = b[1]().gl(tabIcon),
					Size = UDim2.new(0, 16, 0, 16),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ImageColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
					LayoutOrder = 1
				})
			end
			
			-- Add title
			f("TextLabel", {
				Parent = Tab.Content,
				TextWrapped = true,
				BorderSizePixel = 0,
				TextXAlignment = Enum.TextXAlignment.Center,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 11,
				Font = Enum.Font.GothamMedium,
				TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Text = gfjd.Title,
				LayoutOrder = 2
			})

			-- IMPROVED: Smooth hover effect
			Tab.MouseEnter:Connect(function()
				if Tab.BackgroundTransparency > 0 then
					b[1]().tw({
						v = Tab,
						t = 0.2,
						s = "Linear",
						d = "Out",
						g = {BackgroundTransparency = 0.75}
					}):Play()
				end
			end)
			
			Tab.MouseLeave:Connect(function()
				if Tab.BackgroundTransparency < 1 and Tab.BackgroundTransparency > 0 then
					b[1]().tw({
						v = Tab,
						t = 0.2,
						s = "Linear",
						d = "Out",
						g = {BackgroundTransparency = 1}
					}):Play()
				end
			end)

			local Page = f("Frame", {
				Parent = fo,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				AnchorPoint = Vector2.new(0.5, 1),
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Name = "Page",
				Visible = false
			}, {
				f("UIPadding", {
					PaddingTop = UDim.new(0, 58),
					PaddingRight = UDim.new(0, 12),
					PaddingLeft = UDim.new(0, 142),
					PaddingBottom = UDim.new(0, 12)
				}),
				f("CanvasGroup", {
					BorderSizePixel = 0,
					BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Background Page'],
					Size = UDim2.new(1, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0)
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 6)}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Top Bar Page'],
						Size = UDim2.new(1, 0, 0, 35),
						BorderColor3 = Color3.fromRGB(0, 0, 0)
					}, {
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(132, 132, 132),
							AnchorPoint = Vector2.new(0, 1),
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0)
						}),
						f("TextLabel", {
							BorderSizePixel = 0,
							TextXAlignment = Enum.TextXAlignment.Left,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 12,
							FontFace = Font.new("rbxassetid://16658237174", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
							TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
							BackgroundTransparency = 1,
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(1, 0, 1, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Text = gfjd.Title .. " Options"
						}, {
							f("UIPadding", {
								PaddingRight = UDim.new(0, 23),
								PaddingLeft = UDim.new(0, 23)
							})
						}),
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							AnchorPoint = Vector2.new(1, 0.5),
							Size = UDim2.new(1, 0, 0, 20),
							Position = UDim2.new(1, 0, 0.5, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BackgroundTransparency = 1
						}, {
							f("UIPadding", {PaddingRight = UDim.new(0, 19), PaddingLeft = UDim.new(0, 200)}),
							f("Frame", {
								BorderSizePixel = 0,
								BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Search'],
								AnchorPoint = Vector2.new(1, 0.5),
								Size = UDim2.new(1, 0, 0, 20),
								Position = UDim2.new(1, 0, 0.5, 0),
								BorderColor3 = Color3.fromRGB(0, 0, 0)
							}, {
								f("UIPadding", {PaddingRight = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12)}),
								f("UICorner", {CornerRadius = UDim.new(1, 0)}),
								f("TextBox", {
									TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
									BorderSizePixel = 0,
									TextXAlignment = Enum.TextXAlignment.Left,
									TextSize = 11,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									Font = Enum.Font.Gotham,
									AnchorPoint = Vector2.new(0.5, 0.5),
									PlaceholderText = "search options",
									Size = UDim2.new(1, 0, 1, 0),
									Position = UDim2.new(0.5, 0, 0.5, 0),
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									Text = "",
									BackgroundTransparency = 1,
									ZIndex = 3,
								}, nil, function(a)
									Search = a
								end),
								f("ImageLabel", {
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									AnchorPoint = Vector2.new(1, 0.5),
									Image = "rbxassetid://15197354452",
									Size = UDim2.new(0, 10, 0, 10),
									BorderColor3 = Color3.fromRGB(0, 0, 0),
									BackgroundTransparency = 1,
									Position = UDim2.new(1, 0, 0.5, 0)
								})
							})
						})
					}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Size = UDim2.new(1, 0, 1, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BackgroundTransparency = 1
					}, {
						f("UIPadding", {PaddingTop = UDim.new(0, 42)}),
						f("ScrollingFrame", {
							Active = true,
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							AnchorPoint = Vector2.new(0.5, 1),
							Size = UDim2.new(0.98, 0, 1, 0),
							ScrollBarImageColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
							Position = UDim2.new(0.5, 0, 1, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							ScrollBarThickness = 3,
							BackgroundTransparency = 1
						}, {
							f("UIListLayout", {
								Padding = UDim.new(0, 5),
								SortOrder = Enum.SortOrder.LayoutOrder
							}),
							f("UIPadding", {
								PaddingLeft = UDim.new(0, 3),
								PaddingRight = UDim.new(0, 9)
							}),
						}, function(a)
							Scroll = a
						end)
					})
				})
			})

			-- IMPROVED: Smooth page transition without black flash
			local function selectTab()
				-- Deselect other tabs
				for i, v in pairs(patab:GetChildren()) do
					if v:IsA("Frame") and v ~= Tab then
						b[1]().tw({
							v = v,
							t = 0.25,
							s = "Linear",
							d = "Out",
							g = {BackgroundTransparency = 1}
						}):Play()
						
						local textLabel = v.Content:FindFirstChildOfClass("TextLabel")
						if textLabel then
							b[1]().tw({
								v = textLabel,
								t = 0.25,
								s = "Linear",
								d = "Out",
								g = {TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color']}
							}):Play()
						end
						
						b[1]().tw({
							v = v.Accent,
							t = 0.25,
							s = "Linear",
							d = "Out",
							g = {BackgroundTransparency = 1}
						}):Play()
					end
				end
				
				-- Hide other pages
				for i, v in pairs(fo:GetChildren()) do
					if v:IsA("Frame") and v.Name == "Page" and v ~= Page then
						v.Visible = false
					end
				end
				
				-- Select current tab with smooth effect
				b[1]().tw({
					v = Tab,
					t = 0.25,
					s = "Linear",
					d = "Out",
					g = {BackgroundTransparency = 0}
				}):Play()
				
				local textLabel = Tab.Content:FindFirstChildOfClass("TextLabel")
				if textLabel then
					b[1]().tw({
						v = textLabel,
						t = 0.25,
						s = "Linear",
						d = "Out",
						g = {TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Tab Select']}
					}):Play()
				end
				
				b[1]().tw({
					v = Tab.Accent,
					t = 0.25,
					s = "Linear",
					d = "Out",
					g = {BackgroundTransparency = 0}
				}):Play()
				
				-- Show page with fade in
				Page.Visible = true
				b[1]().tw({
					v = Page.CanvasGroup,
					t = 0.25,
					s = "Linear",
					d = "Out",
					g = {GroupTransparency = 0}
				}):Play()
			end

			Tab.TextButton.MouseButton1Click:Connect(function()
				selectTab()
			end)

			delay(0.1, function()
				if patab:FindFirstChild(Tab.Name) == Tab and Tab == patab:GetChildren()[1] then
					selectTab()
				end
			end)

			Search.Changed:Connect(function()
				local SearchT = string.lower(Search.Text)
				for i,v in pairs(Scroll:GetChildren()) do
					if v:IsA("Frame") then
						if SearchT ~= "" and v:FindFirstChild("TextDesc") and v.TextDesc:FindFirstChild("TextLabel") then
							if string.find(string.lower(v.TextDesc.TextLabel.Text), SearchT) then
								v.Visible = true
							else
								v.Visible = false
							end
						else
							v.Visible = true
						end
					end
				end
			end)

			local Func = {}
			
			Func.ConfigSystem = b[3]()
			Func.ConfigSystem.ConfigName = op.Title .. "_" .. gfjd.Title
			
			delay(1, function()
				Func.ConfigSystem:LoadConfig()
			end)

			function Func:CreateToggle(khgkgh)
				assert(khgkgh.Title, "Toggle - Missing Title")
				local Value = khgkgh.Value or false
				local Callback = khgkgh.Callback or function() end

				local par = b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, false, op)
				local click = b[1]().click(par)
				local toggle = f("Frame", {
					Parent = par,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.new(0, 100, 0.8, 0),
					Position = UDim2.new(1, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1
				}, {
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("UIPadding", {PaddingRight = UDim.new(0, 13)}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Toggle Color'],
						Size = UDim2.new(0, 30, 0, 15),
						BorderColor3 = Color3.fromRGB(0, 0, 0)
					}, {
						f("UICorner", {CornerRadius = UDim.new(1, 0)}),
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0, 8, 0, 8),
							Position = UDim2.new(0.25, 0, 0.5, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0)
						}, {
							f("UICorner", {CornerRadius = UDim.new(1, 0)}),
						})
					})
				})

				local function ToggleC(newValue)
					Value = newValue
					if not Value then
						pcall(function()
							Callback(Value)
						end)
						b[1]().tw({
							v = par.TextDesc.TextLabel,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {TextTransparency = 0.4}
						}):Play()
						b[1]().tw({
							v = toggle.Frame,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Toggle Color']}
						}):Play()
						b[1]().tw({
							v = toggle.Frame.Frame,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {Position = UDim2.new(0.25, 0, 0.5, 0)}
						}):Play()
					elseif Value then 
						pcall(function()
							Callback(Value)
						end)
						b[1]().tw({
							v = par.TextDesc.TextLabel,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {TextTransparency = 0}
						}):Play()
						b[1]().tw({
							v = toggle.Frame,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main']}
						}):Play()
						b[1]().tw({
							v = toggle.Frame.Frame,
							t = 0.15,
							s = "Linear",
							d = "InOut",
							g = {Position = UDim2.new(0.75, 0, 0.5, 0)}
						}):Play()
					end
				end

				delay(0.5,function()
					ToggleC(Value)
				end)

				click.MouseButton1Click:Connect(function()
					Value = not Value
					b[1]().jc(click, par)
					ToggleC(Value)
				end)

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function NewSet:SetVisible(newVisible)
					par.Visible = newVisible
				end

				function NewSet:SetValue(newValue)
					ToggleC(newValue)
				end
				
				local Key = khgkgh.Key or khgkgh.Title
				Func.ConfigSystem:Register(Key, 
					function() return Value end,
					function(val) ToggleC(val) end
				)

				return NewSet
			end

			function Func:CreateDropdown(khgkgh)
				assert(khgkgh.Title, "Dropdown - Missing Title")
				local List = khgkgh.List or {}
				local Value = khgkgh.Value or ""
				local Multi = khgkgh.Multi or false
				local Callback = khgkgh.Callback or function() end

				local function vd()
					if type(Value) == "table" then
						return table.concat(Value, ", ")
					else
						return Value
					end
				end

				local par = b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, false, op)
				local dropdown = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 100, 1, 0)
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0, 13)}),
					f("Frame", {
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Dropdown Color'],
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0,0, 20),
						Position = UDim2.new(1, 0, 0.5, 0)
					}, {
						f("UICorner", {CornerRadius = UDim.new(0,4)}),
						f("UIPadding", {PaddingLeft = UDim.new(0,5)}),
						f("ImageLabel", {
							AnchorPoint = Vector2.new(1, 0),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Position = UDim2.new(1, 0,0, 0),
							Size = UDim2.new(0, 20,0, 20),
							Image = "rbxassetid://14928415132"
						}),
						f("TextLabel", {
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(0.75, 0,1, 0),
							Font = Enum.Font.Gotham,
							Text = vd(),
							TextColor3 = Color3.fromRGB(255,255,255),
							TextSize = 10,
							TextXAlignment = Enum.TextXAlignment.Left
						})
					})
				})

				local dropdownselect = f("Frame", {
					Parent = fo.Parent,
					BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Dropdown Select Background'],
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0,0, 0),
					Size = UDim2.new(0, 150,0, 0),
					ClipsDescendants = true,
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 4)}),
					f("UIPadding", {PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5), PaddingRight = UDim.new(0, 3)}),
					f("UIStroke", {Color = a.Theme[op.Theme or 'Quizzy']['Dropdown Select Stroke'], Transparency = 1}),
					f("ScrollingFrame", {
						Active = true,
						BackgroundColor3 = Color3.fromRGB(255,255,255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0,1, 0),
						ClipsDescendants = true,
						AutomaticCanvasSize = Enum.AutomaticSize.None,
						BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png",
						CanvasPosition = Vector2.new(0, 0),
						ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
						HorizontalScrollBarInset = Enum.ScrollBarInset.None,
						MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
						ScrollBarImageColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
						ScrollBarImageTransparency = 0,
						ScrollBarThickness = 3,
						ScrollingDirection = Enum.ScrollingDirection.XY,
						TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png",
						VerticalScrollBarInset = Enum.ScrollBarInset.None,
						VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
					}, {
						f("UIListLayout", {Padding = UDim.new(0,3), SortOrder = Enum.SortOrder.LayoutOrder}),
						f("UIPadding", {PaddingLeft = UDim.new(0,3), PaddingRight = UDim.new(0,7)})
					})
				})

				dropdownselect.Position = UDim2.new(0, dropdown.Frame.AbsolutePosition.X - dropdownselect.Parent.AbsolutePosition.X + dropdown.Frame.Size.X.Offset - 150, 0, dropdown.Frame.AbsolutePosition.Y - dropdownselect.Parent.AbsolutePosition.Y + dropdown.Frame.Size.Y.Offset - 20)

				local isopen = false
				local click = b[1]().click(par)

				local function opendropdown()
					local screenGui = fo.Parent.Parent
					local viewportSize = workspace.CurrentCamera.ViewportSize

					local targetX = dropdown.Frame.AbsolutePosition.X - dropdownselect.Parent.AbsolutePosition.X + dropdown.Frame.Size.X.Offset - 80
					local targetY = dropdown.Frame.AbsolutePosition.Y - dropdownselect.Parent.AbsolutePosition.Y + dropdown.Frame.Size.Y.Offset - 20

					if targetX < 0 then targetX = 0 end
					if targetX + 150 > viewportSize.X then targetX = viewportSize.X - 150 end

					if targetY < 0 then targetY = 0 end
					if targetY + 200 > viewportSize.Y then targetY = viewportSize.Y - 200 end
					dropdownselect.Position = UDim2.new(0, targetX, 0, targetY)
					if dropdownselect.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + 13 < 120 then
						b[1]().tw({
							v = dropdownselect,
							t = 0.15,
							s = "Exponential",
							d = "InOut",
							g = {Size = UDim2.new(0, 150,0, dropdownselect.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + 13)}
						}):Play()
						b[1]().tw({
							v = dropdownselect.UIStroke,
							t = 0.15,
							s = "Exponential",
							d = "InOut",
							g = {Transparency = 0}
						}):Play()
					else
						b[1]().tw({
							v = dropdownselect.UIStroke,
							t = 0.15,
							s = "Exponential",
							d = "InOut",
							g = {Transparency = 0}
						}):Play()
						b[1]().tw({
							v = dropdownselect,
							t = 0.15,
							s = "Exponential",
							d = "InOut",
							g = {Size = UDim2.new(0, 150,0, 120), Position = UDim2.new(0, targetX, 0, targetY)}
						}):Play()
					end
				end

				local function closedropdown()
					b[1]().tw({
						v = dropdownselect,
						t = 0.15,
						s = "Exponential",
						d = "InOut",
						g = {Size = UDim2.new(0, 150,0, 0)}
					}):Play()
					b[1]().tw({
						v = dropdownselect.UIStroke,
						t = 0.15,
						s = "Exponential",
						d = "InOut",
						g = {Transparency = 1}
					}):Play()
				end

				game:GetService "UserInputService".InputBegan:Connect(function(A)
					if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
						local B, C = dropdownselect.AbsolutePosition, dropdownselect.AbsoluteSize
						if game:GetService "Players".LocalPlayer:GetMouse().X < B.X or game:GetService "Players".LocalPlayer:GetMouse().X > B.X + C.X or game:GetService "Players".LocalPlayer:GetMouse().Y < (B.Y - 20 - 1) or game:GetService "Players".LocalPlayer:GetMouse().Y > B.Y + C.Y then
							closedropdown()
						end
					end
				end)

				click.MouseButton1Click:Connect(function()
					isopen = not isopen
					if not isopen then
						closedropdown()
					else
						opendropdown()
					end
				end)

				local function dps()
					local newWidth = dropdown.Frame.TextLabel.TextBounds.X + 50
					if newWidth > 150 then
						newWidth = 150
					end
					local g = b[1]().tw({
						v = dropdown,
						t = 0.15,
						s = "Back",
						d = "InOut",
						g = {Size = UDim2.new(0, newWidth, 1, 0)}
					})
					g:Play()
					g.Completed:Wait()
					dropdown.Frame.TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
				end

				local itemslist = {}
				local selectedValues = {}
				local selectedItem

				function itemslist:Clear()
					if not Multi then
						for _, child in ipairs(dropdownselect.ScrollingFrame:GetChildren()) do
							if child:IsA("Frame") then
								child:Destroy()
							end
						end

						selectedItem = nil
						dropdown.Frame.TextLabel.Text = ""
					else
						for key in pairs(selectedValues) do
							selectedValues[key] = nil
						end

						for _, child in ipairs(dropdownselect.ScrollingFrame:GetChildren()) do
							if child:IsA("Frame") then
								child:Destroy()
							end
						end

						dropdown.Frame.TextLabel.Text = ""
					end
				end

				function itemslist:Remove(t)
					for _, child in ipairs(dropdownselect.ScrollingFrame:GetChildren()) do
						if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
							if child.TextLabel.Text == t then
								if Multi and selectedValues[t] then
									selectedValues[t] = nil
									local selectedList = {}
									for i, v in pairs(selectedValues) do
										table.insert(selectedList, i)
									end
									if #selectedList > 0 then
										dropdown.Frame.TextLabel.Text = table.concat(selectedList, ", ")
									else
										dropdown.Frame.TextLabel.Text = ""
									end
									pcall(function()
										Callback(selectedList)
									end)
								end
								
								if not Multi and Value == t then
									Value = ""
									dropdown.Frame.TextLabel.Text = ""
									pcall(function()
										Callback("")
									end)
								end
								
								child:Destroy()
								break
							end
						end
					end
				end

				function itemslist:Add(t)
					local item = f("Frame", {
						Parent = dropdownselect.ScrollingFrame,
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Dropdown Item'],
						BackgroundTransparency = 0.9,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0,0, 20),
					}, {
						f("UICorner", {CornerRadius = UDim.new(0, 4)}),
						f("UIPadding", {PaddingLeft = UDim.new(0, 5)}),
						f("UIGradient", {Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 170))}}),
						f("TextLabel", {
							BackgroundColor3 = Color3.fromRGB(255,255,255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0,1, 0),
							Font = Enum.Font.Gotham,
							Text = t,
							TextColor3 = Color3.fromRGB(255,255,255),
							TextSize = 11,
							TextXAlignment = Enum.TextXAlignment.Left
						})
					})

					local clickitem = b[1]().click(item)
					clickitem.MouseButton1Click:Connect(function()
						b[1]().jc(clickitem, item)
						if Multi then
							if selectedValues[t] then
								selectedValues[t] = nil
								b[1]().tw({
									v = item,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {BackgroundColor3 = Color3.fromRGB(88, 88, 88), BackgroundTransparency = 0.9}
								}):Play()
								b[1]().tw({
									v = item.TextLabel,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {TextColor3 = Color3.fromRGB(255 ,255 ,255)}
								}):Play()
								item.TextLabel.Text = t
								local selectedList = {}
								for i, v in pairs(selectedValues) do
									table.insert(selectedList, i)
								end
								if #selectedList > 0 then
									dropdown.Frame.TextLabel.Text = table.concat(selectedList, ", ")
								else
									dropdown.Frame.TextLabel.Text = ""
								end
								pcall(function()
									Callback(selectedList)
								end)
							else
								b[1]().tw({
									v = item,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}
								}):Play()
								b[1]().tw({
									v = item.TextLabel,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {TextColor3 = Color3.fromRGB(0, 0, 0)}
								}):Play()
								selectedValues[t] = true
								item.TextLabel.Text = t
								local selectedList = {}
								for i, v in pairs(selectedValues) do
									table.insert(selectedList, i)
								end
								dropdown.Frame.TextLabel.Text = table.concat(selectedList, ", ")
								pcall(function()
									Callback(selectedList)
								end)
							end
						else
							for i,v in pairs(dropdownselect.ScrollingFrame:GetChildren()) do
								if v:IsA("Frame") then
									b[1]().tw({
										v = v,
										t = 0.15,
										s = "Linear",
										d = "InOut",
										g = {BackgroundColor3 = Color3.fromRGB(88, 88, 88), BackgroundTransparency = 0.9}
									}):Play()
									b[1]().tw({
										v = v.TextLabel,
										t = 0.15,
										s = "Linear",
										d = "InOut",
										g = {TextColor3 = Color3.fromRGB(255 ,255 ,255)}
									}):Play()
								end
							end
							b[1]().tw({
								v = item,
								t = 0.15,
								s = "Linear",
								d = "InOut",
								g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}
							}):Play()
							b[1]().tw({
								v = item.TextLabel,
								t = 0.15,
								s = "Linear",
								d = "InOut",
								g = {TextColor3 = Color3.fromRGB(0, 0, 0)}
							}):Play()
							item.TextLabel.Text = t
							Value = t
							dropdown.Frame.TextLabel.Text = t
							pcall(function()
								Callback(t)
							end)
						end
					end)

					local function isValueInTable(val, tbl)
						if type(tbl) ~= "table" then
							return false
						end

						for _, v in pairs(tbl) do
							if v == val then
								return true
							end
						end
						return false
					end

					delay(0,function()
						if Multi then
							if isValueInTable(t, Value) then
								b[1]().tw({
									v = item,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}
								}):Play()
								b[1]().tw({
									v = item.TextLabel,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {TextColor3 = Color3.fromRGB(0, 0, 0)}
								}):Play()
								item.TextLabel.Text = t
								selectedValues[t] = true
								local selectedList = {}
								for i, v in pairs(selectedValues) do
									table.insert(selectedList, i)
								end
								dropdown.Frame.TextLabel.Text = table.concat(selectedList, ", ")
								pcall(function()
									Callback(selectedList)
								end)
							end
						else
							if t == Value then
								b[1]().tw({
									v = item,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}
								}):Play()
								b[1]().tw({
									v = item.TextLabel,
									t = 0.15,
									s = "Linear",
									d = "InOut",
									g = {TextColor3 = Color3.fromRGB(0, 0, 0)}
								}):Play()
								item.TextLabel.Text = t
								Value = t
								dropdown.Frame.TextLabel.Text = t
								pcall(function()
									Callback(t)
								end)
							end
						end
						dps()
					end)
				end

				for i,v in ipairs(List) do
					itemslist:Add(v)
				end

				dropdown.Frame.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
					dps()
				end)

				dropdownselect.ScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					dropdownselect.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, dropdownselect.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + 5)
				end)

				function itemslist:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function itemslist:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function itemslist:SetVisible(newVisible)
					par.Visible = newVisible
				end

				local Key = khgkgh.Key or khgkgh.Title
				Func.ConfigSystem:Register(Key,
					function() 
						if Multi then
							local list = {}
							for k, v in pairs(selectedValues) do
								table.insert(list, k)
							end
							return list
						else
							return Value
						end
					end,
					function(val)
						if Multi then
							selectedValues = {}
							if type(val) == "table" then
								for _, v in ipairs(val) do
									selectedValues[v] = true
								end
							end
							local list = {}
							for k in pairs(selectedValues) do
								table.insert(list, k)
							end
							dropdown.Frame.TextLabel.Text = table.concat(list, ", ")
							
							for _, child in ipairs(dropdownselect.ScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
									local itemText = child.TextLabel.Text
									if selectedValues[itemText] then
										b[1]().tw({v = child, t = 0.15, s = "Linear", d = "InOut", 
											g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}}):Play()
										b[1]().tw({v = child.TextLabel, t = 0.15, s = "Linear", d = "InOut", 
											g = {TextColor3 = Color3.fromRGB(0, 0, 0)}}):Play()
									else
										b[1]().tw({v = child, t = 0.15, s = "Linear", d = "InOut",
											g = {BackgroundColor3 = Color3.fromRGB(88, 88, 88), BackgroundTransparency = 0.9}}):Play()
										b[1]().tw({v = child.TextLabel, t = 0.15, s = "Linear", d = "InOut",
											g = {TextColor3 = Color3.fromRGB(255, 255, 255)}}):Play()
									end
								end
							end
							pcall(function()
								Callback(list)
							end)
						else
							Value = val
							dropdown.Frame.TextLabel.Text = val
							
							for _, child in ipairs(dropdownselect.ScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
									if child.TextLabel.Text == val then
										b[1]().tw({v = child, t = 0.15, s = "Linear", d = "InOut",
											g = {BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'], BackgroundTransparency = 0}}):Play()
										b[1]().tw({v = child.TextLabel, t = 0.15, s = "Linear", d = "InOut",
											g = {TextColor3 = Color3.fromRGB(0, 0, 0)}}):Play()
									else
										b[1]().tw({v = child, t = 0.15, s = "Linear", d = "InOut",
											g = {BackgroundColor3 = Color3.fromRGB(88, 88, 88), BackgroundTransparency = 0.9}}):Play()
										b[1]().tw({v = child.TextLabel, t = 0.15, s = "Linear", d = "InOut",
											g = {TextColor3 = Color3.fromRGB(255, 255, 255)}}):Play()
									end
								end
							end
							pcall(function()
								Callback(val)
							end)
						end
					end
				)

				return itemslist
			end

			function Func:CreateLabel(khgkgh)
				assert(khgkgh.Title, "Label - Missing Title")
				local par = b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, true, op)
				par.TextDesc.TextLabel.TextTransparency = 0

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function NewSet:SetVisible(newVisible)
					par.Visible = newVisible
				end

				return NewSet
			end

			function Func:CreateButton(khgkgh)
				assert(khgkgh.Title, "Button - Missing Title")
				local par, Callback = b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, false, op), khgkgh.Callback or function() end
				par.TextDesc.TextLabel.TextTransparency = 0

				local button = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 100, 0.8, 0),
					BorderSizePixel = 0
				}, {
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("UIPadding", {PaddingRight = UDim.new(0,13)}),
					f("ImageLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0, 20,0, 20),
						Image = "rbxassetid://14922213932"
					})
				})

				local click = b[1]().click(par)
				click.MouseButton1Click:Connect(function()
					b[1]().jc(click, par)
					pcall(function()
						Callback()
					end)
				end)

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function NewSet:SetVisible(newVisible)
					par.Visible = newVisible
				end

				return NewSet
			end

			function Func:CreateTextbox(khgkgh)
				assert(khgkgh.Title, "TextBox - Missing Title")
				local par, Callback, Placeholder, Value, ClearTextOnFocus = b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, false, op), khgkgh.Callback or function() end, khgkgh.Placeholder or "Paste Your Text", khgkgh.Value or "", khgkgh.ClearTextOnFocus or false
				par.TextDesc.TextLabel.TextTransparency = 0
				par.TextDesc.UIPadding.PaddingRight = UDim.new(0, 210)

				local textbox = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 200,0.8, 0)
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0,13)}),
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("Frame", {
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Textbox Color'],
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0,0, 20)
					}, {
						f("UICorner", {CornerRadius = UDim.new(0,4)}),
						f("Frame", {
							AnchorPoint = Vector2.new(.5, 1),
							BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
							BorderSizePixel = 0,
							Position = UDim2.new(.5, 0,1, 0),
							Size = UDim2.new(0, 0,0, 1),
							Name = "Line",
							BackgroundTransparency = 0.9
						}),
						f("Frame", {
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0,1, 0),
							Name = "ValueBox"
						}, {
							f("TextBox", {
								Active = true,
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								CursorPosition = -1,
								Size = UDim2.new(1, 0,1, 0),
								Font = Enum.Font.Gotham,
								PlaceholderColor3 = Color3.fromRGB(178,178,178),
								PlaceholderText = Placeholder,
								Text = Value,
								TextColor3 = Color3.fromRGB(255,255,255),
								TextSize = 11,
								TextXAlignment = Enum.TextXAlignment.Left,
								TextTruncate = Enum.TextTruncate.AtEnd,
								ClearTextOnFocus = ClearTextOnFocus
							}),
							f("UIPadding", {PaddingLeft = UDim.new(0,5)})
						})
					}),
				})

				textbox.Frame.ValueBox.TextBox.FocusLost:Connect(function()
					if Value then
						if #textbox.Frame.ValueBox.TextBox.Text > 0 then
							pcall(Callback,textbox.Frame.ValueBox.TextBox.Text)
						end
					end
				end)

				textbox.Frame.ValueBox.TextBox.Focused:Connect(function()
					b[1]().tw({
						v = textbox.Frame.Line,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 1)}
					}):Play()
				end)

				textbox.Frame.ValueBox.TextBox.FocusLost:Connect(function()
					b[1]().tw({
						v = textbox.Frame.Line,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = 0.9, Size = UDim2.new(0, 0, 0, 1)}
					}):Play()
				end)

				delay(0,function()
					if Value then
						if #textbox.Frame.ValueBox.TextBox.Text > 0 then
							pcall(Callback,textbox.Frame.ValueBox.TextBox.Text)
						end
					end
				end)

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function NewSet:SetVisible(newVisible)
					par.Visible = newVisible
				end

				function NewSet:SetValue(newValue)
					textbox.Frame.ValueBox.TextBox.Text = newValue
				end
				
				local Key = khgkgh.Key or khgkgh.Title
				Func.ConfigSystem:Register(Key,
					function() return textbox.Frame.ValueBox.TextBox.Text end,
					function(val) 
						textbox.Frame.ValueBox.TextBox.Text = val
						pcall(function()
							Callback(val)
						end)
					end
				)

				return NewSet
			end

			function Func:CreateSlider(khgkgh)
				assert(khgkgh.Title, "Slider - Missing Title")
				local par, Callback, Value, Min, Max, DecimalPlaces = 
					b[1]().background(Scroll, khgkgh.Title, khgkgh.Desc, true, op), 
				khgkgh.Callback or function() end, 
				khgkgh.Value or khgkgh.Max / 2, 
				khgkgh.Min or 0, 
				khgkgh.Max or 100,
				khgkgh.DecimalPlaces or 0

				par.TextDesc.TextLabel.TextTransparency = 0
				par.TextDesc.UIPadding.PaddingRight = UDim.new(0, 210)

				local slider = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 200,0.8, 0),
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0,13)}),
					f("UIListLayout", {
						Padding = UDim.new(0,5),
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("TextBox", {
						Active = true,
						BackgroundColor3 = Color3.fromRGB(255,255,255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						LayoutOrder = -1,
						Size = UDim2.new(0, 30,0, 30),
						Font = Enum.Font.GothamBold,
						PlaceholderColor3 = Color3.fromRGB(178,178,178),
						PlaceholderText = "",
						Text = "80",
						TextColor3 = Color3.fromRGB(255,255,255),
						TextSize = 10,
					}),
					f("CanvasGroup", {
						BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Slider Color'],
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(0, 150,0, 8),
						Name = "Frame"
					}, {
						f("UICorner", {CornerRadius = UDim.new(1,0)}),
						f("Frame", {
							BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Color Main'],
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(0.8, 0,1, 0)
						}, {
							f("UICorner", {CornerRadius = UDim.new(1,0)}),
							f("UIPadding", {PaddingRight = UDim.new(0,1)}),
							f("ImageLabel", {
								AnchorPoint = Vector2.new(1, 0.5),
								BackgroundColor3 = Color3.fromRGB(255,255,255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0,0,0),
								BorderSizePixel = 0,
								Position = UDim2.new(1, 0,0.5, 0),
								Size = UDim2.new(0, 8,0, 8),
								Image = "rbxassetid://117975105537462",
							})
						}),
					})
				})

				local click = b[1]().click(slider.Frame)

				local function roundToDecimal(value, decimals)
					local factor = 10 ^ decimals
					return math.floor(value * factor + 0.5) / factor
				end

				local function updateSlider(value)
					value = math.clamp(value, Min, Max)
					value = roundToDecimal(value, DecimalPlaces)
					Value = value  
					b[1]().tw({
						v = slider.Frame.Frame,
						t = 0.5,
						s = "Exponential",
						d = "Out",
						g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
					}):Play()
					slider.TextBox.Text = tonumber(value)
					pcall(function()
						Callback(value)  
					end)
				end

				delay(0.5,function()
					updateSlider(Value or 0)
				end)

				slider.TextBox.FocusLost:Connect(function()
					local value = tonumber(slider.TextBox.Text) or Min
					updateSlider(value)
				end)

				local function move(input)
					local sliderBar = slider.Frame
					local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
					local value = relativeX * (Max - Min) + Min
					updateSlider(value)
				end

				local dragging = false

				click.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						move(input)
					end
				end)

				click.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						move(input)
					end
				end)

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					par.TextDesc.TextLabel.Text = newTitle
				end

				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then
						descLabel.Text = newDesc
					else
						b[1]().desc(par.TextDesc, newDesc, op)
					end
				end

				function NewSet:SetVisible(newVisible)
					par.Visible = newVisible
				end

				function NewSet:SetDecimalPlaces(newDecimalPlaces)
					DecimalPlaces = newDecimalPlaces
					updateSlider(Value)
				end

				function NewSet:SetValue(newValue)
					updateSlider(newValue)
				end

				local Key = khgkgh.Key or khgkgh.Title
				Func.ConfigSystem:Register(Key,
					function() return Value end,
					function(val) 
						Value = val
						updateSlider(val) 
					end
				)

				return NewSet
			end

			function Func:CreateSection(khgkgh)
				assert(khgkgh.Title, "Section - Missing Title")
				local section = f("Frame", {
					Parent = Scroll,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 100,0, 20),
					BorderSizePixel = 0
				}, {
					f("TextLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0, 200,1, 0),
						Font = Enum.Font.Gotham,
						Text = khgkgh.Title,
						TextColor3 = a.Theme[op.Theme or 'Quizzy']['Text Color'],
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					f("UIPadding", {
						PaddingLeft = UDim.new(0,13),
						PaddingRight = UDim.new(0,90)
					})
				})

				local NewSet = {}

				function NewSet:SetTitle(newTitle)
					section.TextLabel.Text = newTitle
				end

				function NewSet:SetVisible(newVisible)
					section.Visible = newVisible
				end

				return NewSet
			end

			Scroll.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.UIListLayout.AbsoluteContentSize.Y + 10)
			end)

			return Func
		end

		function g:CreateDialog(hfdjgf)
			assert(hfdjgf.Title, "Dialog - Missing Title")
			return b[1]().dialog(fo ,
				hfdjgf.Title,
				hfdjgf.Desc,
				hfdjgf.Callback or function() end
				, op)
		end

		function g:SetTransparency(khgkgh)
			a.Theme[op.Theme or 'Quizzy']['Background Transparency'] = khgkgh
			b[1]().tw({
				v = fo,
				t = 0.5,
				s = "Exponential",
				d = "Out",
				g = {GroupTransparency = khgkgh}
			}):Play()
		end

		local CloseUI = f("ImageButton", {
			Name = "CloseUI",
			Parent = fo.Parent,
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = a.Theme[op.Theme or 'Quizzy']['Background'],
			BackgroundTransparency = a.Theme[op.Theme or 'Quizzy']['Background Transparency'],
			BorderColor3 = Color3.fromRGB(0,0,0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.1, 0,0.1, 0),
			Size = UDim2.new(0, 45,0, 45),
			Image = b[1]().gl(op.Icon)
		}, {
			f("UICorner", {
				CornerRadius = UDim.new(0,6)
			})
		})

		b[1]().init(CloseUI)
		b[1]().lak(CloseUI)

		local function closeopenui()
			isopen = not isopen
			local g
			if isopen then
				if g then
					g:Cancel()
				end
				for i = 1, 2 do
					isfoui[i]:Destroy()
				end
				g = b[1]().tw({
					v = fo,
					t = 0.15,
					s = "Linear",
					d = "Out",
					g = {GroupTransparency = 1}
				})
				g:Play()
				g.Completed:Connect(function()
					fo.Visible = false
				end)
			else
				fo.Visible = true
				isfoui = b[1]().init(fo)
				b[1]().tw({
					v = fo,
					t = 0.15,
					s = "Linear",
					d = "Out",
					g = {GroupTransparency = a.Theme[op.Theme or 'Quizzy']['Background Transparency']}
				}):Play()
			end
		end

		CloseUI.MouseButton1Click:Connect(function()
			closeopenui()
		end)

		game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == KeyCloseUI then
				closeopenui()
			end
		end)

		scl.CanvasGroup.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			scl.CanvasSize = UDim2.new(0, 0, 0, scl.CanvasGroup.UIListLayout.AbsoluteContentSize.Y + 20)
		end)

		return g
	end,
}
