a = {
	Theme = {
		['Dark'] = {
			['Background'] = Color3.fromRGB(15, 15, 15),
			['Background Transparency'] = 0.1,
			['Color Main'] = Color3.fromRGB(250, 7, 7),
			['Color Stroke'] = Color3.fromRGB(50, 50, 50),
			['Top Bar'] = Color3.fromRGB(15, 15, 15),
			['Text Color'] = Color3.fromRGB(255, 255, 255),
			['Tab Bar'] = Color3.fromRGB(15, 15, 15),
			['Background Page'] = Color3.fromRGB(15, 15, 15),
			['Line Page'] = Color3.fromRGB(80, 80, 80),
			['Top Bar Page'] = Color3.fromRGB(15, 15, 15),
			['Search'] = Color3.fromRGB(30, 30, 30),
			['Background Function'] = Color3.fromRGB(255, 255, 255),
			['Background Function Transparency'] = 0.935,
			['Background Function Transparency Moved'] = 0.88,
			['Dropdown Color'] = Color3.fromRGB(30, 30, 30),
			['Dropdown Select Background'] = Color3.fromRGB(20, 20, 20),
			['Dropdown Select Stroke'] = Color3.fromRGB(255, 255, 255),
			['Dropdown Item'] = Color3.fromRGB(88, 88, 88),
			['Textbox Color'] = Color3.fromRGB(30, 30, 30),
			['Slider Color'] = Color3.fromRGB(30, 30, 30),
			['Toggle Color'] = Color3.fromRGB(30, 30, 30),
			['Diglog Top Bar'] = Color3.fromRGB(22, 22, 22),
			['Diglog Background'] = Color3.fromRGB(17, 17, 17),
			['Section Header'] = Color3.fromRGB(255, 255, 255),
			['Section Header Transparency'] = 0.935
		},
	},
}
local Services = {
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
	Players = game:GetService("Players"),
	RunService = game:GetService("RunService"),
	Lighting = game:GetService("Lighting"),
}
local LocalPlayer = Services.Players.LocalPlayer
local cachedHelpers = nil
b = {
	[1] = function()
		if cachedHelpers then
			return cachedHelpers
		end
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
		local tweenInfoCache = {}
		function x.tw(info)
			local key = info.t .. "|" .. info.s .. "|" .. info.d
			local ti = tweenInfoCache[key]
			if not ti then
				ti = TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d])
				tweenInfoCache[key] = ti
			end
			return Services.TweenService:Create(info.v, ti, info.g)
		end
		local activeTweens = setmetatable({}, {__mode = "k"})
		function x.twSafe(info)
			local inst = info.v
			activeTweens[inst] = activeTweens[inst] or {}
			for prop in pairs(info.g) do
				local running = activeTweens[inst][prop]
				if running then
					running:Cancel()
				end
			end
			local tween = x.tw(info)
			for prop in pairs(info.g) do
				activeTweens[inst][prop] = tween
			end
			tween.Completed:Connect(function()
				for prop in pairs(info.g) do
					if activeTweens[inst][prop] == tween then
						activeTweens[inst][prop] = nil
					end
				end
			end)
			return tween
		end
		function x.flash(inst, prop, color, dur)
			if not inst or not inst:IsDescendantOf(game) and not inst.Parent then return end
			local ok, original = pcall(function() return inst[prop] end)
			if not ok then return end
			dur = dur or 0.12
			local up = x.tw({v = inst, t = dur, s = "Quad", d = "Out", g = {[prop] = color}})
			up:Play()
			up.Completed:Connect(function()
				if inst and inst.Parent then
					x.tw({v = inst, t = dur * 2, s = "Quad", d = "Out", g = {[prop] = original}}):Play()
				end
			end)
		end
		function x.lak(o)
			local a, b, c, d
			local function u(i)
				local dt = i.Position - c
				game:GetService"TweenService":Create(o, TweenInfo.new(0.3), {Position = UDim2.new(d.X.Scale, d.X.Offset + dt.X, d.Y.Scale, d.Y.Offset + dt.Y)}):Play()
			end
			o.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then a = true c = i.Position d = o.Position; i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then a = false end end) end end)
			o.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then b = i end end)
			Services.UserInputService.InputChanged:Connect(function(i) if i == b and a then u(i) end end)
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
					BackgroundColor3 = a.Theme[theme.Theme or 'Dark']['Diglog Background'],
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0, 300, 0, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					GroupTransparency = 1
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 8)}),
					f("UIStroke", {Color = a.Theme[theme.Theme or 'Dark']['Color Stroke'], Thickness = 1.2}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = a.Theme[theme.Theme or 'Dark']['Diglog Top Bar'],
						Size = UDim2.new(1, 0, 0, 50),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
					}, {
						f("TextLabel", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							Font = Enum.Font.GothamBold,
							TextColor3 = a.Theme[theme.Theme or 'Dark']['Text Color'],
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
							f("UIStroke", {Color = Color3.fromRGB(9, 255, 58), Thickness = 0.6}),
							f("UICorner", {CornerRadius = UDim.new(0, 6)}),
							f("TextLabel", {
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 13,
								Font = Enum.Font.GothamBold,
								TextColor3 = a.Theme[theme.Theme or 'Dark']['Text Color'],
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
								Font = Enum.Font.SourceSans,
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
							f("UIStroke", {Color = Color3.fromRGB(255, 52, 0), Thickness = 0.6}),
							f("UICorner", {CornerRadius = UDim.new(0, 6)}),
							f("TextLabel", {
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 13,
								Font = Enum.Font.GothamBold,
								TextColor3 = a.Theme[theme.Theme or 'Dark']['Text Color'],
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
								Font = Enum.Font.SourceSans,
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
					TextSize = 11,
					Font = Enum.Font.Gotham,
					TextColor3 = a.Theme[theme.Theme or 'Dark']['Text Color'],
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
			Services.UserInputService.InputBegan:Connect(function(A)
				if not isDestroyed and A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
					local B, C = hf.CanvasGroup.AbsolutePosition, hf.CanvasGroup.AbsoluteSize
					local M = LocalPlayer:GetMouse()
					if M.X < B.X or M.X > B.X + C.X or M.Y < (B.Y - 20 - 1) or M.Y > B.Y + C.Y then
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
				TextSize = 10,
				Font = Enum.Font.Gotham,
				TextColor3 = Color3.fromRGB(150, 150, 150),
				BackgroundTransparency = 1,
				RichText = true,
				Size = UDim2.new(1, 0, 0, math.floor(14)),
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
				BackgroundColor3 = a.Theme[theme.Theme or 'Dark']['Background Function'],
				Size = UDim2.new(1, 0, 0, 38),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = a.Theme[theme.Theme or 'Dark']['Background Function Transparency'],
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
					f("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 90)}),
					f("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("TextLabel", {
						TextWrapped = true,
						BorderSizePixel = 0,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextTransparency = 0.1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12,
						Font = Enum.Font.GothamBold,
						TextColor3 = a.Theme[theme.Theme or 'Dark']['Text Color'],
						BackgroundTransparency = 1,
						RichText = true,
						Size = UDim2.new(1, 0, 0, math.floor(14)),
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
					b[1]().twSafe({
						v = hg,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = a.Theme[theme.Theme or 'Dark']['Background Function Transparency Moved']}
					}):Play()
				end)
				hg.MouseLeave:Connect(function()
					b[1]().twSafe({
						v = hg,
						t = 0.15,
						s = "Linear",
						d = "InOut",
						g = {BackgroundTransparency = a.Theme[theme.Theme or 'Dark']['Background Function Transparency']}
					}):Play()
				end)
			end
			hg.TextDesc.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				hg.TextDesc.Size = UDim2.new(1, 0, 0, hg.TextDesc.UIListLayout.AbsoluteContentSize.Y + 12)
				hg.Size = UDim2.new(1, 0, 0, hg.TextDesc.UIListLayout.AbsoluteContentSize.Y + 12)
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
		local cachedMouse
		function x.jc(c, p)
			if not cachedMouse then
				cachedMouse = LocalPlayer:GetMouse()
			end
			local Mouse = cachedMouse
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
				Image = "rbxassetid://106471194043211",
				ImageTransparency = 0.9,
				ImageColor3 = Color3.fromRGB(80, 80, 80),
				ZIndex = 10
			})
			local Size = math.max(c.AbsoluteSize.X, c.AbsoluteSize.Y) * 1.5
			local expandTween = Services.TweenService:Create(ClickButtonCircle, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, Size, 0, Size),
				Position = UDim2.new(0.5, -Size/2, 0.5, -Size/2)
			})
			expandTween.Completed:Connect(function()
				for i = 1, 10 do
					ClickButtonCircle.ImageTransparency = ClickButtonCircle.ImageTransparency + 0.01
					task.wait(0.05)
				end
				ClickButtonCircle:Destroy()
			end)
			expandTween:Play()
		end
		cachedHelpers = x
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
		local f, g, CloseBtn, MinBtn, patab, of, scl, KeyCloseUI, isopen = self[1]().n, {}, nil, nil, nil, false ,nil, op.Keybind or Enum.KeyCode.RightControl, false
		local currentSelectedTab = nil
		local currentChooseFrame = nil
		assert(op.Title, "Window - Missing Title")
		assert(op.Icon, "Window - Missing Icon")
		local TabWidth = op["Tab Width"] or 130
		local SizeUi = op.SizeUi or UDim2.fromOffset(580, 340)

		local ScreenGui = b[2]()

		local DropShadowHolder = f("Frame", {
			Parent = ScreenGui,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = SizeUi,
			ZIndex = 0,
			Name = "DropShadowHolder",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})

		local DropShadow = f("ImageLabel", {
			Parent = DropShadowHolder,
			Image = "",
			ImageColor3 = Color3.fromRGB(15, 15, 15),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 30, 1, 30),
			ZIndex = 0,
			Name = "DropShadow"
		})

		local fo = f("Frame", {
			Parent = DropShadowHolder,
			BorderSizePixel = 0,
			BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Background'],
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = a.Theme[op.Theme or 'Dark']['Background Transparency'],
			Name = "Main"
		}, {
			f("UICorner", {CornerRadius = UDim.new(0, 6)}),
			f("UIStroke", {Color = a.Theme[op.Theme or 'Dark']['Color Stroke'], Thickness = 1.6}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Top Bar'],
				Size = UDim2.new(1, 0, 0, 38),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Name = "TopBar"
			}, {
				f("UIPadding", {PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 8)}),
				f("TextLabel", {
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					Font = Enum.Font.GothamBold,
					TextColor3 = a.Theme[op.Theme or 'Dark']['Text Color'],
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -100, 1, 0),
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = op.Title,
					Name = "TitleLabel"
				}),
				f("TextLabel", {
					BorderSizePixel = 0,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 13,
					Font = Enum.Font.GothamBold,
					TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
					BackgroundTransparency = 1,
					TextTransparency = 0,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = op.Subtitle or "",
					Name = "SubtitleLabel"
				}),
				f("TextButton", {
					Font = Enum.Font.SourceSans,
					Text = "X",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 18,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Name = "CloseBtn"
				}, nil, function(a) CloseBtn = a end),
				f("TextButton", {
					Font = Enum.Font.SourceSans,
					Text = "-",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 18,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -34, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25),
					Name = "MinBtn"
				}, nil, function(a) MinBtn = a end),
				f("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal
				}),
			}),
			f("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.85,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, 0, 0, 38),
				Size = UDim2.new(1, 0, 0, 1),
				Name = "DividerLine"
			}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Tab Bar'],
				Position = UDim2.new(0, 9, 0, 50),
				Size = UDim2.new(0, TabWidth, 1, -59),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Name = "TabBar"
			}, {
				f("UICorner", {CornerRadius = UDim.new(0, 2)}),
				f("ScrollingFrame", {
					Active = true,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 2, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Size = UDim2.new(1, 0, 1, 0),
					ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
					ScrollBarThickness = 0,
					BackgroundTransparency = 1,
					Name = "ScrollTab"
				}, {
					f("UIListLayout", {
						Padding = UDim.new(0, 3),
						SortOrder = Enum.SortOrder.LayoutOrder
					})
				}, function(a)
					scl = a
					patab = a
				end)
			}),
			f("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0, TabWidth + 18, 0, 50),
				Size = UDim2.new(1, -(TabWidth + 9 + 18), 1, -59),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Name = "ContentArea"
			}, {
				f("UICorner", {CornerRadius = UDim.new(0, 2)}),
				f("TextLabel", {
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 26),
					Name = "PageTitle"
				}),
				f("ScrollingFrame", {
					Active = true,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(0, 1),
					Size = UDim2.new(1, 0, 1, -33),
					ScrollBarImageColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
					Position = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 2,
					BackgroundTransparency = 1,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					Name = "PageScroll"
				}, {
					f("UIListLayout", {
						Padding = UDim.new(0, 3),
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("UIPadding", {
						PaddingRight = UDim.new(0, 5)
					}),
				})
			}),
			f("TextButton", {
				AnchorPoint = Vector2.new(1,1),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0, 16, 0, 16),
				Text = "",
				ZIndex = 2
			})
		})

		local ContentArea = fo.ContentArea
		local PageScroll = ContentArea.PageScroll
		local PageTitle = ContentArea.PageTitle

		local isResizing = false
		local hasAdjustedAnchor = false
		fo.TextButton.MouseButton1Down:Connect(function()
			isResizing = true
		end)
		if not hasAdjustedAnchor then
			DropShadowHolder.AnchorPoint = Vector2.new(0, 0)
			DropShadowHolder.Position = UDim2.new(0.5, -SizeUi.X.Offset/2, 0.5, -SizeUi.Y.Offset/2)
			fo.AnchorPoint = Vector2.new(0, 0)
			fo.Position = UDim2.new(0, 0, 0, 0)
			hasAdjustedAnchor = true
		end
		Services.UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				isResizing = false
			end
		end)
		local resizeTweenInfo = TweenInfo.new(0.15)
		Services.UserInputService.InputChanged:Connect(function(input)
			if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
				local newWidth = math.floor(math.max(400, input.Position.X - DropShadowHolder.AbsolutePosition.X))
				local newHeight = math.floor(math.max(250, input.Position.Y - DropShadowHolder.AbsolutePosition.Y))
				local newSize = UDim2.new(0, newWidth, 0, newHeight)
				Services.TweenService:Create(DropShadowHolder, resizeTweenInfo, {Size = newSize}):Play()
			end
		end)

		CloseBtn.MouseMoved:Connect(function()
			b[1]().twSafe({v = CloseBtn, t = 0.15, s = "Linear", d = "Out", g = {TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']}}):Play()
		end)
		CloseBtn.MouseLeave:Connect(function()
			b[1]().twSafe({v = CloseBtn, t = 0.15, s = "Linear", d = "Out", g = {TextColor3 = Color3.fromRGB(255, 255, 255)}}):Play()
		end)
		CloseBtn.MouseButton1Click:Connect(function()
			b[1]().jc(CloseBtn, fo.TopBar)
			b[1]().dialog(fo,
				'Do you want to <font color="#ff0000"><b>close?</b></font>',
				'This UI will close immediately and cannot be opened again until you re-execute.',
				function()
					local gf = b[1]().tw({
						v = DropShadowHolder,
						t = 0.2,
						s = "Linear",
						d = "Out",
						g = {GroupTransparency = 1}
					})
					gf:Play()
					gf.Completed:Wait()
					ScreenGui:Destroy()
				end,
				op)
		end)

		local MinimizeButton = f("ImageButton", {
			Name = "MinimizeButton",
			Parent = ScreenGui,
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Background'],
			BackgroundTransparency = a.Theme[op.Theme or 'Dark']['Background Transparency'],
			BorderColor3 = Color3.fromRGB(0,0,0),
			BorderSizePixel = 0,
			Position = UDim2.new(0.1, 0, 0.1, 0),
			Size = UDim2.new(0, 50, 0, 42),
			Image = b[1]().gl(op.Icon),
			Visible = false
		}, {
			f("UICorner", {CornerRadius = UDim.new(0, 6)}),
			f("UIStroke", {Color = a.Theme[op.Theme or 'Dark']['Color Stroke'], Thickness = 1.2})
		})
		b[1]().lak(MinimizeButton)

		MinBtn.MouseMoved:Connect(function()
			b[1]().twSafe({v = MinBtn, t = 0.15, s = "Linear", d = "Out", g = {TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']}}):Play()
		end)
		MinBtn.MouseLeave:Connect(function()
			b[1]().twSafe({v = MinBtn, t = 0.15, s = "Linear", d = "Out", g = {TextColor3 = Color3.fromRGB(255, 255, 255)}}):Play()
		end)
		MinBtn.MouseButton1Click:Connect(function()
			b[1]().jc(MinBtn, fo.TopBar)
			DropShadowHolder.Visible = false
			MinimizeButton.Visible = true
		end)
		MinimizeButton.MouseButton1Click:Connect(function()
			b[1]().jc(MinimizeButton, MinimizeButton)
			DropShadowHolder.Visible = true
			MinimizeButton.Visible = false
		end)

		b[1]().lak(fo.TopBar, DropShadowHolder)

		local function createElementAPI(parentScroll, configSystemRef)
			local api = {}

			function api:CreateToggle(khgkgh)
				assert(khgkgh.Title, "Toggle - Missing Title")
				local Value = khgkgh.Value or false
				local Callback = khgkgh.Callback or function() end
				local par = b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, false, op)
				local click = b[1]().click(par)
				local toggle = f("Frame", {
					Parent = par,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.new(0, 80, 0.8, 0),
					Position = UDim2.new(1, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 1
				}, {
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("UIPadding", {PaddingRight = UDim.new(0, 8)}),
					f("Frame", {
						BorderSizePixel = 0,
						BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Toggle Color'],
						Size = UDim2.new(0, 28, 0, 14),
						BorderColor3 = Color3.fromRGB(0, 0, 0)
					}, {
						f("UICorner", {CornerRadius = UDim.new(1, 0)}),
						f("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Thickness = 0.5, Transparency = 0.5}),
						f("Frame", {
							BorderSizePixel = 0,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0, 10, 0, 10),
							Position = UDim2.new(0.25, 0, 0.5, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0)
						}, {
							f("UICorner", {CornerRadius = UDim.new(1, 0)}),
						})
					})
				})
				local function ToggleC(newValue)
					Value = newValue
					pcall(function() Callback(Value) end)
					if not Value then
						b[1]().twSafe({v = par.TextDesc.TextLabel, t = 0.15, s = "Linear", d = "InOut", g = {TextTransparency = 0.3}}):Play()
						b[1]().twSafe({v = toggle.Frame, t = 0.15, s = "Linear", d = "InOut", g = {BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Toggle Color']}}):Play()
						b[1]().twSafe({v = toggle.Frame.Frame, t = 0.15, s = "Linear", d = "InOut", g = {Position = UDim2.new(0.25, 0, 0.5, 0)}}):Play()
					else
						b[1]().twSafe({v = par.TextDesc.TextLabel, t = 0.15, s = "Linear", d = "InOut", g = {TextTransparency = 0}}):Play()
						b[1]().twSafe({v = toggle.Frame, t = 0.15, s = "Linear", d = "InOut", g = {BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Color Main']}}):Play()
						b[1]().twSafe({v = toggle.Frame.Frame, t = 0.15, s = "Linear", d = "InOut", g = {Position = UDim2.new(0.75, 0, 0.5, 0)}}):Play()
					end
				end
				task.defer(function() ToggleC(Value) end)
				click.MouseButton1Click:Connect(function()
					Value = not Value
					b[1]().jc(click, par)
					b[1]().flash(par, "BackgroundTransparency", a.Theme[op.Theme or 'Dark']['Background Function Transparency Moved'], 0.1)
					ToggleC(Value)
				end)
				local NewSet = {}
				function NewSet:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function NewSet:SetVisible(newVisible) par.Visible = newVisible end
				function NewSet:SetValue(newValue) ToggleC(newValue) end
				local Key = khgkgh.Key or khgkgh.Title
				configSystemRef:Register(Key, function() return Value end, function(val) ToggleC(val) end)
				return NewSet
			end

			function api:CreateButton(khgkgh)
				assert(khgkgh.Title, "Button - Missing Title")
				local par, Callback = b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, false, op), khgkgh.Callback or function() end
				par.TextDesc.TextLabel.TextTransparency = 0
				local button = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0, 80, 0.8, 0),
					BorderSizePixel = 0
				}, {
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("UIPadding", {PaddingRight = UDim.new(0, 8)}),
					f("ImageLabel", {
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0, 18, 0, 18),
						Image = "rbxassetid://16932740082",
						ImageColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
					})
				})
				local click = b[1]().click(par)
				click.MouseButton1Click:Connect(function()
					b[1]().jc(click, par)
					b[1]().flash(par, "BackgroundTransparency", a.Theme[op.Theme or 'Dark']['Background Function Transparency Moved'], 0.1)
					pcall(Callback)
				end)
				local NewSet = {}
				function NewSet:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function NewSet:SetVisible(newVisible) par.Visible = newVisible end
				return NewSet
			end

			function api:CreateLabel(khgkgh)
				assert(khgkgh.Title, "Label - Missing Title")
				local par = b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, true, op)
				par.TextDesc.TextLabel.TextTransparency = 0
				local NewSet = {}
				function NewSet:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function NewSet:SetVisible(newVisible) par.Visible = newVisible end
				return NewSet
			end

			function api:CreateSlider(khgkgh)
				assert(khgkgh.Title, "Slider - Missing Title")
				local par, Callback, Value, Min, Max, DecimalPlaces =
					b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, true, op),
					khgkgh.Callback or function() end,
					khgkgh.Value or khgkgh.Max / 2,
					khgkgh.Min or 0,
					khgkgh.Max or 100,
					khgkgh.DecimalPlaces or 0
				par.TextDesc.TextLabel.TextTransparency = 0
				par.TextDesc.UIPadding.PaddingRight = UDim.new(0, 200)
				local slider = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 190,0.8, 0),
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0, 8)}),
					f("UIListLayout", {
						Padding = UDim.new(0, 6),
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
						Size = UDim2.new(0, 32, 0, 20),
						Font = Enum.Font.GothamBold,
						PlaceholderColor3 = Color3.fromRGB(178,178,178),
						Text = tostring(Value),
						TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
						TextSize = 11,
						TextXAlignment = Enum.TextXAlignment.Center,
						ClipsDescendants = true
					}, {
						f("UICorner", {CornerRadius = UDim.new(0, 3)}),
						f("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Thickness = 0.5, Transparency = 0.5})
					}),
					f("CanvasGroup", {
						BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Slider Color'],
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(0, 140, 0, 6),
						Name = "Frame"
					}, {
						f("UICorner", {CornerRadius = UDim.new(1,0)}),
						f("Frame", {
							BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(0.5, 0, 1, 0)
						}, {
							f("UICorner", {CornerRadius = UDim.new(1,0)}),
							f("Frame", {
								AnchorPoint = Vector2.new(1, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderSizePixel = 0,
								Position = UDim2.new(1, 0, 0.5, 0),
								Size = UDim2.new(0, 10, 0, 10),
							}, {
								f("UICorner", {CornerRadius = UDim.new(1, 0)}),
								f("UIStroke", {Color = a.Theme[op.Theme or 'Dark']['Color Main'], Thickness = 1})
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
					b[1]().twSafe({
						v = slider.Frame.Frame,
						t = 0.3,
						s = "Quad",
						d = "Out",
						g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
					}):Play()
					slider.TextBox.Text = tostring(value)
					pcall(function() Callback(value) end)
				end
				task.defer(function() updateSlider(Value or 0) end)
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
				Services.UserInputService.InputChanged:Connect(function(input)
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						move(input)
					end
				end)
				local NewSet = {}
				function NewSet:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function NewSet:SetVisible(newVisible) par.Visible = newVisible end
				function NewSet:SetValue(newValue) updateSlider(newValue) end
				local Key = khgkgh.Key or khgkgh.Title
				configSystemRef:Register(Key, function() return Value end, function(val) Value = val; updateSlider(val) end)
				return NewSet
			end

			function api:CreateTextbox(khgkgh)
				assert(khgkgh.Title, "TextBox - Missing Title")
				local par, Callback, Placeholder, Value, ClearTextOnFocus =
					b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, false, op),
					khgkgh.Callback or function() end,
					khgkgh.Placeholder or "Enter text...",
					khgkgh.Value or "",
					khgkgh.ClearTextOnFocus or false
				par.TextDesc.TextLabel.TextTransparency = 0
				par.TextDesc.UIPadding.PaddingRight = UDim.new(0, 200)
				local textbox = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 180, 0.8, 0)
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0, 8)}),
					f("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center
					}),
					f("Frame", {
						BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Textbox Color'],
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0, 22)
					}, {
						f("UICorner", {CornerRadius = UDim.new(0, 4)}),
						f("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Thickness = 0.5, Transparency = 0.5}),
						f("TextBox", {
							Active = true,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							CursorPosition = -1,
							Size = UDim2.new(1, 0, 1, 0),
							Font = Enum.Font.Gotham,
							PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
							PlaceholderText = Placeholder,
							Text = Value,
							TextColor3 = Color3.fromRGB(255,255,255),
							TextSize = 11,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextTruncate = Enum.TextTruncate.AtEnd,
							ClearTextOnFocus = ClearTextOnFocus
						}, {
							f("UIPadding", {PaddingLeft = UDim.new(0, 6)})
						})
					}),
				})
				local tb = textbox.Frame.TextBox
				tb.FocusLost:Connect(function()
					if #tb.Text > 0 then
						pcall(Callback, tb.Text)
					end
				end)
				task.defer(function()
					if Value and #Value > 0 then
						pcall(Callback, Value)
					end
				end)
				local NewSet = {}
				function NewSet:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function NewSet:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function NewSet:SetVisible(newVisible) par.Visible = newVisible end
				function NewSet:SetValue(newValue) tb.Text = newValue end
				local Key = khgkgh.Key or khgkgh.Title
				configSystemRef:Register(Key,
					function() return tb.Text end,
					function(val) tb.Text = val; pcall(function() Callback(val) end) end
				)
				return NewSet
			end

			function api:CreateDropdown(khgkgh)
				assert(khgkgh.Title, "Dropdown - Missing Title")
				local List = khgkgh.List or khgkgh.Options or {}
				local Value = khgkgh.Value or ""
				local Multi = khgkgh.Multi or false
				local Callback = khgkgh.Callback or function() end
				local function vd()
					if type(Value) == "table" then return table.concat(Value, ", ") else return Value end
				end
				local par = b[1]().background(parentScroll, khgkgh.Title, khgkgh.Desc, false, op)
				local dropdown = f("Frame", {
					Parent = par,
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0,0.5, 0),
					Size = UDim2.new(0, 120, 1, 0)
				}, {
					f("UIPadding", {PaddingRight = UDim.new(0, 8)}),
					f("Frame", {
						AnchorPoint = Vector2.new(1, 0.5),
						BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Dropdown Color'],
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0, 22),
						Position = UDim2.new(1, 0, 0.5, 0)
					}, {
						f("UICorner", {CornerRadius = UDim.new(0, 4)}),
						f("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Thickness = 0.5, Transparency = 0.5}),
						f("UIPadding", {PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 4)}),
						f("ImageLabel", {
							AnchorPoint = Vector2.new(1, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Position = UDim2.new(1, 0, 0.5, 0),
							Size = UDim2.new(0, 12, 0, 12),
							Image = "rbxassetid://14928415132",
							ImageColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
						}),
						f("TextLabel", {
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(1, -18, 1, 0),
							Font = Enum.Font.Gotham,
							Text = vd(),
							TextColor3 = Color3.fromRGB(255,255,255),
							TextSize = 11,
							TextXAlignment = Enum.TextXAlignment.Left,
							Name = "SelectedText"
						})
					})
				})
				local dropdownselect = f("Frame", {
					Parent = ScreenGui,
					BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Dropdown Select Background'],
					BorderColor3 = Color3.fromRGB(0,0,0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(0, 160, 0, 0),
					ClipsDescendants = true,
					ZIndex = 100
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 4)}),
					f("UIStroke", {Color = a.Theme[op.Theme or 'Dark']['Color Main'], Thickness = 0.8, Transparency = 0.5}),
					f("UIPadding", {PaddingBottom = UDim.new(0, 4), PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3)}),
					f("ScrollingFrame", {
						Active = true,
						BackgroundColor3 = Color3.fromRGB(255,255,255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, 0),
						ClipsDescendants = true,
						CanvasSize = UDim2.new(0, 0, 0, 0),
						ScrollBarImageColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
						ScrollBarThickness = 2,
						Name = "ItemList"
					}, {
						f("UIListLayout", {Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder}),
						f("UIPadding", {PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2)})
					})
				})
				local isopen = false
				local click = b[1]().click(par)
				local function opendropdown()
					local viewportSize = workspace.CurrentCamera.ViewportSize
					local targetX = dropdown.Frame.AbsolutePosition.X + dropdown.Frame.AbsoluteSize.X - 160
					local targetY = dropdown.Frame.AbsolutePosition.Y + dropdown.Frame.AbsoluteSize.Y + 2
					if targetX < 5 then targetX = 5 end
					if targetX + 160 > viewportSize.X - 5 then targetX = viewportSize.X - 165 end
					if targetY < 5 then targetY = 5 end
					local maxHeight = math.min(160, viewportSize.Y - targetY - 10)
					dropdownselect.Position = UDim2.new(0, targetX, 0, targetY)
					local contentHeight = dropdownselect.ItemList.UIListLayout.AbsoluteContentSize.Y + 10
					local finalHeight = math.min(contentHeight, maxHeight)
					b[1]().twSafe({
						v = dropdownselect,
						t = 0.15,
						s = "Quad",
						d = "Out",
						g = {Size = UDim2.new(0, 160, 0, finalHeight)}
					}):Play()
					dropdownselect.ItemList.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
				end
				local function closedropdown()
					b[1]().twSafe({
						v = dropdownselect,
						t = 0.12,
						s = "Quad",
						d = "In",
						g = {Size = UDim2.new(0, 160, 0, 0)}
					}):Play()
				end
				Services.UserInputService.InputBegan:Connect(function(A)
					if not isopen then return end
					if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
						local B, C = dropdownselect.AbsolutePosition, dropdownselect.AbsoluteSize
						local M = LocalPlayer:GetMouse()
						if M.X < B.X or M.X > B.X + C.X or M.Y < B.Y or M.Y > B.Y + C.Y then
							isopen = false
							closedropdown()
						end
					end
				end)
				click.MouseButton1Click:Connect(function()
					b[1]().jc(click, par)
					isopen = not isopen
					if not isopen then closedropdown() else opendropdown() end
				end)
				local itemslist = {}
				local selectedValues = {}
				function itemslist:Add(t)
					local item = f("Frame", {
						Parent = dropdownselect.ItemList,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						BackgroundTransparency = 0.5,
						BorderColor3 = Color3.fromRGB(0,0,0),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Size = UDim2.new(1, 0, 0, 22),
					}, {
						f("UICorner", {CornerRadius = UDim.new(0, 3)}),
						f("UIPadding", {PaddingLeft = UDim.new(0, 6)}),
						f("TextLabel", {
							BackgroundColor3 = Color3.fromRGB(255,255,255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0,0,0),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 1, 0),
							Font = Enum.Font.Gotham,
							Text = t,
							TextColor3 = Color3.fromRGB(220, 220, 220),
							TextSize = 11,
							TextXAlignment = Enum.TextXAlignment.Left
						})
					})
					local clickitem = b[1]().click(item)
					clickitem.MouseMoved:Connect(function()
						b[1]().twSafe({v = item, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0.2}}):Play()
					end)
					clickitem.MouseLeave:Connect(function()
						b[1]().twSafe({v = item, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0.5}}):Play()
					end)
					clickitem.MouseButton1Click:Connect(function()
						b[1]().jc(clickitem, item)
						if Multi then
							if selectedValues[t] then
								selectedValues[t] = nil
								b[1]().twSafe({v = item, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0.5}}):Play()
								item.TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
							else
								selectedValues[t] = true
								b[1]().twSafe({v = item, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0}}):Play()
								item.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
							end
							local sel = {}
							for k in pairs(selectedValues) do table.insert(sel, k) end
							dropdown.Frame.SelectedText.Text = #sel > 0 and table.concat(sel, ", ") or ""
							Value = sel
							pcall(function() Callback(sel) end)
						else
							for _, v in pairs(dropdownselect.ItemList:GetChildren()) do
								if v:IsA("Frame") then
									b[1]().twSafe({v = v, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0.5}}):Play()
									v.TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
								end
							end
							b[1]().twSafe({v = item, t = 0.1, s = "Linear", d = "Out", g = {BackgroundTransparency = 0}}):Play()
							item.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
							Value = t
							dropdown.Frame.SelectedText.Text = t
							pcall(function() Callback(t) end)
							isopen = false
							closedropdown()
						end
					end)
					task.defer(function()
						if Multi and type(Value) == "table" then
							for _, v in ipairs(Value) do
								if v == t then
									selectedValues[t] = true
									item.BackgroundTransparency = 0
									item.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
								end
							end
						elseif not Multi and t == Value then
							item.BackgroundTransparency = 0
							item.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
						end
					end)
				end
				for _, v in ipairs(List) do itemslist:Add(v) end
				function itemslist:SetTitle(newTitle) par.TextDesc.TextLabel.Text = newTitle end
				function itemslist:SetDesc(newDesc)
					local descLabel = par.TextDesc:FindFirstChild("Desc")
					if descLabel then descLabel.Text = newDesc else b[1]().desc(par.TextDesc, newDesc, op) end
				end
				function itemslist:SetVisible(newVisible) par.Visible = newVisible end
				function itemslist:SetValue(newValue)
					if Multi then
						selectedValues = {}
						if type(newValue) == "table" then
							for _, v in ipairs(newValue) do selectedValues[v] = true end
						end
						for _, child in ipairs(dropdownselect.ItemList:GetChildren()) do
							if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
								local txt = child.TextLabel.Text
								if selectedValues[txt] then
									child.BackgroundTransparency = 0
									child.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
								else
									child.BackgroundTransparency = 0.5
									child.TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
								end
							end
						end
						local sel = {}
						for k in pairs(selectedValues) do table.insert(sel, k) end
						dropdown.Frame.SelectedText.Text = #sel > 0 and table.concat(sel, ", ") or ""
						Value = sel
						pcall(function() Callback(sel) end)
					else
						Value = newValue or ""
						for _, child in ipairs(dropdownselect.ItemList:GetChildren()) do
							if child:IsA("Frame") and child:FindFirstChild("TextLabel") then
								if child.TextLabel.Text == newValue then
									child.BackgroundTransparency = 0
									child.TextLabel.TextColor3 = a.Theme[op.Theme or 'Dark']['Color Main']
								else
									child.BackgroundTransparency = 0.5
									child.TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
								end
							end
						end
						dropdown.Frame.SelectedText.Text = Value or ""
						pcall(function() Callback(Value) end)
					end
				end
				local Key = khgkgh.Key or khgkgh.Title
				configSystemRef:Register(Key,
					function()
						if Multi then
							local list = {}
							for k in pairs(selectedValues) do table.insert(list, k) end
							return list
						else
							return Value
						end
					end,
					function(val) itemslist:SetValue(val) end
				)
				return itemslist
			end

			function api:CreateSection(khgkgh)
				assert(khgkgh.Title, "Section - Missing Title")
				local isExpanded = khgkgh.Expanded ~= nil and khgkgh.Expanded or true

				local Section = f("Frame", {
					Parent = parentScroll,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(1, 0, 0, 30),
					Name = "Section"
				})

				local SectionHeader = f("Frame", {
					Parent = Section,
					BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Section Header'],
					BackgroundTransparency = a.Theme[op.Theme or 'Dark']['Section Header Transparency'],
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 28),
					Name = "SectionHeader"
				}, {
					f("UICorner", {CornerRadius = UDim.new(0, 4)}),
					f("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}),
					f("UIListLayout", {
						Padding = UDim.new(0, 6),
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("ImageLabel", {
						Name = "ArrowIcon",
						Image = "rbxassetid://125609963478878",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(0, 14, 0, 14),
						Rotation = isExpanded and -90 or 0,
						ImageColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
						LayoutOrder = 1
					}),
					f("TextLabel", {
						Name = "SectionTitle",
						Font = Enum.Font.GothamBold,
						Text = khgkgh.Title,
						TextColor3 = Color3.fromRGB(230, 230, 230),
						TextSize = 12,
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.new(0, 0, 1, 0),
						LayoutOrder = 2
					}),
					f("TextButton", {
						Name = "SectionClick",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, 0),
						Text = "",
						Font = Enum.Font.SourceSans,
						ZIndex = 2
					})
				})

				local GradientDivider = f("Frame", {
					Parent = Section,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.new(0.5, 0, 0, 30),
					Size = UDim2.new(1, 0, 0, 1),
					Name = "GradientDivider"
				}, {
					f("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
							ColorSequenceKeypoint.new(0.5, a.Theme[op.Theme or 'Dark']['Color Main']),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
						}
					})
				})

				local SectionContent = f("Frame", {
					Parent = Section,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 0, 33),
					Size = UDim2.new(1, 0, 0, 0),
					Name = "SectionContent"
				}, {
					f("UIListLayout", {
						Padding = UDim.new(0, 3),
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					f("UIPadding", {PaddingTop = UDim.new(0, 3)})
				})

				local ArrowIcon = SectionHeader.ArrowIcon
				local SectionClick = SectionHeader.SectionClick

				SectionHeader.MouseMoved:Connect(function()
					b[1]().twSafe({
						v = SectionHeader,
						t = 0.1,
						s = "Linear",
						d = "Out",
						g = {BackgroundTransparency = 0.88}
					}):Play()
				end)
				SectionHeader.MouseLeave:Connect(function()
					b[1]().twSafe({
						v = SectionHeader,
						t = 0.1,
						s = "Linear",
						d = "Out",
						g = {BackgroundTransparency = a.Theme[op.Theme or 'Dark']['Section Header Transparency']}
					}):Play()
				end)

				local function updateSectionSize()
					local contentHeight = SectionContent.UIListLayout.AbsoluteContentSize.Y + 3
					if isExpanded then
						b[1]().twSafe({
							v = Section,
							t = 0.25,
							s = "Quad",
							d = "Out",
							g = {Size = UDim2.new(1, 0, 0, 33 + contentHeight)}
						}):Play()
						b[1]().twSafe({
							v = SectionContent,
							t = 0.25,
							s = "Quad",
							d = "Out",
							g = {Size = UDim2.new(1, 0, 0, contentHeight)}
						}):Play()
					else
						b[1]().twSafe({
							v = Section,
							t = 0.25,
							s = "Quad",
							d = "Out",
							g = {Size = UDim2.new(1, 0, 0, 30)}
						}):Play()
						b[1]().twSafe({
							v = SectionContent,
							t = 0.25,
							s = "Quad",
							d = "Out",
							g = {Size = UDim2.new(1, 0, 0, 0)}
						}):Play()
					end
				end

				SectionContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSectionSize)

				local function toggleSection()
					isExpanded = not isExpanded
					b[1]().twSafe({
						v = ArrowIcon,
						t = 0.25,
						s = "Quad",
						d = "Out",
						g = {Rotation = isExpanded and -90 or 0}
					}):Play()
					updateSectionSize()
				end

				SectionClick.MouseButton1Click:Connect(function()
					b[1]().jc(SectionClick, SectionHeader)
					toggleSection()
				end)

				local sectionAPI = createElementAPI(SectionContent, configSystemRef)

				local NewSet = {}
				for k, v in pairs(sectionAPI) do
					NewSet[k] = v
				end
				function NewSet:SetTitle(newTitle) SectionHeader.SectionTitle.Text = newTitle end
				function NewSet:SetVisible(newVisible) Section.Visible = newVisible end
				function NewSet:Toggle() toggleSection() end
				function NewSet:Expand() if not isExpanded then toggleSection() end end
				function NewSet:Collapse() if isExpanded then toggleSection() end end

				task.defer(function()
					updateSectionSize()
				end)

				return NewSet
			end

			return api
		end

		function g:CreateTab(gfjd)
			assert(gfjd.Title, "Tab - Missing Title")
			local tabIcon = gfjd.Icon or nil
			local CountTab = #patab:GetChildren() - 1
			if CountTab < 0 then CountTab = 0 end

			local TabPage = f("ScrollingFrame", {
				Parent = PageScroll,
				ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
				ScrollBarThickness = 0,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				Name = "TabPage_" .. gfjd.Title,
				Visible = CountTab == 0,
				LayoutOrder = CountTab
			}, {
				f("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder
				})
			})

			local Tab = f("Frame", {
				Parent = patab,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = CountTab == 0 and 0.92 or 0.999,
				BorderSizePixel = 0,
				LayoutOrder = CountTab,
				Size = UDim2.new(1, 0, 0, 30),
				Name = "Tab"
			}, {
				f("UICorner", {CornerRadius = UDim.new(0, 4)}),
				f("TextLabel", {
					Font = Enum.Font.GothamBold,
					Text = gfjd.Title,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, -30, 1, 0),
					Position = UDim2.new(0, 30, 0, 0),
					Name = "TabName"
				}),
				f("ImageLabel", {
					Image = b[1]().gl(tabIcon),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 8, 0, 7),
					Size = UDim2.new(0, 16, 0, 16),
					Name = "TabIcon",
					ImageColor3 = Color3.fromRGB(255, 255, 255)
				}),
				f("TextButton", {
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Name = "TabButton"
				})
			})

			local ChooseFrame
			if CountTab == 0 then
				PageTitle.Text = gfjd.Title
				ChooseFrame = f("Frame", {
					Parent = Tab,
					BackgroundColor3 = a.Theme[op.Theme or 'Dark']['Color Main'],
					BorderSizePixel = 0,
					Position = UDim2.new(0, 2, 0, 9),
					Size = UDim2.new(0, 1, 0, 12),
					Name = "ChooseFrame"
				}, {
					f("UICorner", {CornerRadius = UDim.new(1, 0)})
				})
				currentChooseFrame = ChooseFrame
			end

			Tab.TabButton.MouseButton1Click:Connect(function()
				b[1]().jc(Tab.TabButton, Tab)
				if currentChooseFrame and Tab.LayoutOrder ~= (currentSelectedTab and currentSelectedTab.LayoutOrder or 0) then
					for _, TabFrame in pairs(patab:GetChildren()) do
						if TabFrame:IsA("Frame") and TabFrame.Name == "Tab" then
							b[1]().twSafe({
								v = TabFrame,
								t = 0.2,
								s = "Quad",
								d = "InOut",
								g = {BackgroundTransparency = 0.999}
							}):Play()
						end
					end
					b[1]().twSafe({
						v = Tab,
						t = 0.3,
						s = "Back",
						d = "InOut",
						g = {BackgroundTransparency = 0.92}
					}):Play()
					b[1]().twSafe({
						v = currentChooseFrame,
						t = 0.3,
						s = "Quad",
						d = "InOut",
						g = {Position = UDim2.new(0, 2, 0, 9 + (33 * Tab.LayoutOrder))}
					}):Play()
					for _, page in pairs(PageScroll:GetChildren()) do
						if page:IsA("ScrollingFrame") then
							page.Visible = false
						end
					end
					TabPage.Visible = true
					PageTitle.Text = gfjd.Title
					currentSelectedTab = Tab
				end
			end)

			if CountTab == 0 then
				currentSelectedTab = Tab
			end

			local Func = {}
			Func.ConfigSystem = b[3]()
			Func.ConfigSystem.ConfigName = op.Title .. "_" .. gfjd.Title

			task.defer(function()
				Func.ConfigSystem:LoadConfig()
			end)

			local elementAPI = createElementAPI(TabPage, Func.ConfigSystem)
			for k, v in pairs(elementAPI) do
				Func[k] = v
			end

			TabPage.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				TabPage.CanvasSize = UDim2.new(0, 0, 0, TabPage.UIListLayout.AbsoluteContentSize.Y + 10)
			end)

			return Func
		end

		function g:CreateDialog(hfdjgf)
			assert(hfdjgf.Title, "Dialog - Missing Title")
			return b[1]().dialog(fo,
				hfdjgf.Title,
				hfdjgf.Desc,
				hfdjgf.Callback or function() end,
				op)
		end

		function g:SetTransparency(khgkgh)
			a.Theme[op.Theme or 'Dark']['Background Transparency'] = khgkgh
			b[1]().tw({
				v = fo,
				t = 0.5,
				s = "Exponential",
				d = "Out",
				g = {BackgroundTransparency = khgkgh}
			}):Play()
		end

		local function closeopenui()
			isopen = not isopen
			if isopen then
				DropShadowHolder.Visible = false
				MinimizeButton.Visible = true
			else
				DropShadowHolder.Visible = true
				MinimizeButton.Visible = false
			end
		end

		MinimizeButton.MouseButton1Click:Connect(closeopenui)

		Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == KeyCloseUI then
				closeopenui()
			end
		end)

		scl.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			scl.CanvasSize = UDim2.new(0, 0, 0, scl.UIListLayout.AbsoluteContentSize.Y + 10)
		end)

		PageScroll.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageScroll.UIListLayout.AbsoluteContentSize.Y + 10)
		end)

		return g
	end,
}
