
--[[
    Professional UI Library v2.0
    Enhanced with:
      - UIStroke borders on all elements
      - UICorner rounding everywhere
      - UIGradient depth / shimmer
      - Tooltip system (hover tooltips)
      - Notification / toast system
      - Theme system (Dark, Midnight, Crimson, Slate)
      - Smooth spring-easing animations
      - New widgets: ProgressBar, Badge, Separator, RadioGroup, NumberStepper,
        ContextMenu, SearchDropdown, StatusDot, Spinner, ImageDisplay, Divider,
        PillBadge, HexColorInput
]]

------------------------------------------------------------------------
-- CONFIG / OPTIONS
------------------------------------------------------------------------

local ui_options = {
    main_color        = Color3.fromRGB(150, 1, 1),
    accent_color      = Color3.fromRGB(200, 30, 30),
    min_size          = Vector2.new(420, 320),
    toggle_key        = Enum.KeyCode.C,
    can_resize        = true,
    window_transparency = 0.08,
    corner_radius     = UDim.new(0, 6),
    stroke_thickness  = 1.2,
    stroke_color      = Color3.fromRGB(60, 60, 70),
    font              = Enum.Font.GothamSemibold,
    font_small        = Enum.Font.Gotham,
    font_bold         = Enum.Font.GothamBold,
    tween_time        = 0.18,
    notification_side = "Right",  -- "Left" or "Right"
}

------------------------------------------------------------------------
-- THEME PRESETS
------------------------------------------------------------------------

local Themes = {
    Dark = {
        main_color   = Color3.fromRGB(150, 1, 1),
        bg           = Color3.fromRGB(18, 18, 22),
        surface      = Color3.fromRGB(26, 26, 32),
        surface2     = Color3.fromRGB(34, 34, 42),
        border       = Color3.fromRGB(55, 55, 68),
        text         = Color3.fromRGB(230, 230, 240),
        text_dim     = Color3.fromRGB(140, 140, 155),
        success      = Color3.fromRGB(52, 199, 89),
        warning      = Color3.fromRGB(255, 159, 10),
        danger       = Color3.fromRGB(255, 59, 48),
        info         = Color3.fromRGB(10, 132, 255),
    },
    Midnight = {
        main_color   = Color3.fromRGB(88, 86, 214),
        bg           = Color3.fromRGB(10, 10, 18),
        surface      = Color3.fromRGB(16, 16, 28),
        surface2     = Color3.fromRGB(22, 22, 38),
        border       = Color3.fromRGB(45, 45, 72),
        text         = Color3.fromRGB(220, 220, 240),
        text_dim     = Color3.fromRGB(130, 130, 160),
        success      = Color3.fromRGB(52, 199, 89),
        warning      = Color3.fromRGB(255, 159, 10),
        danger       = Color3.fromRGB(255, 59, 48),
        info         = Color3.fromRGB(10, 132, 255),
    },
    Crimson = {
        main_color   = Color3.fromRGB(180, 20, 20),
        bg           = Color3.fromRGB(15, 10, 10),
        surface      = Color3.fromRGB(24, 14, 14),
        surface2     = Color3.fromRGB(32, 18, 18),
        border       = Color3.fromRGB(65, 30, 30),
        text         = Color3.fromRGB(240, 220, 220),
        text_dim     = Color3.fromRGB(160, 130, 130),
        success      = Color3.fromRGB(52, 199, 89),
        warning      = Color3.fromRGB(255, 159, 10),
        danger       = Color3.fromRGB(255, 59, 48),
        info         = Color3.fromRGB(10, 132, 255),
    },
    Slate = {
        main_color   = Color3.fromRGB(100, 180, 255),
        bg           = Color3.fromRGB(14, 16, 20),
        surface      = Color3.fromRGB(20, 24, 30),
        surface2     = Color3.fromRGB(28, 32, 40),
        border       = Color3.fromRGB(48, 56, 70),
        text         = Color3.fromRGB(225, 230, 240),
        text_dim     = Color3.fromRGB(140, 148, 165),
        success      = Color3.fromRGB(52, 199, 89),
        warning      = Color3.fromRGB(255, 159, 10),
        danger       = Color3.fromRGB(255, 59, 48),
        info         = Color3.fromRGB(10, 132, 255),
    },
}

local active_theme = Themes.Dark

------------------------------------------------------------------------
-- SERVICES
------------------------------------------------------------------------

local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RS           = game:GetService("RunService")
local ps           = game:GetService("Players")
local p            = ps.LocalPlayer
local mouse        = p:GetMouse()

------------------------------------------------------------------------
-- ROOT GUI
------------------------------------------------------------------------

do
    local existing = game:GetService("CoreGui"):FindFirstChild("imgui_v2")
    if existing then existing:Destroy() end
end

local imgui = Instance.new("ScreenGui")
imgui.Name              = "imgui_v2"
imgui.ResetOnSpawn      = false
imgui.IgnoreGuiInset    = true
imgui.ZIndexBehavior    = Enum.ZIndexBehavior.Sibling
imgui.Parent            = game:GetService("CoreGui")

------------------------------------------------------------------------
-- PREFABS CONTAINER
------------------------------------------------------------------------

local Prefabs = Instance.new("Frame")
Prefabs.Name                = "Prefabs"
Prefabs.BackgroundTransparency = 1
Prefabs.Size                = UDim2.new(0, 100, 0, 100)
Prefabs.Visible             = false
Prefabs.Parent              = imgui

------------------------------------------------------------------------
-- WINDOWS CONTAINER
------------------------------------------------------------------------

local Windows = Instance.new("Frame")
Windows.Name                = "Windows"
Windows.BackgroundTransparency = 1
Windows.Size                = UDim2.new(1, 0, 1, 0)
Windows.Parent              = imgui

------------------------------------------------------------------------
-- NOTIFICATION CONTAINER
------------------------------------------------------------------------

local NotifContainer = Instance.new("Frame")
NotifContainer.Name                 = "Notifications"
NotifContainer.BackgroundTransparency = 1
NotifContainer.Size                 = UDim2.new(0, 320, 1, -20)
NotifContainer.Position             = UDim2.new(1, -340, 0, 10)
NotifContainer.ZIndex               = 9000
NotifContainer.Parent               = imgui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Parent        = NotifContainer
NotifLayout.SortOrder     = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding       = UDim.new(0, 8)

------------------------------------------------------------------------
-- TOOLTIP LAYER
------------------------------------------------------------------------

local TooltipFrame = Instance.new("Frame")
TooltipFrame.Name                 = "Tooltip"
TooltipFrame.BackgroundColor3     = active_theme.surface2
TooltipFrame.BorderSizePixel      = 0
TooltipFrame.Size                 = UDim2.new(0, 10, 0, 26)
TooltipFrame.ZIndex               = 9999
TooltipFrame.Visible              = false
TooltipFrame.Parent               = imgui

local TooltipCorner = Instance.new("UICorner")
TooltipCorner.CornerRadius = UDim.new(0, 5)
TooltipCorner.Parent = TooltipFrame

local TooltipStroke = Instance.new("UIStroke")
TooltipStroke.Color     = active_theme.border
TooltipStroke.Thickness = 1
TooltipStroke.Parent    = TooltipFrame

local TooltipPadding = Instance.new("UIPadding")
TooltipPadding.PaddingLeft   = UDim.new(0, 10)
TooltipPadding.PaddingRight  = UDim.new(0, 10)
TooltipPadding.PaddingTop    = UDim.new(0, 4)
TooltipPadding.PaddingBottom = UDim.new(0, 4)
TooltipPadding.Parent        = TooltipFrame

local TooltipLabel = Instance.new("TextLabel")
TooltipLabel.Name                 = "Text"
TooltipLabel.BackgroundTransparency = 1
TooltipLabel.Size                 = UDim2.new(1, 0, 1, 0)
TooltipLabel.ZIndex               = 10000
TooltipLabel.Font                 = ui_options.font_small
TooltipLabel.Text                 = ""
TooltipLabel.TextColor3           = active_theme.text
TooltipLabel.TextSize             = 13
TooltipLabel.TextXAlignment       = Enum.TextXAlignment.Left
TooltipLabel.Parent               = TooltipFrame

------------------------------------------------------------------------
-- HELPER UTILITIES
------------------------------------------------------------------------

local function Tween(obj, props, duration, style, dir)
    duration = duration or ui_options.tween_time
    style    = style    or Enum.EasingStyle.Quart
    dir      = dir      or Enum.EasingDirection.Out
    local info = TweenInfo.new(duration, style, dir)
    TweenService:Create(obj, info, props):Play()
end

local function SpringTween(obj, props, duration)
    local info = TweenInfo.new(duration or 0.35, Enum.EasingStyle.Spring, Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local function gMouse()
    local loc = UIS:GetMouseLocation()
    return Vector2.new(loc.X, loc.Y)
end

local function gNameLen(obj)
    return obj.TextBounds.X + 15
end

local function AddCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius or ui_options.corner_radius
    c.Parent = parent
    return c
end

local function AddStroke(parent, color, thickness, trans)
    local s = Instance.new("UIStroke")
    s.Color       = color     or ui_options.stroke_color
    s.Thickness   = thickness or ui_options.stroke_thickness
    s.Transparency = trans    or 0
    s.Parent      = parent
    return s
end

local function AddPadding(parent, px)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft   = UDim.new(0, px)
    pad.PaddingRight  = UDim.new(0, px)
    pad.PaddingTop    = UDim.new(0, px)
    pad.PaddingBottom = UDim.new(0, px)
    pad.Parent = parent
    return pad
end

local function AddGradient(parent, colorSequence, rotation)
    local g = Instance.new("UIGradient")
    g.Color    = colorSequence or ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)),
    })
    g.Rotation = rotation or 90
    g.Parent   = parent
    return g
end

local function ripple(button, x, y)
    task.spawn(function()
        button.ClipsDescendants = true
        local circle = Instance.new("Frame")
        circle.BackgroundColor3    = Color3.fromRGB(255, 255, 255)
        circle.BackgroundTransparency = 0.75
        circle.BorderSizePixel     = 0
        circle.ZIndex              = button.ZIndex + 50
        circle.Parent              = button
        AddCorner(circle, UDim.new(1, 0))

        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
        local relX = x - circle.AbsolutePosition.X
        local relY = y - circle.AbsolutePosition.Y
        circle.Position = UDim2.new(0, relX, 0, relY)
        circle.Size     = UDim2.new(0, 0, 0, 0)

        Tween(circle, {
            Size     = UDim2.new(0, size, 0, size),
            Position = UDim2.new(0, relX - size / 2, 0, relY - size / 2),
            BackgroundTransparency = 1,
        }, 0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        task.wait(0.55)
        circle:Destroy()
    end)
end

------------------------------------------------------------------------
-- TOOLTIP SYSTEM
------------------------------------------------------------------------

local tooltipConn = nil

local function attachTooltip(element, text)
    if not text or text == "" then return end

    element.MouseEnter:Connect(function()
        -- Always disconnect any previous connection before creating a new one
        if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end

        TooltipLabel.Text  = text
        local ts           = game:GetService("TextService")
        local sz           = ts:GetTextSize(text, 13, ui_options.font_small, Vector2.new(9999, 9999))
        TooltipFrame.Size  = UDim2.new(0, sz.X + 22, 0, 28)
        TooltipFrame.Visible = true

        tooltipConn = RS.RenderStepped:Connect(function()
            local mp = gMouse()
            TooltipFrame.Position = UDim2.new(0, mp.X + 14, 0, mp.Y + 6)
        end)
    end)

    element.MouseLeave:Connect(function()
        TooltipFrame.Visible = false
        if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end
    end)

    -- Also clean up if the element is destroyed mid-hover
    element.AncestryChanged:Connect(function()
        if not element.Parent then
            TooltipFrame.Visible = false
            if tooltipConn then tooltipConn:Disconnect(); tooltipConn = nil end
        end
    end)
end

------------------------------------------------------------------------
-- NOTIFICATION SYSTEM
------------------------------------------------------------------------

local notif_count = 0

local function Notify(options)
    options = typeof(options) == "table" and options or {}
    local title    = tostring(options.title   or "Notification")
    local message  = tostring(options.message or "")
    local duration = tonumber(options.duration) or 4
    local ntype    = options.type or "info"  -- "info", "success", "warning", "danger"

    local typeColors = {
        info    = active_theme.info,
        success = active_theme.success,
        warning = active_theme.warning,
        danger  = active_theme.danger,
    }
    local accentColor = typeColors[ntype] or active_theme.info

    notif_count = notif_count + 1
    local ORDER = notif_count

    -- Outer card
    local card = Instance.new("Frame")
    card.Name                 = "Notif_" .. ORDER
    card.BackgroundColor3     = active_theme.surface
    card.BorderSizePixel      = 0
    card.Size                 = UDim2.new(1, 0, 0, 72)
    card.ClipsDescendants     = true
    card.ZIndex               = 9100
    card.LayoutOrder          = ORDER
    card.BackgroundTransparency = 1
    card.Parent               = NotifContainer
    AddCorner(card, UDim.new(0, 8))
    AddStroke(card, active_theme.border, 1)

    -- Accent bar
    local accentBar = Instance.new("Frame")
    accentBar.Name             = "Accent"
    accentBar.BackgroundColor3 = accentColor
    accentBar.BorderSizePixel  = 0
    accentBar.Size             = UDim2.new(0, 3, 1, 0)
    accentBar.ZIndex           = 9101
    accentBar.Parent           = card
    AddCorner(accentBar, UDim.new(0, 3))

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position   = UDim2.new(0, 14, 0, 10)
    titleLabel.Size       = UDim2.new(1, -20, 0, 18)
    titleLabel.ZIndex     = 9102
    titleLabel.Font       = ui_options.font_bold
    titleLabel.Text       = title
    titleLabel.TextColor3 = active_theme.text
    titleLabel.TextSize   = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent     = card

    -- Message
    local msgLabel = Instance.new("TextLabel")
    msgLabel.BackgroundTransparency = 1
    msgLabel.Position    = UDim2.new(0, 14, 0, 30)
    msgLabel.Size        = UDim2.new(1, -20, 0, 28)
    msgLabel.ZIndex      = 9102
    msgLabel.Font        = ui_options.font_small
    msgLabel.Text        = message
    msgLabel.TextColor3  = active_theme.text_dim
    msgLabel.TextSize    = 12
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextWrapped = true
    msgLabel.Parent      = card

    -- Progress bar
    local progBg = Instance.new("Frame")
    progBg.BackgroundColor3 = active_theme.surface2
    progBg.BorderSizePixel  = 0
    progBg.Position         = UDim2.new(0, 0, 1, -3)
    progBg.Size             = UDim2.new(1, 0, 0, 3)
    progBg.ZIndex           = 9103
    progBg.Parent           = card

    local progFill = Instance.new("Frame")
    progFill.BackgroundColor3 = accentColor
    progFill.BorderSizePixel  = 0
    progFill.Size             = UDim2.new(1, 0, 1, 0)
    progFill.ZIndex           = 9104
    progFill.Parent           = progBg
    AddCorner(progFill, UDim.new(0, 2))

    -- Slide in
    card.Position = UDim2.new(1, 20, 0, 0)
    Tween(card, {BackgroundTransparency = 0, Position = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Quart)

    -- Progress countdown
    Tween(progFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)

    task.delay(duration, function()
        Tween(card, {BackgroundTransparency = 1, Position = UDim2.new(1, 20, 0, 0)}, 0.3, Enum.EasingStyle.Quart)
        task.wait(0.35)
        card:Destroy()
    end)
end

------------------------------------------------------------------------
-- BADGE / PILL PREFAB BUILDER
------------------------------------------------------------------------

local function MakeBadge(text, color, parent, zindex)
    local badge = Instance.new("Frame")
    badge.BackgroundColor3 = color or active_theme.info
    badge.BorderSizePixel  = 0
    badge.ZIndex           = zindex or 10
    AddCorner(badge, UDim.new(1, 0))

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size        = UDim2.new(1, 0, 1, 0)
    lbl.ZIndex      = (zindex or 10) + 1
    lbl.Font        = ui_options.font_bold
    lbl.Text        = tostring(text)
    lbl.TextColor3  = Color3.fromRGB(255, 255, 255)
    lbl.TextSize    = 11
    lbl.Parent      = badge

    local ts = game:GetService("TextService")
    local sz = ts:GetTextSize(tostring(text), 11, ui_options.font_bold, Vector2.new(9999, 9999))
    badge.Size = UDim2.new(0, sz.X + 14, 0, 18)

    if parent then badge.Parent = parent end
    return badge, lbl
end

------------------------------------------------------------------------
-- SEPARATOR PREFAB
------------------------------------------------------------------------

local function MakeSeparator(parent, zindex)
    local sep = Instance.new("Frame")
    sep.BackgroundTransparency = 1
    sep.Size        = UDim2.new(1, 0, 0, 12)
    sep.BorderSizePixel = 0
    sep.ZIndex      = zindex or 5
    sep.Parent      = parent

    local line = Instance.new("Frame")
    line.BackgroundColor3 = active_theme.border
    line.BorderSizePixel  = 0
    line.AnchorPoint      = Vector2.new(0, 0.5)
    line.Position         = UDim2.new(0, 0, 0.5, 0)
    line.Size             = UDim2.new(1, 0, 0, 1)
    line.ZIndex           = (zindex or 5) + 1
    line.Parent           = sep

    return sep
end

------------------------------------------------------------------------
-- STATUS DOT
------------------------------------------------------------------------

local StatusColors = {
    online  = Color3.fromRGB(52, 199, 89),
    away    = Color3.fromRGB(255, 159, 10),
    busy    = Color3.fromRGB(255, 59, 48),
    offline = Color3.fromRGB(100, 100, 110),
}

local function MakeStatusDot(status, parent, zindex)
    local dot = Instance.new("Frame")
    dot.BackgroundColor3 = StatusColors[status] or StatusColors.offline
    dot.BorderSizePixel  = 0
    dot.Size             = UDim2.new(0, 10, 0, 10)
    dot.ZIndex           = zindex or 10
    dot.Parent           = parent
    AddCorner(dot, UDim.new(1, 0))

    -- Pulse for "online"
    if status == "online" then
        local pulse = Instance.new("Frame")
        pulse.BackgroundColor3     = StatusColors.online
        pulse.BackgroundTransparency = 0.5
        pulse.AnchorPoint          = Vector2.new(0.5, 0.5)
        pulse.Position             = UDim2.new(0.5, 0, 0.5, 0)
        pulse.Size                 = UDim2.new(1, 0, 1, 0)
        pulse.ZIndex               = (zindex or 10) - 1
        pulse.Parent               = dot
        AddCorner(pulse, UDim.new(1, 0))

        task.spawn(function()
            while dot and dot.Parent do
                Tween(pulse, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 1)
                task.wait(1)
                pulse.Size = UDim2.new(1, 0, 1, 0)
                pulse.BackgroundTransparency = 0.5
            end
        end)
    end

    return dot
end

------------------------------------------------------------------------
-- SPINNER PREFAB
------------------------------------------------------------------------

local function MakeSpinner(size, color, parent, zindex)
    size   = size  or 24
    color  = color or ui_options.main_color
    zindex = zindex or 10

    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Size   = UDim2.new(0, size, 0, size)
    container.ZIndex = zindex
    if parent then container.Parent = parent end

    local arc = Instance.new("ImageLabel")
    arc.BackgroundTransparency = 1
    arc.Size        = UDim2.new(1, 0, 1, 0)
    arc.ZIndex      = zindex + 1
    arc.Image       = "rbxassetid://4965945816" -- circle arc
    arc.ImageColor3 = color
    arc.Parent      = container

    -- Rotate spinner
    task.spawn(function()
        local rot = 0
        while arc and arc.Parent do
            rot = (rot + 5) % 360
            arc.Rotation = rot
            RS.Heartbeat:Wait()
        end
    end)

    return container
end

------------------------------------------------------------------------
-- WINDOW PREFAB (Instance definition)
------------------------------------------------------------------------

local WindowPrefab = Instance.new("Frame")
WindowPrefab.Name                 = "WindowPrefab"
WindowPrefab.BackgroundColor3     = active_theme.bg
WindowPrefab.BackgroundTransparency = ui_options.window_transparency
WindowPrefab.BorderSizePixel      = 0
WindowPrefab.ClipsDescendants     = true
WindowPrefab.Position             = UDim2.new(0, 30, 0, 30)
WindowPrefab.Size                 = UDim2.new(0, 420, 0, 320)
WindowPrefab.Active               = true
WindowPrefab.Selectable           = true
WindowPrefab.Parent               = Prefabs
AddCorner(WindowPrefab, UDim.new(0, 10))
AddStroke(WindowPrefab, active_theme.border, 1.2)

-- Subtle gradient inside window
local winGrad = Instance.new("UIGradient")
winGrad.Color  = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 28)),
})
winGrad.Rotation = 110
winGrad.Parent   = WindowPrefab

-- Titlebar
local TitleBar = Instance.new("Frame")
TitleBar.Name             = "TitleBar"
TitleBar.BackgroundColor3 = active_theme.surface
TitleBar.BorderSizePixel  = 0
TitleBar.Size             = UDim2.new(1, 0, 0, 38)
TitleBar.ZIndex           = 4
TitleBar.Parent           = WindowPrefab
AddStroke(TitleBar, active_theme.border, 1, 0)

local TitleBarGrad = Instance.new("UIGradient")
TitleBarGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 52)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38)),
})
TitleBarGrad.Rotation = 90
TitleBarGrad.Parent   = TitleBar

-- Accent line below titlebar
local AccentLine = Instance.new("Frame")
AccentLine.Name             = "AccentLine"
AccentLine.BackgroundColor3 = ui_options.main_color
AccentLine.BorderSizePixel  = 0
AccentLine.Position         = UDim2.new(0, 0, 1, -2)
AccentLine.Size             = UDim2.new(1, 0, 0, 2)
AccentLine.ZIndex           = 5
AccentLine.Parent           = TitleBar

-- Window title label
local WinTitle = Instance.new("TextLabel")
WinTitle.Name                 = "Title"
WinTitle.BackgroundTransparency = 1
WinTitle.Position             = UDim2.new(0, 42, 0, 0)
WinTitle.Size                 = UDim2.new(1, -90, 1, 0)
WinTitle.ZIndex               = 6
WinTitle.Font                 = ui_options.font_bold
WinTitle.Text                 = "Window"
WinTitle.TextColor3           = active_theme.text
WinTitle.TextSize             = 15
WinTitle.TextXAlignment       = Enum.TextXAlignment.Left
WinTitle.Parent               = TitleBar

-- Close icon dot decoration
local WinDot = Instance.new("Frame")
WinDot.Name             = "Dot"
WinDot.BackgroundColor3 = ui_options.main_color
WinDot.BorderSizePixel  = 0
WinDot.AnchorPoint      = Vector2.new(0, 0.5)
WinDot.Position         = UDim2.new(0, 14, 0.5, 0)
WinDot.Size             = UDim2.new(0, 10, 0, 10)
WinDot.ZIndex           = 6
WinDot.Parent           = TitleBar
AddCorner(WinDot, UDim.new(1, 0))

-- Toggle (minimize) button
local WinToggle = Instance.new("TextButton")
WinToggle.Name                 = "Toggle"
WinToggle.BackgroundColor3     = active_theme.surface2
WinToggle.BorderSizePixel      = 0
WinToggle.AnchorPoint          = Vector2.new(1, 0.5)
WinToggle.Position             = UDim2.new(1, -12, 0.5, 0)
WinToggle.Size                 = UDim2.new(0, 24, 0, 24)
WinToggle.ZIndex               = 7
WinToggle.Font                 = ui_options.font_bold
WinToggle.Text                 = "—"
WinToggle.TextColor3           = active_theme.text_dim
WinToggle.TextSize             = 14
WinToggle.Parent               = TitleBar
AddCorner(WinToggle, UDim.new(0, 6))
AddStroke(WinToggle, active_theme.border, 1)

-- Tab selection bar
local TabSelBar = Instance.new("Frame")
TabSelBar.Name                 = "TabSelBar"
TabSelBar.BackgroundColor3     = active_theme.surface
TabSelBar.BackgroundTransparency = 0
TabSelBar.BorderSizePixel      = 0
TabSelBar.Position             = UDim2.new(0, 0, 0, 38)
TabSelBar.Size                 = UDim2.new(1, 0, 0, 32)
TabSelBar.ZIndex               = 3
TabSelBar.Visible              = false
TabSelBar.Parent               = WindowPrefab

local TabButtonsFrame = Instance.new("ScrollingFrame")
TabButtonsFrame.Name                 = "TabButtons"
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.BorderSizePixel      = 0
TabButtonsFrame.Size                 = UDim2.new(1, -16, 1, 0)
TabButtonsFrame.Position             = UDim2.new(0, 8, 0, 0)
TabButtonsFrame.CanvasSize           = UDim2.new(0, 0, 0, 0)
TabButtonsFrame.ScrollBarThickness   = 0
TabButtonsFrame.ZIndex               = 4
TabButtonsFrame.Parent               = TabSelBar

local TabButtonsLayout = Instance.new("UIListLayout")
TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
TabButtonsLayout.SortOrder     = Enum.SortOrder.LayoutOrder
TabButtonsLayout.Padding       = UDim.new(0, 4)
TabButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabButtonsLayout.Parent        = TabButtonsFrame

local TabSelDivider = Instance.new("Frame")
TabSelDivider.BackgroundColor3 = active_theme.border
TabSelDivider.BorderSizePixel  = 0
TabSelDivider.Position         = UDim2.new(0, 0, 1, -1)
TabSelDivider.Size             = UDim2.new(1, 0, 0, 1)
TabSelDivider.ZIndex           = 4
TabSelDivider.Parent           = TabSelBar

-- Content area
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Name                 = "ContentArea"
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel      = 0
ContentArea.Position             = UDim2.new(0, 10, 0, 80)
ContentArea.Size                 = UDim2.new(1, -20, 1, -90)
ContentArea.CanvasSize           = UDim2.new(0, 0, 0, 0)
ContentArea.ScrollBarThickness   = 4
ContentArea.ScrollBarImageColor3 = active_theme.border
ContentArea.ZIndex               = 3
ContentArea.Visible              = false
ContentArea.Parent               = WindowPrefab

-- Resizer handle
local ResizerHandle = Instance.new("TextButton")
ResizerHandle.Name                 = "Resizer"
ResizerHandle.BackgroundColor3     = active_theme.border
ResizerHandle.BackgroundTransparency = 0.6
ResizerHandle.BorderSizePixel      = 0
ResizerHandle.AnchorPoint          = Vector2.new(1, 1)
ResizerHandle.Position             = UDim2.new(1, -2, 1, -2)
ResizerHandle.Size                 = UDim2.new(0, 14, 0, 14)
ResizerHandle.Text                 = ""
ResizerHandle.ZIndex               = 10
ResizerHandle.Active               = true
ResizerHandle.Parent               = WindowPrefab
AddCorner(ResizerHandle, UDim.new(0, 3))

------------------------------------------------------------------------
-- TAB BUTTON PREFAB
------------------------------------------------------------------------

local TabButtonPrefab = Instance.new("TextButton")
TabButtonPrefab.Name                 = "TabButton"
TabButtonPrefab.BackgroundColor3     = active_theme.surface2
TabButtonPrefab.BackgroundTransparency = 1
TabButtonPrefab.BorderSizePixel      = 0
TabButtonPrefab.AutoButtonColor      = false
TabButtonPrefab.Size                 = UDim2.new(0, 80, 0, 26)
TabButtonPrefab.ZIndex               = 5
TabButtonPrefab.Font                 = ui_options.font
TabButtonPrefab.Text                 = "Tab"
TabButtonPrefab.TextColor3           = active_theme.text_dim
TabButtonPrefab.TextSize             = 13
TabButtonPrefab.Parent               = Prefabs
AddCorner(TabButtonPrefab, UDim.new(0, 5))

------------------------------------------------------------------------
-- ELEMENT PREFABS
------------------------------------------------------------------------

-- Label
local LabelPrefab = Instance.new("TextLabel")
LabelPrefab.Name                 = "Label"
LabelPrefab.BackgroundTransparency = 1
LabelPrefab.Size                 = UDim2.new(1, 0, 0, 20)
LabelPrefab.Font                 = ui_options.font_small
LabelPrefab.Text                 = "Label"
LabelPrefab.TextColor3           = active_theme.text_dim
LabelPrefab.TextSize             = 13
LabelPrefab.TextXAlignment       = Enum.TextXAlignment.Left
LabelPrefab.Parent               = Prefabs

-- Button
local ButtonPrefab = Instance.new("TextButton")
ButtonPrefab.Name                 = "Button"
ButtonPrefab.BackgroundColor3     = active_theme.surface2
ButtonPrefab.BorderSizePixel      = 0
ButtonPrefab.AutoButtonColor      = false
ButtonPrefab.Size                 = UDim2.new(1, 0, 0, 32)
ButtonPrefab.ZIndex               = 2
ButtonPrefab.Font                 = ui_options.font
ButtonPrefab.Text                 = "Button"
ButtonPrefab.TextColor3           = active_theme.text
ButtonPrefab.TextSize             = 14
ButtonPrefab.Parent               = Prefabs
AddCorner(ButtonPrefab)
AddStroke(ButtonPrefab, active_theme.border, 1)

-- Switch (toggle checkbox)
local SwitchPrefab = Instance.new("Frame")
SwitchPrefab.Name                 = "Switch"
SwitchPrefab.BackgroundTransparency = 1
SwitchPrefab.Size                 = UDim2.new(1, 0, 0, 30)
SwitchPrefab.Parent               = Prefabs

local SwitchTrack = Instance.new("Frame")
SwitchTrack.Name             = "Track"
SwitchTrack.BackgroundColor3 = active_theme.surface2
SwitchTrack.BorderSizePixel  = 0
SwitchTrack.AnchorPoint      = Vector2.new(0, 0.5)
SwitchTrack.Position         = UDim2.new(1, -44, 0.5, 0)
SwitchTrack.Size             = UDim2.new(0, 36, 0, 20)
SwitchTrack.ZIndex           = 3
SwitchTrack.Parent           = SwitchPrefab
AddCorner(SwitchTrack, UDim.new(1, 0))
AddStroke(SwitchTrack, active_theme.border, 1)

local SwitchThumb = Instance.new("Frame")
SwitchThumb.Name             = "Thumb"
SwitchThumb.BackgroundColor3 = active_theme.text_dim
SwitchThumb.BorderSizePixel  = 0
SwitchThumb.AnchorPoint      = Vector2.new(0, 0.5)
SwitchThumb.Position         = UDim2.new(0, 2, 0.5, 0)
SwitchThumb.Size             = UDim2.new(0, 16, 0, 16)
SwitchThumb.ZIndex           = 4
SwitchThumb.Parent           = SwitchTrack
AddCorner(SwitchThumb, UDim.new(1, 0))

local SwitchHitbox = Instance.new("TextButton")
SwitchHitbox.Name                 = "Hitbox"
SwitchHitbox.BackgroundTransparency = 1
SwitchHitbox.BorderSizePixel      = 0
SwitchHitbox.Size                 = UDim2.new(1, 0, 1, 0)
SwitchHitbox.ZIndex               = 5
SwitchHitbox.Text                 = ""
SwitchHitbox.Parent               = SwitchPrefab

local SwitchTitleLabel = Instance.new("TextLabel")
SwitchTitleLabel.Name                 = "Title"
SwitchTitleLabel.BackgroundTransparency = 1
SwitchTitleLabel.AnchorPoint          = Vector2.new(0, 0.5)
SwitchTitleLabel.Position             = UDim2.new(0, 0, 0.5, 0)
SwitchTitleLabel.Size                 = UDim2.new(1, -52, 0, 20)
SwitchTitleLabel.ZIndex               = 3
SwitchTitleLabel.Font                 = ui_options.font
SwitchTitleLabel.Text                 = "Toggle"
SwitchTitleLabel.TextColor3           = active_theme.text
SwitchTitleLabel.TextSize             = 14
SwitchTitleLabel.TextXAlignment       = Enum.TextXAlignment.Left
SwitchTitleLabel.Parent               = SwitchPrefab

-- Slider
local SliderPrefab = Instance.new("Frame")
SliderPrefab.Name                 = "Slider"
SliderPrefab.BackgroundTransparency = 1
SliderPrefab.Size                 = UDim2.new(1, 0, 0, 48)
SliderPrefab.Parent               = Prefabs

local SliderTitle = Instance.new("TextLabel")
SliderTitle.Name                 = "Title"
SliderTitle.BackgroundTransparency = 1
SliderTitle.Size                 = UDim2.new(1, -60, 0, 18)
SliderTitle.ZIndex               = 3
SliderTitle.Font                 = ui_options.font
SliderTitle.Text                 = "Slider"
SliderTitle.TextColor3           = active_theme.text
SliderTitle.TextSize             = 14
SliderTitle.TextXAlignment       = Enum.TextXAlignment.Left
SliderTitle.Parent               = SliderPrefab

local SliderValueLabel = Instance.new("TextLabel")
SliderValueLabel.Name                 = "Value"
SliderValueLabel.BackgroundTransparency = 1
SliderValueLabel.AnchorPoint          = Vector2.new(1, 0)
SliderValueLabel.Position             = UDim2.new(1, 0, 0, 0)
SliderValueLabel.Size                 = UDim2.new(0, 55, 0, 18)
SliderValueLabel.ZIndex               = 3
SliderValueLabel.Font                 = ui_options.font_bold
SliderValueLabel.Text                 = "0"
SliderValueLabel.TextColor3           = ui_options.main_color
SliderValueLabel.TextSize             = 14
SliderValueLabel.TextXAlignment       = Enum.TextXAlignment.Right
SliderValueLabel.Parent               = SliderPrefab

local SliderTrack = Instance.new("Frame")
SliderTrack.Name             = "Track"
SliderTrack.BackgroundColor3 = active_theme.surface2
SliderTrack.BorderSizePixel  = 0
SliderTrack.Position         = UDim2.new(0, 0, 0, 26)
SliderTrack.Size             = UDim2.new(1, 0, 0, 6)
SliderTrack.ZIndex           = 3
SliderTrack.Parent           = SliderPrefab
AddCorner(SliderTrack, UDim.new(1, 0))
AddStroke(SliderTrack, active_theme.border, 1)

local SliderFill = Instance.new("Frame")
SliderFill.Name             = "Fill"
SliderFill.BackgroundColor3 = ui_options.main_color
SliderFill.BorderSizePixel  = 0
SliderFill.Size             = UDim2.new(0, 0, 1, 0)
SliderFill.ZIndex           = 4
SliderFill.Parent           = SliderTrack
AddCorner(SliderFill, UDim.new(1, 0))

local SliderHandle = Instance.new("Frame")
SliderHandle.Name             = "Handle"
SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderHandle.BorderSizePixel  = 0
SliderHandle.AnchorPoint      = Vector2.new(0.5, 0.5)
SliderHandle.Position         = UDim2.new(0, 0, 0.5, 0)
SliderHandle.Size             = UDim2.new(0, 14, 0, 14)
SliderHandle.ZIndex           = 6
SliderHandle.Parent           = SliderTrack
AddCorner(SliderHandle, UDim.new(1, 0))
AddStroke(SliderHandle, active_theme.border, 1.5)

local SliderHitbox = Instance.new("TextButton")
SliderHitbox.Name                 = "Hitbox"
SliderHitbox.BackgroundTransparency = 1
SliderHitbox.BorderSizePixel      = 0
SliderHitbox.Position             = UDim2.new(0, 0, 0, 22)
SliderHitbox.Size                 = UDim2.new(1, 0, 0, 14)
SliderHitbox.ZIndex               = 5
SliderHitbox.Text                 = ""
SliderHitbox.Parent               = SliderPrefab

-- TextBox
local TextBoxPrefab = Instance.new("Frame")
TextBoxPrefab.Name                 = "TextBoxWidget"
TextBoxPrefab.BackgroundTransparency = 1
TextBoxPrefab.Size                 = UDim2.new(1, 0, 0, 48)
TextBoxPrefab.Parent               = Prefabs

local TextBoxTitle = Instance.new("TextLabel")
TextBoxTitle.Name                 = "Title"
TextBoxTitle.BackgroundTransparency = 1
TextBoxTitle.Size                 = UDim2.new(1, 0, 0, 18)
TextBoxTitle.ZIndex               = 3
TextBoxTitle.Font                 = ui_options.font
TextBoxTitle.Text                 = "Input"
TextBoxTitle.TextColor3           = active_theme.text
TextBoxTitle.TextSize             = 14
TextBoxTitle.TextXAlignment       = Enum.TextXAlignment.Left
TextBoxTitle.Parent               = TextBoxPrefab

local TextBoxInput = Instance.new("TextBox")
TextBoxInput.Name                 = "Input"
TextBoxInput.BackgroundColor3     = active_theme.surface2
TextBoxInput.BorderSizePixel      = 0
TextBoxInput.Position             = UDim2.new(0, 0, 0, 22)
TextBoxInput.Size                 = UDim2.new(1, 0, 0, 26)
TextBoxInput.ZIndex               = 3
TextBoxInput.ClearTextOnFocus     = false
TextBoxInput.Font                 = ui_options.font_small
TextBoxInput.PlaceholderColor3    = active_theme.text_dim
TextBoxInput.PlaceholderText      = "Type here..."
TextBoxInput.Text                 = ""
TextBoxInput.TextColor3           = active_theme.text
TextBoxInput.TextSize             = 13
TextBoxInput.TextXAlignment       = Enum.TextXAlignment.Left
TextBoxInput.Parent               = TextBoxPrefab
AddCorner(TextBoxInput)
AddStroke(TextBoxInput, active_theme.border, 1)
AddPadding(TextBoxInput, 8)

-- Dropdown
local DropdownPrefab = Instance.new("Frame")
DropdownPrefab.Name                 = "Dropdown"
DropdownPrefab.BackgroundTransparency = 1
DropdownPrefab.Size                 = UDim2.new(1, 0, 0, 32)
DropdownPrefab.ZIndex               = 2
DropdownPrefab.Parent               = Prefabs

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Name                 = "DropBtn"
DropdownBtn.BackgroundColor3     = active_theme.surface2
DropdownBtn.BorderSizePixel      = 0
DropdownBtn.AutoButtonColor      = false
DropdownBtn.Size                 = UDim2.new(1, 0, 0, 32)
DropdownBtn.ZIndex               = 3
DropdownBtn.Font                 = ui_options.font
DropdownBtn.Text                 = ""
DropdownBtn.TextColor3           = active_theme.text
DropdownBtn.TextSize             = 13
DropdownBtn.Parent               = DropdownPrefab
AddCorner(DropdownBtn)
AddStroke(DropdownBtn, active_theme.border, 1)

local DropdownLabel = Instance.new("TextLabel")
DropdownLabel.Name                 = "Label"
DropdownLabel.BackgroundTransparency = 1
DropdownLabel.Position             = UDim2.new(0, 10, 0, 0)
DropdownLabel.Size                 = UDim2.new(1, -40, 1, 0)
DropdownLabel.ZIndex               = 4
DropdownLabel.Font                 = ui_options.font
DropdownLabel.Text                 = "Select..."
DropdownLabel.TextColor3           = active_theme.text_dim
DropdownLabel.TextSize             = 13
DropdownLabel.TextXAlignment       = Enum.TextXAlignment.Left
DropdownLabel.Parent               = DropdownPrefab

local DropdownArrow = Instance.new("TextLabel")
DropdownArrow.Name                 = "Arrow"
DropdownArrow.BackgroundTransparency = 1
DropdownArrow.AnchorPoint          = Vector2.new(1, 0.5)
DropdownArrow.Position             = UDim2.new(1, -8, 0.5, 0)
DropdownArrow.Size                 = UDim2.new(0, 20, 0, 20)
DropdownArrow.ZIndex               = 4
DropdownArrow.Font                 = ui_options.font_bold
DropdownArrow.Text                 = "▾"
DropdownArrow.TextColor3           = active_theme.text_dim
DropdownArrow.TextSize             = 14
DropdownArrow.Parent               = DropdownPrefab

local DropdownBox = Instance.new("Frame")
DropdownBox.Name             = "Box"
DropdownBox.BackgroundColor3 = active_theme.surface
DropdownBox.BorderSizePixel  = 0
DropdownBox.ClipsDescendants = true
DropdownBox.Position         = UDim2.new(0, 0, 0, 34)
DropdownBox.Size             = UDim2.new(1, 0, 0, 0)
DropdownBox.ZIndex           = 20
DropdownBox.Parent           = DropdownPrefab
AddCorner(DropdownBox)
AddStroke(DropdownBox, active_theme.border, 1)

local DropdownBoxScroll = Instance.new("ScrollingFrame")
DropdownBoxScroll.Name                 = "Scroll"
DropdownBoxScroll.BackgroundTransparency = 1
DropdownBoxScroll.BorderSizePixel      = 0
DropdownBoxScroll.Size                 = UDim2.new(1, 0, 1, 0)
DropdownBoxScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
DropdownBoxScroll.ScrollBarThickness   = 3
DropdownBoxScroll.ScrollBarImageColor3 = active_theme.border
DropdownBoxScroll.ZIndex               = 21
DropdownBoxScroll.Parent               = DropdownBox

local DropdownBoxLayout = Instance.new("UIListLayout")
DropdownBoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
DropdownBoxLayout.Parent    = DropdownBoxScroll

-- Keybind
local KeybindPrefab = Instance.new("Frame")
KeybindPrefab.Name                 = "Keybind"
KeybindPrefab.BackgroundTransparency = 1
KeybindPrefab.Size                 = UDim2.new(1, 0, 0, 30)
KeybindPrefab.Parent               = Prefabs

local KeybindTitle = Instance.new("TextLabel")
KeybindTitle.Name                 = "Title"
KeybindTitle.BackgroundTransparency = 1
KeybindTitle.AnchorPoint          = Vector2.new(0, 0.5)
KeybindTitle.Position             = UDim2.new(0, 0, 0.5, 0)
KeybindTitle.Size                 = UDim2.new(1, -100, 0, 20)
KeybindTitle.ZIndex               = 3
KeybindTitle.Font                 = ui_options.font
KeybindTitle.Text                 = "Keybind"
KeybindTitle.TextColor3           = active_theme.text
KeybindTitle.TextSize             = 14
KeybindTitle.TextXAlignment       = Enum.TextXAlignment.Left
KeybindTitle.Parent               = KeybindPrefab

local KeybindInput = Instance.new("TextButton")
KeybindInput.Name                 = "Input"
KeybindInput.BackgroundColor3     = active_theme.surface2
KeybindInput.BorderSizePixel      = 0
KeybindInput.AutoButtonColor      = false
KeybindInput.AnchorPoint          = Vector2.new(1, 0.5)
KeybindInput.Position             = UDim2.new(1, 0, 0.5, 0)
KeybindInput.Size                 = UDim2.new(0, 88, 0, 24)
KeybindInput.ZIndex               = 4
KeybindInput.Font                 = ui_options.font
KeybindInput.Text                 = "None"
KeybindInput.TextColor3           = active_theme.text_dim
KeybindInput.TextSize             = 12
KeybindInput.Parent               = KeybindPrefab
AddCorner(KeybindInput)
AddStroke(KeybindInput, active_theme.border, 1)

-- ColorPicker container
local ColorPickerPrefab = Instance.new("Frame")
ColorPickerPrefab.Name                 = "ColorPicker"
ColorPickerPrefab.BackgroundColor3     = active_theme.surface2
ColorPickerPrefab.BorderSizePixel      = 0
ColorPickerPrefab.Size                 = UDim2.new(1, 0, 0, 130)
ColorPickerPrefab.Parent               = Prefabs
AddCorner(ColorPickerPrefab)
AddStroke(ColorPickerPrefab, active_theme.border, 1)
AddPadding(ColorPickerPrefab, 8)

local CPPalette = Instance.new("ImageLabel")
CPPalette.Name                 = "Palette"
CPPalette.BackgroundTransparency = 1
CPPalette.Position             = UDim2.new(0, 0, 0, 0)
CPPalette.Size                 = UDim2.new(0, 110, 0, 110)
CPPalette.ZIndex               = 3
CPPalette.Image                = "rbxassetid://698052001"
CPPalette.Parent               = ColorPickerPrefab
AddCorner(CPPalette, UDim.new(0, 4))

local CPIndicator = Instance.new("Frame")
CPIndicator.Name             = "Indicator"
CPIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CPIndicator.BorderSizePixel  = 0
CPIndicator.AnchorPoint      = Vector2.new(0.5, 0.5)
CPIndicator.Size             = UDim2.new(0, 8, 0, 8)
CPIndicator.ZIndex           = 5
CPIndicator.Parent           = CPPalette
AddCorner(CPIndicator, UDim.new(1, 0))
AddStroke(CPIndicator, Color3.fromRGB(0, 0, 0), 1.5)

local CPSaturation = Instance.new("ImageLabel")
CPSaturation.Name             = "Saturation"
CPSaturation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CPSaturation.Position         = UDim2.new(0, 118, 0, 0)
CPSaturation.Size             = UDim2.new(0, 18, 0, 110)
CPSaturation.ZIndex           = 3
CPSaturation.Image            = "rbxassetid://3641079629"
CPSaturation.Parent           = ColorPickerPrefab
AddCorner(CPSaturation, UDim.new(0, 4))

local CPSatIndicator = Instance.new("Frame")
CPSatIndicator.Name             = "Indicator"
CPSatIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CPSatIndicator.BorderSizePixel  = 0
CPSatIndicator.AnchorPoint      = Vector2.new(0.5, 0.5)
CPSatIndicator.Size             = UDim2.new(1.4, 0, 0, 4)
CPSatIndicator.ZIndex           = 5
CPSatIndicator.Parent           = CPSaturation
AddCorner(CPSatIndicator, UDim.new(1, 0))
AddStroke(CPSatIndicator, Color3.fromRGB(0, 0, 0), 1)

local CPSample = Instance.new("Frame")
CPSample.Name             = "Sample"
CPSample.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CPSample.BorderSizePixel  = 0
CPSample.Position         = UDim2.new(0, 144, 0, 0)
CPSample.Size             = UDim2.new(0, 30, 0, 30)
CPSample.ZIndex           = 3
CPSample.Parent           = ColorPickerPrefab
AddCorner(CPSample, UDim.new(0, 6))
AddStroke(CPSample, active_theme.border, 1)

-- ProgressBar prefab
local ProgressBarPrefab = Instance.new("Frame")
ProgressBarPrefab.Name                 = "ProgressBar"
ProgressBarPrefab.BackgroundTransparency = 1
ProgressBarPrefab.Size                 = UDim2.new(1, 0, 0, 40)
ProgressBarPrefab.Parent               = Prefabs

local PBTitle = Instance.new("TextLabel")
PBTitle.Name                 = "Title"
PBTitle.BackgroundTransparency = 1
PBTitle.Size                 = UDim2.new(1, -50, 0, 18)
PBTitle.Font                 = ui_options.font
PBTitle.Text                 = "Progress"
PBTitle.TextColor3           = active_theme.text
PBTitle.TextSize             = 14
PBTitle.TextXAlignment       = Enum.TextXAlignment.Left
PBTitle.ZIndex               = 3
PBTitle.Parent               = ProgressBarPrefab

local PBValue = Instance.new("TextLabel")
PBValue.Name                 = "Value"
PBValue.BackgroundTransparency = 1
PBValue.AnchorPoint          = Vector2.new(1, 0)
PBValue.Position             = UDim2.new(1, 0, 0, 0)
PBValue.Size                 = UDim2.new(0, 45, 0, 18)
PBValue.Font                 = ui_options.font_bold
PBValue.Text                 = "0%"
PBValue.TextColor3           = ui_options.main_color
PBValue.TextSize             = 13
PBValue.TextXAlignment       = Enum.TextXAlignment.Right
PBValue.ZIndex               = 3
PBValue.Parent               = ProgressBarPrefab

local PBTrack = Instance.new("Frame")
PBTrack.Name             = "Track"
PBTrack.BackgroundColor3 = active_theme.surface2
PBTrack.BorderSizePixel  = 0
PBTrack.Position         = UDim2.new(0, 0, 0, 23)
PBTrack.Size             = UDim2.new(1, 0, 0, 8)
PBTrack.ZIndex           = 3
PBTrack.Parent           = ProgressBarPrefab
AddCorner(PBTrack, UDim.new(1, 0))
AddStroke(PBTrack, active_theme.border, 1)

local PBFill = Instance.new("Frame")
PBFill.Name             = "Fill"
PBFill.BackgroundColor3 = ui_options.main_color
PBFill.BorderSizePixel  = 0
PBFill.Size             = UDim2.new(0, 0, 1, 0)
PBFill.ZIndex           = 4
PBFill.Parent           = PBTrack
AddCorner(PBFill, UDim.new(1, 0))

-- NumberStepper prefab
local NumberStepperPrefab = Instance.new("Frame")
NumberStepperPrefab.Name                 = "NumberStepper"
NumberStepperPrefab.BackgroundTransparency = 1
NumberStepperPrefab.Size                 = UDim2.new(1, 0, 0, 32)
NumberStepperPrefab.Parent               = Prefabs

local NSTitle = Instance.new("TextLabel")
NSTitle.Name                 = "Title"
NSTitle.BackgroundTransparency = 1
NSTitle.AnchorPoint          = Vector2.new(0, 0.5)
NSTitle.Position             = UDim2.new(0, 0, 0.5, 0)
NSTitle.Size                 = UDim2.new(1, -130, 0, 20)
NSTitle.Font                 = ui_options.font
NSTitle.Text                 = "Number"
NSTitle.TextColor3           = active_theme.text
NSTitle.TextSize             = 14
NSTitle.TextXAlignment       = Enum.TextXAlignment.Left
NSTitle.ZIndex               = 3
NSTitle.Parent               = NumberStepperPrefab

local NSMinus = Instance.new("TextButton")
NSMinus.Name                 = "Minus"
NSMinus.BackgroundColor3     = active_theme.surface2
NSMinus.BorderSizePixel      = 0
NSMinus.AutoButtonColor      = false
NSMinus.AnchorPoint          = Vector2.new(1, 0.5)
NSMinus.Position             = UDim2.new(1, -44, 0.5, 0)
NSMinus.Size                 = UDim2.new(0, 28, 0, 28)
NSMinus.Font                 = ui_options.font_bold
NSMinus.Text                 = "−"
NSMinus.TextColor3           = active_theme.text
NSMinus.TextSize             = 16
NSMinus.ZIndex               = 4
NSMinus.Parent               = NumberStepperPrefab
AddCorner(NSMinus, UDim.new(0, 5))
AddStroke(NSMinus, active_theme.border, 1)

local NSValueLabel = Instance.new("TextLabel")
NSValueLabel.Name                 = "Value"
NSValueLabel.BackgroundColor3     = active_theme.surface2
NSValueLabel.BorderSizePixel      = 0
NSValueLabel.AnchorPoint          = Vector2.new(1, 0.5)
NSValueLabel.Position             = UDim2.new(1, -76, 0.5, 0)
NSValueLabel.Size                 = UDim2.new(0, 28, 0, 28)
NSValueLabel.Font                 = ui_options.font_bold
NSValueLabel.Text                 = "0"
NSValueLabel.TextColor3           = active_theme.text
NSValueLabel.TextSize             = 13
NSValueLabel.ZIndex               = 4
NSValueLabel.Parent               = NumberStepperPrefab
AddCorner(NSValueLabel, UDim.new(0, 5))
AddStroke(NSValueLabel, active_theme.border, 1)

local NSPlus = Instance.new("TextButton")
NSPlus.Name                 = "Plus"
NSPlus.BackgroundColor3     = ui_options.main_color
NSPlus.BorderSizePixel      = 0
NSPlus.AutoButtonColor      = false
NSPlus.AnchorPoint          = Vector2.new(1, 0.5)
NSPlus.Position             = UDim2.new(1, -12, 0.5, 0)
NSPlus.Size                 = UDim2.new(0, 28, 0, 28)
NSPlus.Font                 = ui_options.font_bold
NSPlus.Text                 = "+"
NSPlus.TextColor3           = Color3.fromRGB(255, 255, 255)
NSPlus.TextSize             = 16
NSPlus.ZIndex               = 4
NSPlus.Parent               = NumberStepperPrefab
AddCorner(NSPlus, UDim.new(0, 5))

-- RadioGroup prefab
local RadioGroupPrefab = Instance.new("Frame")
RadioGroupPrefab.Name                 = "RadioGroup"
RadioGroupPrefab.BackgroundTransparency = 1
RadioGroupPrefab.Size                 = UDim2.new(1, 0, 0, 20)
RadioGroupPrefab.Parent               = Prefabs

local RadioGroupLayout = Instance.new("UIListLayout")
RadioGroupLayout.SortOrder = Enum.SortOrder.LayoutOrder
RadioGroupLayout.Padding   = UDim.new(0, 6)
RadioGroupLayout.Parent    = RadioGroupPrefab

-- Image display prefab
local ImageDisplayPrefab = Instance.new("Frame")
ImageDisplayPrefab.Name                 = "ImageDisplay"
ImageDisplayPrefab.BackgroundColor3     = active_theme.surface2
ImageDisplayPrefab.BorderSizePixel      = 0
ImageDisplayPrefab.Size                 = UDim2.new(1, 0, 0, 120)
ImageDisplayPrefab.Parent               = Prefabs
AddCorner(ImageDisplayPrefab)
AddStroke(ImageDisplayPrefab, active_theme.border, 1)

local IDImage = Instance.new("ImageLabel")
IDImage.Name                 = "Image"
IDImage.BackgroundTransparency = 1
IDImage.AnchorPoint          = Vector2.new(0.5, 0.5)
IDImage.Position             = UDim2.new(0.5, 0, 0.5, 0)
IDImage.Size                 = UDim2.new(1, -16, 1, -16)
IDImage.ZIndex               = 3
IDImage.ScaleType            = Enum.ScaleType.Fit
IDImage.Parent               = ImageDisplayPrefab
AddCorner(IDImage, UDim.new(0, 5))

local IDCaption = Instance.new("TextLabel")
IDCaption.Name                 = "Caption"
IDCaption.BackgroundTransparency = 1
IDCaption.AnchorPoint          = Vector2.new(0, 1)
IDCaption.Position             = UDim2.new(0, 8, 1, -8)
IDCaption.Size                 = UDim2.new(1, -16, 0, 16)
IDCaption.Font                 = ui_options.font_small
IDCaption.Text                 = ""
IDCaption.TextColor3           = active_theme.text_dim
IDCaption.TextSize             = 12
IDCaption.TextXAlignment       = Enum.TextXAlignment.Left
IDCaption.ZIndex               = 4
IDCaption.Parent               = ImageDisplayPrefab

------------------------------------------------------------------------
-- LIBRARY STATE
------------------------------------------------------------------------

local windowCount = 0
local library     = {}

local checks = {
    binding = false,
}

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local key = (typeof(ui_options.toggle_key) == "EnumItem") and ui_options.toggle_key or Enum.KeyCode.RightShift
    if input.KeyCode == key then
        if not checks.binding then
            imgui.Enabled = not imgui.Enabled
        end
    end
end)

------------------------------------------------------------------------
-- PUBLIC: Notify shorthand
------------------------------------------------------------------------

function library:Notify(title, message, ntype, duration)
    Notify({ title = title, message = message, type = ntype, duration = duration })
end

------------------------------------------------------------------------
-- PUBLIC: SetTheme
------------------------------------------------------------------------

function library:SetTheme(themeName)
    local t = Themes[themeName]
    if not t then return end
    active_theme = t
    ui_options.main_color = t.main_color

    -- Update tooltip
    TooltipFrame.BackgroundColor3 = t.surface2
    TooltipStroke.Color           = t.border
    TooltipLabel.TextColor3       = t.text
    NotifContainer.Position       = UDim2.new(1, -340, 0, 10)
end

------------------------------------------------------------------------
-- PUBLIC: AddWindow
------------------------------------------------------------------------

function library:AddWindow(title, options)
    windowCount = windowCount + 1
    local wIdx  = windowCount

    title   = tostring(title or "Window")
    options = (typeof(options) == "table") and options or {}
    options.main_color  = options.main_color  or ui_options.main_color
    options.min_size    = options.min_size    or ui_options.min_size
    options.can_resize  = (options.can_resize ~= false)
    options.tween_time  = ui_options.tween_time

    -- Clone & position
    local win = Instance.new("Frame")
    win.Name                 = "Window_" .. wIdx
    win.BackgroundColor3     = active_theme.bg
    win.BackgroundTransparency = ui_options.window_transparency
    win.BorderSizePixel      = 0
    win.ClipsDescendants     = true
    win.Position             = UDim2.new(0, 20 + (wIdx - 1) * 30, 0, 20 + (wIdx - 1) * 30)
    win.Size                 = UDim2.new(0, options.min_size.X, 0, options.min_size.Y)
    win.Active               = true
    win.Selectable           = true
    win.ZIndex               = wIdx * 10
    win.Parent               = Windows
    AddCorner(win, UDim.new(0, 10))
    AddStroke(win, active_theme.border, 1.2)
    AddGradient(win, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 26)),
    }), 110)

    win.Draggable = true

    -- Titlebar
    local titleBar = Instance.new("Frame")
    titleBar.Name             = "TitleBar"
    titleBar.BackgroundColor3 = active_theme.surface
    titleBar.BorderSizePixel  = 0
    titleBar.Size             = UDim2.new(1, 0, 0, 38)
    titleBar.ZIndex           = wIdx * 10 + 4
    titleBar.Parent           = win
    AddGradient(titleBar, ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 36)),
    }), 90)

    -- Accent line
    local accentLine = Instance.new("Frame")
    accentLine.BackgroundColor3 = options.main_color
    accentLine.BorderSizePixel  = 0
    accentLine.Position         = UDim2.new(0, 0, 1, -2)
    accentLine.Size             = UDim2.new(1, 0, 0, 2)
    accentLine.ZIndex           = wIdx * 10 + 5
    accentLine.Parent           = titleBar

    -- Colored dot
    local dot = Instance.new("Frame")
    dot.BackgroundColor3 = options.main_color
    dot.BorderSizePixel  = 0
    dot.AnchorPoint      = Vector2.new(0, 0.5)
    dot.Position         = UDim2.new(0, 13, 0.5, 0)
    dot.Size             = UDim2.new(0, 10, 0, 10)
    dot.ZIndex           = wIdx * 10 + 5
    dot.Parent           = titleBar
    AddCorner(dot, UDim.new(1, 0))

    -- Title text
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name                 = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position             = UDim2.new(0, 32, 0, 0)
    titleLabel.Size                 = UDim2.new(1, -70, 1, 0)
    titleLabel.ZIndex               = wIdx * 10 + 5
    titleLabel.Font                 = ui_options.font_bold
    titleLabel.Text                 = title
    titleLabel.TextColor3           = active_theme.text
    titleLabel.TextSize             = 15
    titleLabel.TextXAlignment       = Enum.TextXAlignment.Left
    titleLabel.Parent               = titleBar

    -- Toggle button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name                 = "Toggle"
    toggleBtn.BackgroundColor3     = active_theme.surface2
    toggleBtn.BorderSizePixel      = 0
    toggleBtn.AutoButtonColor      = false
    toggleBtn.AnchorPoint          = Vector2.new(1, 0.5)
    toggleBtn.Position             = UDim2.new(1, -10, 0.5, 0)
    toggleBtn.Size                 = UDim2.new(0, 24, 0, 24)
    toggleBtn.ZIndex               = wIdx * 10 + 6
    toggleBtn.Font                 = ui_options.font_bold
    toggleBtn.Text                 = "—"
    toggleBtn.TextColor3           = active_theme.text_dim
    toggleBtn.TextSize             = 14
    toggleBtn.Parent               = titleBar
    AddCorner(toggleBtn, UDim.new(0, 5))
    AddStroke(toggleBtn, active_theme.border, 1)
    attachTooltip(toggleBtn, "Minimize window")

    toggleBtn.MouseEnter:Connect(function()
        Tween(toggleBtn, {BackgroundColor3 = active_theme.surface2, TextColor3 = active_theme.text}, 0.12)
    end)
    toggleBtn.MouseLeave:Connect(function()
        Tween(toggleBtn, {TextColor3 = active_theme.text_dim}, 0.12)
    end)

    -- Tab selection bar
    local tabSelBar = Instance.new("Frame")
    tabSelBar.Name                 = "TabSelBar"
    tabSelBar.BackgroundColor3     = active_theme.surface
    tabSelBar.BorderSizePixel      = 0
    tabSelBar.Position             = UDim2.new(0, 0, 0, 38)
    tabSelBar.Size                 = UDim2.new(1, 0, 0, 32)
    tabSelBar.ZIndex               = wIdx * 10 + 3
    tabSelBar.Visible              = false
    tabSelBar.Parent               = win

    local tabDivider = Instance.new("Frame")
    tabDivider.BackgroundColor3 = active_theme.border
    tabDivider.BorderSizePixel  = 0
    tabDivider.Position         = UDim2.new(0, 0, 1, -1)
    tabDivider.Size             = UDim2.new(1, 0, 0, 1)
    tabDivider.ZIndex           = wIdx * 10 + 4
    tabDivider.Parent           = tabSelBar

    local tabScrollFrame = Instance.new("ScrollingFrame")
    tabScrollFrame.Name                 = "TabButtons"
    tabScrollFrame.BackgroundTransparency = 1
    tabScrollFrame.BorderSizePixel      = 0
    tabScrollFrame.Size                 = UDim2.new(1, -12, 1, 0)
    tabScrollFrame.Position             = UDim2.new(0, 6, 0, 0)
    tabScrollFrame.CanvasSize           = UDim2.new(0, 0, 0, 0)
    tabScrollFrame.ScrollBarThickness   = 0
    tabScrollFrame.ZIndex               = wIdx * 10 + 4
    tabScrollFrame.Parent               = tabSelBar

    local tabBtnsLayout = Instance.new("UIListLayout")
    tabBtnsLayout.FillDirection       = Enum.FillDirection.Horizontal
    tabBtnsLayout.SortOrder           = Enum.SortOrder.LayoutOrder
    tabBtnsLayout.Padding             = UDim.new(0, 4)
    tabBtnsLayout.VerticalAlignment   = Enum.VerticalAlignment.Center
    tabBtnsLayout.Parent              = tabScrollFrame

    -- Content scroll area
    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Name                 = "ContentArea"
    contentScroll.BackgroundTransparency = 1
    contentScroll.BorderSizePixel      = 0
    contentScroll.Position             = UDim2.new(0, 10, 0, 80)
    contentScroll.Size                 = UDim2.new(1, -20, 1, -90)
    contentScroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
    contentScroll.ScrollBarThickness   = 4
    contentScroll.ScrollBarImageColor3 = active_theme.border
    contentScroll.ZIndex               = wIdx * 10 + 2
    contentScroll.Visible              = false
    contentScroll.Parent               = win

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding   = UDim.new(0, 6)
    contentLayout.Parent    = contentScroll

    -- Auto-size canvas
    contentLayout.Changed:Connect(function(prop)
        if prop == "AbsoluteContentSize" then
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
        end
    end)

    -- Resizer
    local resizer = Instance.new("TextButton")
    resizer.Name                 = "Resizer"
    resizer.BackgroundColor3     = active_theme.border
    resizer.BackgroundTransparency = 0.5
    resizer.BorderSizePixel      = 0
    resizer.AnchorPoint          = Vector2.new(1, 1)
    resizer.Position             = UDim2.new(1, -4, 1, -4)
    resizer.Size                 = UDim2.new(0, 12, 0, 12)
    resizer.Text                 = ""
    resizer.ZIndex               = wIdx * 10 + 8
    resizer.Active               = true
    resizer.Parent               = win
    AddCorner(resizer, UDim.new(0, 3))
    attachTooltip(resizer, "Drag to resize")

    -- Minimize logic
    local winOpen = true
    local savedHeight = options.min_size.Y
    toggleBtn.MouseButton1Click:Connect(function()
        if winOpen then
            savedHeight = win.AbsoluteSize.Y
            Tween(win, {Size = UDim2.new(0, win.AbsoluteSize.X, 0, 38)}, 0.22, Enum.EasingStyle.Quart)
            tabSelBar.Visible   = false
            contentScroll.Visible = false
            toggleBtn.Text = "▲"
        else
            Tween(win, {Size = UDim2.new(0, win.AbsoluteSize.X, 0, savedHeight)}, 0.22, Enum.EasingStyle.Quart)
            tabSelBar.Visible     = (tabSelBar.Visible == false and true or tabSelBar.Visible)
            contentScroll.Visible = true
            toggleBtn.Text = "—"
        end
        winOpen = not winOpen
    end)

    -- Resize logic
    do
        local resizing = false
        local entered  = false

        resizer.MouseEnter:Connect(function()
            entered = true
            win.Draggable = false
            Tween(resizer, {BackgroundTransparency = 0.2}, 0.1)
        end)
        resizer.MouseLeave:Connect(function()
            entered = false
            if not resizing then
                win.Draggable = true
                Tween(resizer, {BackgroundTransparency = 0.5}, 0.1)
            end
        end)
        UIS.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 and entered and options.can_resize then
                resizing = true
            end
        end)
        UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                if resizing then
                    resizing = false
                    win.Draggable = true
                    Tween(resizer, {BackgroundTransparency = 0.5}, 0.1)
                end
            end
        end)
        RS.RenderStepped:Connect(function()
            if resizing then
                local mp  = gMouse()
                local pos = win.AbsolutePosition
                local nx  = math.max(mp.X - pos.X, options.min_size.X)
                local ny  = math.max(mp.Y - pos.Y, options.min_size.Y)
                win.Size  = UDim2.new(0, nx, 0, ny)
                -- adjust content area
                local hasTabBar = tabSelBar.Visible and 32 or 0
                contentScroll.Position = UDim2.new(0, 10, 0, 40 + hasTabBar)
                contentScroll.Size     = UDim2.new(1, -20, 1, -(50 + hasTabBar))
            end
        end)
    end

    -- window_data object
    local window_data = {}
    local tabCount = 0
    local dropdown_open = false

    ----------------------------------------------------------------
    -- AddTab
    ----------------------------------------------------------------
    function window_data:AddTab(tabName)
        tabCount   = tabCount + 1
        local tIdx = tabCount
        tabName    = tostring(tabName or "Tab")

        tabSelBar.Visible = true

        -- Tab button
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name                 = "TabBtn_" .. tIdx
        tabBtn.BackgroundColor3     = active_theme.surface2
        tabBtn.BackgroundTransparency = 1
        tabBtn.BorderSizePixel      = 0
        tabBtn.AutoButtonColor      = false
        tabBtn.Size                 = UDim2.new(0, 80, 0, 26)
        tabBtn.ZIndex               = wIdx * 10 + 5
        tabBtn.Font                 = ui_options.font
        tabBtn.Text                 = tabName
        tabBtn.TextColor3           = active_theme.text_dim
        tabBtn.TextSize             = 13
        tabBtn.Parent               = tabScrollFrame
        AddCorner(tabBtn, UDim.new(0, 5))

        -- Auto-width
        task.defer(function()
            local ts = game:GetService("TextService")
            local sz = ts:GetTextSize(tabName, 13, ui_options.font, Vector2.new(9999, 9999))
            tabBtn.Size = UDim2.new(0, sz.X + 20, 0, 26)
            tabScrollFrame.CanvasSize = UDim2.new(0, tabBtnsLayout.AbsoluteContentSize.X + 8, 0, 0)
        end)

        -- Tab content frame
        local tabFrame = Instance.new("Frame")
        tabFrame.Name                 = "Tab_" .. tIdx
        tabFrame.BackgroundTransparency = 1
        tabFrame.Size                 = UDim2.new(1, 0, 1, 0)
        tabFrame.ZIndex               = wIdx * 10 + 2
        tabFrame.Visible              = false
        tabFrame.Parent               = contentScroll

        local tabLayout = Instance.new("UIListLayout")
        tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabLayout.Padding   = UDim.new(0, 6)
        tabLayout.Parent    = tabFrame

        -- When this tab's content changes size
        tabLayout.Changed:Connect(function(prop)
            if prop == "AbsoluteContentSize" then
                contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 12)
            end
        end)

        local tab_data = {}
        local isActive = false

        local function showTab()
            -- Hide all tabs
            for _, child in ipairs(contentScroll:GetChildren()) do
                if child:IsA("Frame") then child.Visible = false end
            end
            -- Dim all tab buttons
            for _, child in ipairs(tabScrollFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextColor3 = active_theme.text_dim
                    child.BackgroundTransparency = 1
                end
            end
            tabFrame.Visible = true
            contentScroll.Visible = true
            tabBtn.TextColor3 = active_theme.text
            tabBtn.BackgroundTransparency = 0.7
            isActive = true
            -- Update canvas
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 12)
        end

        tabBtn.MouseButton1Click:Connect(showTab)

        function tab_data:Show() showTab() end

        -- First tab auto-shown
        if tabCount == 1 then
            task.defer(showTab)
        end

        -- Tab hover effects
        tabBtn.MouseEnter:Connect(function()
            if not isActive then
                Tween(tabBtn, {TextColor3 = active_theme.text}, 0.1)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if tabBtn.TextColor3 ~= active_theme.text or not isActive then
                Tween(tabBtn, {TextColor3 = active_theme.text_dim}, 0.1)
            end
        end)

        local function addToTab(element, height)
            element.Parent = tabFrame
            if height then
                element.Size = UDim2.new(1, 0, 0, height)
            end
            return element
        end

        ------------------------------------------------------------
        -- Label
        ------------------------------------------------------------
        function tab_data:AddLabel(text, tooltip)
            text = tostring(text or "Label")
            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size        = UDim2.new(1, 0, 0, 20)
            lbl.ZIndex      = wIdx * 10 + 3
            lbl.Font        = ui_options.font_small
            lbl.Text        = text
            lbl.TextColor3  = active_theme.text_dim
            lbl.TextSize    = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent      = tabFrame
            if tooltip then attachTooltip(lbl, tooltip) end

            local lbl_data = {}
            function lbl_data:Set(t) lbl.Text = tostring(t) end
            function lbl_data:SetColor(c) lbl.TextColor3 = c end
            return lbl_data, lbl
        end

        ------------------------------------------------------------
        -- Separator
        ------------------------------------------------------------
        function tab_data:AddSeparator(labelText)
            local sep = Instance.new("Frame")
            sep.BackgroundTransparency = 1
            sep.Size        = UDim2.new(1, 0, 0, 18)
            sep.ZIndex      = wIdx * 10 + 2
            sep.Parent      = tabFrame

            local line = Instance.new("Frame")
            line.BackgroundColor3 = active_theme.border
            line.BorderSizePixel  = 0
            line.AnchorPoint      = Vector2.new(0, 0.5)
            line.Position         = UDim2.new(0, 0, 0.5, 0)
            line.Size             = UDim2.new(1, 0, 0, 1)
            line.ZIndex           = wIdx * 10 + 3
            line.Parent           = sep

            if labelText then
                local ts = game:GetService("TextService")
                local w  = ts:GetTextSize(labelText, 11, ui_options.font, Vector2.new(9999, 9999)).X
                local lbl = Instance.new("TextLabel")
                lbl.BackgroundColor3     = active_theme.bg
                lbl.BackgroundTransparency = 0
                lbl.BorderSizePixel      = 0
                lbl.AnchorPoint          = Vector2.new(0, 0.5)
                lbl.Position             = UDim2.new(0, 8, 0.5, 0)
                lbl.Size                 = UDim2.new(0, w + 12, 0, 14)
                lbl.ZIndex               = wIdx * 10 + 4
                lbl.Font                 = ui_options.font
                lbl.Text                 = labelText
                lbl.TextColor3           = active_theme.text_dim
                lbl.TextSize             = 11
                lbl.Parent               = sep
            end
            return sep
        end

        ------------------------------------------------------------
        -- Button
        ------------------------------------------------------------
        function tab_data:AddButton(text, callback, tooltip)
            text     = tostring(text or "Button")
            callback = typeof(callback) == "function" and callback or function() end

            local btn = Instance.new("TextButton")
            btn.BackgroundColor3     = active_theme.surface2
            btn.BorderSizePixel      = 0
            btn.AutoButtonColor      = false
            btn.Size                 = UDim2.new(1, 0, 0, 32)
            btn.ZIndex               = wIdx * 10 + 3
            btn.Font                 = ui_options.font
            btn.Text                 = text
            btn.TextColor3           = active_theme.text
            btn.TextSize             = 14
            btn.Parent               = tabFrame
            AddCorner(btn)
            AddStroke(btn, active_theme.border, 1)

            -- Hover gradient overlay
            local hoverOverlay = Instance.new("Frame")
            hoverOverlay.BackgroundColor3     = Color3.fromRGB(255, 255, 255)
            hoverOverlay.BackgroundTransparency = 1
            hoverOverlay.BorderSizePixel      = 0
            hoverOverlay.Size                 = UDim2.new(1, 0, 1, 0)
            hoverOverlay.ZIndex               = wIdx * 10 + 2
            hoverOverlay.Parent               = btn
            AddCorner(hoverOverlay)

            btn.MouseEnter:Connect(function()
                Tween(btn, {BackgroundColor3 = active_theme.surface}, 0.1)
                Tween(hoverOverlay, {BackgroundTransparency = 0.95}, 0.1)
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, {BackgroundColor3 = active_theme.surface2}, 0.1)
                Tween(hoverOverlay, {BackgroundTransparency = 1}, 0.1)
            end)
            btn.MouseButton1Down:Connect(function()
                Tween(btn, {BackgroundColor3 = active_theme.surface}, 0.06)
            end)
            btn.MouseButton1Click:Connect(function()
                ripple(btn, mouse.X, mouse.Y)
                Tween(btn, {BackgroundColor3 = active_theme.surface2}, 0.15)
                pcall(callback)
            end)
            if tooltip then attachTooltip(btn, tooltip) end

            local btn_data = {}
            function btn_data:SetText(t) btn.Text = tostring(t) end
            function btn_data:SetEnabled(b)
                btn.Active = b
                btn.TextTransparency = b and 0 or 0.5
            end
            return btn_data, btn
        end

        ------------------------------------------------------------
        -- Switch (Toggle)
        ------------------------------------------------------------
        function tab_data:AddSwitch(text, callback, defaultVal, tooltip)
            text     = tostring(text or "Toggle")
            callback = typeof(callback) == "function" and callback or function() end
            defaultVal = (defaultVal == true)

            local sw = Instance.new("Frame")
            sw.BackgroundTransparency = 1
            sw.Size        = UDim2.new(1, 0, 0, 30)
            sw.ZIndex      = wIdx * 10 + 3
            sw.Parent      = tabFrame

            local swLabel = Instance.new("TextLabel")
            swLabel.BackgroundTransparency = 1
            swLabel.AnchorPoint          = Vector2.new(0, 0.5)
            swLabel.Position             = UDim2.new(0, 0, 0.5, 0)
            swLabel.Size                 = UDim2.new(1, -52, 0, 20)
            swLabel.ZIndex               = wIdx * 10 + 3
            swLabel.Font                 = ui_options.font
            swLabel.Text                 = text
            swLabel.TextColor3           = active_theme.text
            swLabel.TextSize             = 14
            swLabel.TextXAlignment       = Enum.TextXAlignment.Left
            swLabel.Parent               = sw

            local track = Instance.new("Frame")
            track.BackgroundColor3 = active_theme.surface2
            track.BorderSizePixel  = 0
            track.AnchorPoint      = Vector2.new(1, 0.5)
            track.Position         = UDim2.new(1, 0, 0.5, 0)
            track.Size             = UDim2.new(0, 36, 0, 20)
            track.ZIndex           = wIdx * 10 + 4
            track.Parent           = sw
            AddCorner(track, UDim.new(1, 0))
            AddStroke(track, active_theme.border, 1)

            local thumb = Instance.new("Frame")
            thumb.BackgroundColor3 = active_theme.text_dim
            thumb.BorderSizePixel  = 0
            thumb.AnchorPoint      = Vector2.new(0, 0.5)
            thumb.Position         = UDim2.new(0, 2, 0.5, 0)
            thumb.Size             = UDim2.new(0, 16, 0, 16)
            thumb.ZIndex           = wIdx * 10 + 5
            thumb.Parent           = track
            AddCorner(thumb, UDim.new(1, 0))

            local hitbox = Instance.new("TextButton")
            hitbox.BackgroundTransparency = 1
            hitbox.BorderSizePixel        = 0
            hitbox.Size                   = UDim2.new(1, 0, 1, 0)
            hitbox.ZIndex                 = wIdx * 10 + 6
            hitbox.Text                   = ""
            hitbox.Parent                 = sw

            local toggled = false
            local switch_data = {}

            local function applyState(state, fire)
                toggled = state
                if state then
                    Tween(track, {BackgroundColor3 = options.main_color}, 0.15)
                    Tween(thumb, {Position = UDim2.new(1, -18, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.18, Enum.EasingStyle.Spring)
                else
                    Tween(track, {BackgroundColor3 = active_theme.surface2}, 0.15)
                    Tween(thumb, {Position = UDim2.new(0, 2, 0.5, 0), BackgroundColor3 = active_theme.text_dim}, 0.18, Enum.EasingStyle.Spring)
                end
                if fire then pcall(callback, toggled) end
            end

            hitbox.MouseButton1Click:Connect(function()
                applyState(not toggled, true)
                ripple(sw, mouse.X, mouse.Y)
            end)

            function switch_data:Set(b, fireCallback)
                applyState((typeof(b) == "boolean") and b or false, (fireCallback ~= false))
            end
            function switch_data:Get() return toggled end

            applyState(defaultVal, false)
            if tooltip then attachTooltip(hitbox, tooltip) end
            return switch_data, sw
        end

        ------------------------------------------------------------
        -- Slider
        ------------------------------------------------------------
        function tab_data:AddSlider(text, callback, sliderOpts, tooltip)
            text     = tostring(text or "Slider")
            callback = typeof(callback) == "function" and callback or function() end
            sliderOpts = typeof(sliderOpts) == "table" and sliderOpts or {}
            local sMin  = tonumber(sliderOpts.min)      or 0
            local sMax  = tonumber(sliderOpts.max)      or 100
            local sStep = math.max(tonumber(sliderOpts.step) or 1, 0.0001)  -- guard: step must be > 0
            local sDef  = tonumber(sliderOpts.default)  or sMin
            local sRO   = (sliderOpts.readonly == true)
            -- Guard: ensure range is valid to prevent divide-by-zero
            if sMax <= sMin then sMax = sMin + 1 end

            local sliderFrame = Instance.new("Frame")
            sliderFrame.BackgroundTransparency = 1
            sliderFrame.Size   = UDim2.new(1, 0, 0, 48)
            sliderFrame.ZIndex = wIdx * 10 + 3
            sliderFrame.Parent = tabFrame

            local titleLabel = Instance.new("TextLabel")
            titleLabel.BackgroundTransparency = 1
            titleLabel.Size        = UDim2.new(1, -60, 0, 18)
            titleLabel.ZIndex      = wIdx * 10 + 3
            titleLabel.Font        = ui_options.font
            titleLabel.Text        = text
            titleLabel.TextColor3  = active_theme.text
            titleLabel.TextSize    = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent      = sliderFrame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.BackgroundTransparency = 1
            valueLabel.AnchorPoint    = Vector2.new(1, 0)
            valueLabel.Position       = UDim2.new(1, 0, 0, 0)
            valueLabel.Size           = UDim2.new(0, 55, 0, 18)
            valueLabel.ZIndex         = wIdx * 10 + 3
            valueLabel.Font           = ui_options.font_bold
            valueLabel.Text           = tostring(sDef)
            valueLabel.TextColor3     = options.main_color
            valueLabel.TextSize       = 14
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent         = sliderFrame

            local track = Instance.new("Frame")
            track.BackgroundColor3 = active_theme.surface2
            track.BorderSizePixel  = 0
            track.Position         = UDim2.new(0, 0, 0, 26)
            track.Size             = UDim2.new(1, 0, 0, 6)
            track.ZIndex           = wIdx * 10 + 3
            track.Parent           = sliderFrame
            AddCorner(track, UDim.new(1, 0))
            AddStroke(track, active_theme.border, 1)

            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = options.main_color
            fill.BorderSizePixel  = 0
            fill.Size             = UDim2.new(0, 0, 1, 0)
            fill.ZIndex           = wIdx * 10 + 4
            fill.Parent           = track
            AddCorner(fill, UDim.new(1, 0))

            local handle = Instance.new("Frame")
            handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            handle.BorderSizePixel  = 0
            handle.AnchorPoint      = Vector2.new(0.5, 0.5)
            handle.Position         = UDim2.new(0, 0, 0.5, 0)
            handle.Size             = UDim2.new(0, 14, 0, 14)
            handle.ZIndex           = wIdx * 10 + 6
            handle.Parent           = track
            AddCorner(handle, UDim.new(1, 0))
            AddStroke(handle, active_theme.border, 1.5)

            -- Value tooltip on handle
            attachTooltip(handle, text .. " (drag to adjust)")

            local hitbox = Instance.new("TextButton")
            hitbox.BackgroundTransparency = 1
            hitbox.BorderSizePixel        = 0
            hitbox.Position               = UDim2.new(0, 0, 0, 22)
            hitbox.Size                   = UDim2.new(1, 0, 0, 16)
            hitbox.ZIndex                 = wIdx * 10 + 5
            hitbox.Text                   = ""
            hitbox.Parent                 = sliderFrame

            local dragging  = false
            local curVal    = sDef
            local slider_data = {}

            local function applyValue(pct)
                pct = math.clamp(pct, 0, 1)
                local raw = sMin + pct * (sMax - sMin)
                local stepped = math.floor(raw / sStep + 0.5) * sStep
                stepped = math.clamp(stepped, sMin, sMax)
                curVal = stepped
                local dispPct = (stepped - sMin) / (sMax - sMin)
                Tween(fill,   {Size     = UDim2.new(dispPct, 0, 1, 0)}, 0.05)
                Tween(handle, {Position = UDim2.new(dispPct, 0, 0.5, 0)}, 0.05)
                valueLabel.Text = tostring(stepped)
                pcall(callback, stepped)
            end

            local function calcPct(inputX)
                local rel = inputX - track.AbsolutePosition.X
                return rel / track.AbsoluteSize.X
            end

            hitbox.InputBegan:Connect(function(inp)
                if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) and not sRO then
                    dragging = true
                    win.Draggable = false
                    applyValue(calcPct(inp.Position.X))
                end
            end)
            UIS.InputChanged:Connect(function(inp)
                if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                    applyValue(calcPct(inp.Position.X))
                end
            end)
            UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        win.Draggable = true
                    end
                end
            end)
            handle.MouseEnter:Connect(function()
                SpringTween(handle, {Size = UDim2.new(0, 18, 0, 18)}, 0.2)
            end)
            handle.MouseLeave:Connect(function()
                if not dragging then
                    SpringTween(handle, {Size = UDim2.new(0, 14, 0, 14)}, 0.2)
                end
            end)

            function slider_data:Set(v, fire)
                v = math.clamp(tonumber(v) or sMin, sMin, sMax)
                local pct = (v - sMin) / (sMax - sMin)
                applyValue(pct)
                if not fire then
                    -- suppress callback already fired in applyValue — just update display
                end
            end
            function slider_data:Get() return curVal end

            slider_data:Set(sDef)
            if tooltip then attachTooltip(hitbox, tooltip) end
            return slider_data, sliderFrame
        end

        ------------------------------------------------------------
        -- ProgressBar
        ------------------------------------------------------------
        function tab_data:AddProgressBar(text, tooltip)
            text = tostring(text or "Progress")
            local pbFrame = Instance.new("Frame")
            pbFrame.BackgroundTransparency = 1
            pbFrame.Size   = UDim2.new(1, 0, 0, 40)
            pbFrame.ZIndex = wIdx * 10 + 3
            pbFrame.Parent = tabFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.BackgroundTransparency = 1
            titleLbl.Size        = UDim2.new(1, -55, 0, 18)
            titleLbl.ZIndex      = wIdx * 10 + 3
            titleLbl.Font        = ui_options.font
            titleLbl.Text        = text
            titleLbl.TextColor3  = active_theme.text
            titleLbl.TextSize    = 14
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.Parent      = pbFrame

            local valLbl = Instance.new("TextLabel")
            valLbl.BackgroundTransparency = 1
            valLbl.AnchorPoint    = Vector2.new(1, 0)
            valLbl.Position       = UDim2.new(1, 0, 0, 0)
            valLbl.Size           = UDim2.new(0, 50, 0, 18)
            valLbl.ZIndex         = wIdx * 10 + 3
            valLbl.Font           = ui_options.font_bold
            valLbl.Text           = "0%"
            valLbl.TextColor3     = options.main_color
            valLbl.TextSize       = 13
            valLbl.TextXAlignment = Enum.TextXAlignment.Right
            valLbl.Parent         = pbFrame

            local pbTrack = Instance.new("Frame")
            pbTrack.BackgroundColor3 = active_theme.surface2
            pbTrack.BorderSizePixel  = 0
            pbTrack.Position         = UDim2.new(0, 0, 0, 24)
            pbTrack.Size             = UDim2.new(1, 0, 0, 8)
            pbTrack.ZIndex           = wIdx * 10 + 3
            pbTrack.Parent           = pbFrame
            AddCorner(pbTrack, UDim.new(1, 0))
            AddStroke(pbTrack, active_theme.border, 1)

            local pbFill = Instance.new("Frame")
            pbFill.BackgroundColor3 = options.main_color
            pbFill.BorderSizePixel  = 0
            pbFill.Size             = UDim2.new(0, 0, 1, 0)
            pbFill.ZIndex           = wIdx * 10 + 4
            pbFill.Parent           = pbTrack
            AddCorner(pbFill, UDim.new(1, 0))

            -- Shimmer effect
            local shimmer = Instance.new("Frame")
            shimmer.BackgroundColor3     = Color3.fromRGB(255, 255, 255)
            shimmer.BackgroundTransparency = 0.7
            shimmer.BorderSizePixel      = 0
            shimmer.Position             = UDim2.new(-0.3, 0, 0, 0)
            shimmer.Size                 = UDim2.new(0.3, 0, 1, 0)
            shimmer.ZIndex               = wIdx * 10 + 5
            shimmer.ClipsDescendants     = false
            shimmer.Parent               = pbFill
            AddCorner(shimmer, UDim.new(1, 0))

            local pb_data = {}
            local curProgress = 0

            local function runShimmer()
                task.spawn(function()
                    while pbFill and pbFill.Parent and curProgress > 0 do
                        Tween(shimmer, {Position = UDim2.new(1.3, 0, 0, 0)}, 1.2, Enum.EasingStyle.Sine)
                        task.wait(1.4)
                        shimmer.Position = UDim2.new(-0.3, 0, 0, 0)
                    end
                end)
            end

            function pb_data:Set(pct, animated)
                pct = math.clamp(tonumber(pct) or 0, 0, 100)
                curProgress = pct
                local frac = pct / 100
                if animated ~= false then
                    Tween(pbFill, {Size = UDim2.new(frac, 0, 1, 0)}, 0.35, Enum.EasingStyle.Quart)
                else
                    pbFill.Size = UDim2.new(frac, 0, 1, 0)
                end
                valLbl.Text = math.floor(pct) .. "%"
                if pct > 0 then runShimmer() end
            end
            function pb_data:Get() return curProgress end
            function pb_data:SetColor(c)
                pbFill.BackgroundColor3 = c
                valLbl.TextColor3 = c
            end

            if tooltip then attachTooltip(pbTrack, tooltip) end
            return pb_data, pbFrame
        end

        ------------------------------------------------------------
        -- TextBox
        ------------------------------------------------------------
        function tab_data:AddTextBox(title, callback, opts, tooltip)
            title    = tostring(title or "Input")
            callback = typeof(callback) == "function" and callback or function() end
            opts     = typeof(opts) == "table" and opts or {}
            local clearOnEnter = (opts.clear ~= false)
            local placeholder  = tostring(opts.placeholder or "Type here...")

            local widget = Instance.new("Frame")
            widget.BackgroundTransparency = 1
            widget.Size   = UDim2.new(1, 0, 0, 48)
            widget.ZIndex = wIdx * 10 + 3
            widget.Parent = tabFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.BackgroundTransparency = 1
            titleLbl.Size        = UDim2.new(1, 0, 0, 18)
            titleLbl.ZIndex      = wIdx * 10 + 3
            titleLbl.Font        = ui_options.font
            titleLbl.Text        = title
            titleLbl.TextColor3  = active_theme.text
            titleLbl.TextSize    = 14
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.Parent      = widget

            local inputBox = Instance.new("TextBox")
            inputBox.BackgroundColor3     = active_theme.surface2
            inputBox.BorderSizePixel      = 0
            inputBox.Position             = UDim2.new(0, 0, 0, 22)
            inputBox.Size                 = UDim2.new(1, 0, 0, 26)
            inputBox.ZIndex               = wIdx * 10 + 3
            inputBox.ClearTextOnFocus     = false
            inputBox.Font                 = ui_options.font_small
            inputBox.PlaceholderColor3    = active_theme.text_dim
            inputBox.PlaceholderText      = placeholder
            inputBox.Text                 = ""
            inputBox.TextColor3           = active_theme.text
            inputBox.TextSize             = 13
            inputBox.TextXAlignment       = Enum.TextXAlignment.Left
            inputBox.Parent               = widget
            AddCorner(inputBox)
            local inputStroke = AddStroke(inputBox, active_theme.border, 1)
            AddPadding(inputBox, 8)

            inputBox.Focused:Connect(function()
                Tween(inputStroke, {Color = options.main_color, Thickness = 1.5}, 0.12)
            end)
            inputBox.FocusLost:Connect(function(enter)
                Tween(inputStroke, {Color = active_theme.border, Thickness = 1}, 0.12)
                if enter and #inputBox.Text > 0 then
                    pcall(callback, inputBox.Text)
                    if clearOnEnter then inputBox.Text = "" end
                end
            end)

            if tooltip then attachTooltip(inputBox, tooltip) end

            local tb_data = {}
            function tb_data:Get() return inputBox.Text end
            function tb_data:Set(t) inputBox.Text = tostring(t) end
            function tb_data:Clear() inputBox.Text = "" end
            return tb_data, widget
        end

        ------------------------------------------------------------
        -- Keybind
        ------------------------------------------------------------
        function tab_data:AddKeybind(name, callback, opts, tooltip)
            name     = tostring(name or "Keybind")
            callback = typeof(callback) == "function" and callback or function() end
            opts     = typeof(opts) == "table" and opts or {}
            local defaultKey = opts.standard or Enum.KeyCode.RightShift

            local widget = Instance.new("Frame")
            widget.BackgroundTransparency = 1
            widget.Size   = UDim2.new(1, 0, 0, 30)
            widget.ZIndex = wIdx * 10 + 3
            widget.Parent = tabFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.BackgroundTransparency = 1
            titleLbl.AnchorPoint    = Vector2.new(0, 0.5)
            titleLbl.Position       = UDim2.new(0, 0, 0.5, 0)
            titleLbl.Size           = UDim2.new(1, -100, 0, 20)
            titleLbl.ZIndex         = wIdx * 10 + 3
            titleLbl.Font           = ui_options.font
            titleLbl.Text           = name
            titleLbl.TextColor3     = active_theme.text
            titleLbl.TextSize       = 14
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.Parent         = widget

            local keyBtn = Instance.new("TextButton")
            keyBtn.BackgroundColor3     = active_theme.surface2
            keyBtn.BorderSizePixel      = 0
            keyBtn.AutoButtonColor      = false
            keyBtn.AnchorPoint          = Vector2.new(1, 0.5)
            keyBtn.Position             = UDim2.new(1, 0, 0.5, 0)
            keyBtn.Size                 = UDim2.new(0, 88, 0, 24)
            keyBtn.ZIndex               = wIdx * 10 + 4
            keyBtn.Font                 = ui_options.font
            keyBtn.Text                 = "None"
            keyBtn.TextColor3           = active_theme.text_dim
            keyBtn.TextSize             = 12
            keyBtn.Parent               = widget
            AddCorner(keyBtn)
            local keyStroke = AddStroke(keyBtn, active_theme.border, 1)

            local shortkeys = {
                RightControl  = "RCtrl",
                LeftControl   = "LCtrl",
                LeftShift     = "LShift",
                RightShift    = "RShift",
                MouseButton1  = "Mouse1",
                MouseButton2  = "Mouse2",
            }

            local currentKey = defaultKey
            local keybind_data = {}

            local function setKey(k)
                currentKey = k
                keyBtn.Text = shortkeys[k.Name] or k.Name
                keyBtn.TextColor3 = active_theme.text
            end

            keyBtn.MouseButton1Click:Connect(function()
                if checks.binding then return end
                checks.binding = true
                keyBtn.Text      = "..."
                keyBtn.TextColor3 = options.main_color
                Tween(keyStroke, {Color = options.main_color}, 0.1)
                local inp = UIS.InputBegan:Wait()
                setKey(inp.KeyCode)
                checks.binding = false
                Tween(keyStroke, {Color = active_theme.border}, 0.1)
            end)

            UIS.InputBegan:Connect(function(inp, gp)
                if gp or checks.binding then return end
                if inp.KeyCode == currentKey then
                    pcall(callback, currentKey)
                end
            end)

            function keybind_data:Set(k) setKey(k) end
            function keybind_data:Get() return currentKey end

            setKey(defaultKey)
            if tooltip then attachTooltip(keyBtn, tooltip) end
            return keybind_data, widget
        end

        ------------------------------------------------------------
        -- Dropdown
        ------------------------------------------------------------
        function tab_data:AddDropdown(name, callback, tooltip)
            name     = tostring(name or "Dropdown")
            callback = typeof(callback) == "function" and callback or function() end

            local ddFrame = Instance.new("Frame")
            ddFrame.BackgroundTransparency = 1
            ddFrame.Size   = UDim2.new(1, 0, 0, 32)
            ddFrame.ZIndex = wIdx * 10 + 3
            ddFrame.Parent = tabFrame

            local ddBtn = Instance.new("TextButton")
            ddBtn.BackgroundColor3     = active_theme.surface2
            ddBtn.BorderSizePixel      = 0
            ddBtn.AutoButtonColor      = false
            ddBtn.Size                 = UDim2.new(1, 0, 0, 32)
            ddBtn.ZIndex               = wIdx * 10 + 3
            ddBtn.Text                 = ""
            ddBtn.Parent               = ddFrame
            AddCorner(ddBtn)
            AddStroke(ddBtn, active_theme.border, 1)

            local ddLabel = Instance.new("TextLabel")
            ddLabel.BackgroundTransparency = 1
            ddLabel.Position             = UDim2.new(0, 10, 0, 0)
            ddLabel.Size                 = UDim2.new(1, -34, 1, 0)
            ddLabel.ZIndex               = wIdx * 10 + 4
            ddLabel.Font                 = ui_options.font
            ddLabel.Text                 = name
            ddLabel.TextColor3           = active_theme.text_dim
            ddLabel.TextSize             = 13
            ddLabel.TextXAlignment       = Enum.TextXAlignment.Left
            ddLabel.Parent               = ddFrame

            local arrow = Instance.new("TextLabel")
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint            = Vector2.new(1, 0.5)
            arrow.Position               = UDim2.new(1, -8, 0.5, 0)
            arrow.Size                   = UDim2.new(0, 18, 0, 18)
            arrow.ZIndex                 = wIdx * 10 + 4
            arrow.Font                   = ui_options.font_bold
            arrow.Text                   = "▾"
            arrow.TextColor3             = active_theme.text_dim
            arrow.TextSize               = 14
            arrow.Parent                 = ddFrame

            local ddBox = Instance.new("Frame")
            ddBox.BackgroundColor3 = active_theme.surface
            ddBox.BorderSizePixel  = 0
            ddBox.ClipsDescendants = true
            ddBox.Position         = UDim2.new(0, 0, 0, 34)
            ddBox.Size             = UDim2.new(1, 0, 0, 0)
            ddBox.ZIndex           = wIdx * 10 + 18
            ddBox.Parent           = ddFrame
            AddCorner(ddBox)
            AddStroke(ddBox, active_theme.border, 1)

            local ddScroll = Instance.new("ScrollingFrame")
            ddScroll.BackgroundTransparency = 1
            ddScroll.BorderSizePixel        = 0
            ddScroll.Size                   = UDim2.new(1, 0, 1, 0)
            ddScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
            ddScroll.ScrollBarThickness     = 3
            ddScroll.ScrollBarImageColor3   = active_theme.border
            ddScroll.ZIndex                 = wIdx * 10 + 19
            ddScroll.Parent                 = ddBox

            local ddLayout = Instance.new("UIListLayout")
            ddLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ddLayout.Parent    = ddScroll

            local isOpen = false
            local selected = nil
            local dd_data = {}

            local function toggleOpen()
                isOpen = not isOpen
                if isOpen then
                    if dropdown_open then isOpen = false; return end
                    dropdown_open = true
                    local itemCount = 0
                    for _, c in ipairs(ddScroll:GetChildren()) do
                        if not c:IsA("UIListLayout") then itemCount = itemCount + 1 end
                    end
                    local h = math.min(itemCount * 28, 140)
                    Tween(ddBox,  {Size = UDim2.new(1, 0, 0, h)}, 0.2)
                    Tween(arrow,  {Rotation = 180}, 0.2)
                    ddScroll.CanvasSize = UDim2.new(0, 0, 0, itemCount * 28)
                else
                    dropdown_open = false
                    Tween(ddBox,  {Size = UDim2.new(1, 0, 0, 0)}, 0.15)
                    Tween(arrow,  {Rotation = 0}, 0.15)
                end
            end

            ddBtn.MouseButton1Click:Connect(toggleOpen)
            if tooltip then attachTooltip(ddBtn, tooltip) end

            function dd_data:Add(itemName)
                local item_data = {}
                itemName = tostring(itemName or "Option")
                local item = Instance.new("TextButton")
                item.BackgroundColor3     = active_theme.surface
                item.BorderSizePixel      = 0
                item.AutoButtonColor      = false
                item.Size                 = UDim2.new(1, 0, 0, 28)
                item.ZIndex               = wIdx * 10 + 20
                item.Font                 = ui_options.font_small
                item.Text                 = itemName
                item.TextColor3           = active_theme.text
                item.TextSize             = 13
                item.TextXAlignment       = Enum.TextXAlignment.Left
                item.Parent               = ddScroll
                AddPadding(item, 8)

                item.MouseEnter:Connect(function()
                    Tween(item, {BackgroundColor3 = active_theme.surface2}, 0.08)
                end)
                item.MouseLeave:Connect(function()
                    Tween(item, {BackgroundColor3 = active_theme.surface}, 0.08)
                end)
                item.MouseButton1Click:Connect(function()
                    selected = itemName
                    ddLabel.Text = itemName
                    ddLabel.TextColor3 = active_theme.text
                    toggleOpen()
                    pcall(callback, itemName)
                end)
                function item_data:Remove() item:Destroy() end
                return item, item_data
            end

            function dd_data:GetSelected() return selected end
            function dd_data:SetSelected(n)
                selected = n
                ddLabel.Text = tostring(n)
                ddLabel.TextColor3 = active_theme.text
            end
            function dd_data:Clear()
                for _, c in ipairs(ddScroll:GetChildren()) do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end
                selected = nil
                ddLabel.Text = name
                ddLabel.TextColor3 = active_theme.text_dim
            end

            return dd_data, ddFrame
        end

        ------------------------------------------------------------
        -- MultiDropdown
        ------------------------------------------------------------
        function tab_data:AddMultiDropdown(name, callback, tooltip)
            name     = tostring(name or "Multi Dropdown")
            callback = typeof(callback) == "function" and callback or function() end

            local ddFrame = Instance.new("Frame")
            ddFrame.BackgroundTransparency = 1
            ddFrame.Size   = UDim2.new(1, 0, 0, 32)
            ddFrame.ZIndex = wIdx * 10 + 3
            ddFrame.Parent = tabFrame

            local ddBtn = Instance.new("TextButton")
            ddBtn.BackgroundColor3     = active_theme.surface2
            ddBtn.BorderSizePixel      = 0
            ddBtn.AutoButtonColor      = false
            ddBtn.Size                 = UDim2.new(1, 0, 0, 32)
            ddBtn.ZIndex               = wIdx * 10 + 3
            ddBtn.Text                 = ""
            ddBtn.Parent               = ddFrame
            AddCorner(ddBtn)
            AddStroke(ddBtn, active_theme.border, 1)

            local ddLabel = Instance.new("TextLabel")
            ddLabel.BackgroundTransparency = 1
            ddLabel.Position             = UDim2.new(0, 10, 0, 0)
            ddLabel.Size                 = UDim2.new(1, -34, 1, 0)
            ddLabel.ZIndex               = wIdx * 10 + 4
            ddLabel.Font                 = ui_options.font
            ddLabel.Text                 = name
            ddLabel.TextColor3           = active_theme.text_dim
            ddLabel.TextSize             = 13
            ddLabel.TextXAlignment       = Enum.TextXAlignment.Left
            ddLabel.Parent               = ddFrame

            local arrow = Instance.new("TextLabel")
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint            = Vector2.new(1, 0.5)
            arrow.Position               = UDim2.new(1, -8, 0.5, 0)
            arrow.Size                   = UDim2.new(0, 18, 0, 18)
            arrow.ZIndex                 = wIdx * 10 + 4
            arrow.Font                   = ui_options.font_bold
            arrow.Text                   = "▾"
            arrow.TextColor3             = active_theme.text_dim
            arrow.TextSize               = 14
            arrow.Parent                 = ddFrame

            local ddBox = Instance.new("Frame")
            ddBox.BackgroundColor3 = active_theme.surface
            ddBox.BorderSizePixel  = 0
            ddBox.ClipsDescendants = true
            ddBox.Position         = UDim2.new(0, 0, 0, 34)
            ddBox.Size             = UDim2.new(1, 0, 0, 0)
            ddBox.ZIndex           = wIdx * 10 + 18
            ddBox.Parent           = ddFrame
            AddCorner(ddBox)
            AddStroke(ddBox, active_theme.border, 1)

            local ddScroll = Instance.new("ScrollingFrame")
            ddScroll.BackgroundTransparency = 1
            ddScroll.BorderSizePixel        = 0
            ddScroll.Size                   = UDim2.new(1, 0, 1, 0)
            ddScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
            ddScroll.ScrollBarThickness     = 3
            ddScroll.ScrollBarImageColor3   = active_theme.border
            ddScroll.ZIndex                 = wIdx * 10 + 19
            ddScroll.Parent                 = ddBox

            local ddLayout = Instance.new("UIListLayout")
            ddLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ddLayout.Parent    = ddScroll

            local isOpen = false
            local selected = {}
            local mdd_data = {}

            local function updateLabel()
                local count = 0
                local first = nil
                for k in pairs(selected) do count = count + 1; if not first then first = k end end
                if count == 0 then
                    ddLabel.Text = name; ddLabel.TextColor3 = active_theme.text_dim
                elseif count == 1 then
                    ddLabel.Text = first; ddLabel.TextColor3 = active_theme.text
                else
                    ddLabel.Text = count .. " selected"; ddLabel.TextColor3 = active_theme.text
                end
            end

            local function toggleOpen()
                isOpen = not isOpen
                if isOpen then
                    if dropdown_open then isOpen = false; return end
                    dropdown_open = true
                    local ic = 0
                    for _, c in ipairs(ddScroll:GetChildren()) do if not c:IsA("UIListLayout") then ic = ic + 1 end end
                    local h = math.min(ic * 28, 140)
                    Tween(ddBox, {Size = UDim2.new(1, 0, 0, h)}, 0.2)
                    Tween(arrow, {Rotation = 180}, 0.2)
                    ddScroll.CanvasSize = UDim2.new(0, 0, 0, ic * 28)
                else
                    dropdown_open = false
                    Tween(ddBox, {Size = UDim2.new(1, 0, 0, 0)}, 0.15)
                    Tween(arrow, {Rotation = 0}, 0.15)
                end
            end

            ddBtn.MouseButton1Click:Connect(toggleOpen)

            function mdd_data:Add(itemName)
                local obj_data = {}
                itemName = tostring(itemName or "Option")
                local item = Instance.new("Frame")
                item.BackgroundColor3 = active_theme.surface
                item.BorderSizePixel  = 0
                item.Size             = UDim2.new(1, 0, 0, 28)
                item.ZIndex           = wIdx * 10 + 20
                item.Parent           = ddScroll

                local check = Instance.new("Frame")
                check.BackgroundColor3     = active_theme.surface2
                check.BorderSizePixel      = 0
                check.AnchorPoint          = Vector2.new(0, 0.5)
                check.Position             = UDim2.new(0, 8, 0.5, 0)
                check.Size                 = UDim2.new(0, 14, 0, 14)
                check.ZIndex               = wIdx * 10 + 21
                check.Parent               = item
                AddCorner(check, UDim.new(0, 3))
                AddStroke(check, active_theme.border, 1)

                local checkMark = Instance.new("TextLabel")
                checkMark.BackgroundTransparency = 1
                checkMark.Size                   = UDim2.new(1, 0, 1, 0)
                checkMark.ZIndex                 = wIdx * 10 + 22
                checkMark.Font                   = ui_options.font_bold
                checkMark.Text                   = ""
                checkMark.TextColor3             = Color3.fromRGB(255, 255, 255)
                checkMark.TextSize               = 10
                checkMark.Parent                 = check

                local lbl = Instance.new("TextLabel")
                lbl.BackgroundTransparency = 1
                lbl.Position             = UDim2.new(0, 30, 0, 0)
                lbl.Size                 = UDim2.new(1, -38, 1, 0)
                lbl.ZIndex               = wIdx * 10 + 21
                lbl.Font                 = ui_options.font_small
                lbl.Text                 = itemName
                lbl.TextColor3           = active_theme.text
                lbl.TextSize             = 13
                lbl.TextXAlignment       = Enum.TextXAlignment.Left
                lbl.Parent               = item

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.BorderSizePixel        = 0
                hit.Size                   = UDim2.new(1, 0, 1, 0)
                hit.ZIndex                 = wIdx * 10 + 23
                hit.Text                   = ""
                hit.Parent                 = item

                hit.MouseEnter:Connect(function() Tween(item, {BackgroundColor3 = active_theme.surface2}, 0.08) end)
                hit.MouseLeave:Connect(function() Tween(item, {BackgroundColor3 = active_theme.surface}, 0.08) end)
                hit.MouseButton1Click:Connect(function()
                    if selected[itemName] then
                        selected[itemName] = nil
                        checkMark.Text = ""
                        Tween(check, {BackgroundColor3 = active_theme.surface2}, 0.1)
                    else
                        selected[itemName] = true
                        checkMark.Text = "✓"
                        Tween(check, {BackgroundColor3 = options.main_color}, 0.1)
                    end
                    updateLabel()
                    pcall(callback, selected)
                end)

                function obj_data:Remove()
                    selected[itemName] = nil
                    item:Destroy()
                    updateLabel()
                end
                return item, obj_data
            end

            function mdd_data:GetSelected() return selected end
            function mdd_data:Clear()
                selected = {}
                updateLabel()
                for _, c in ipairs(ddScroll:GetChildren()) do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end
            end

            if tooltip then attachTooltip(ddBtn, tooltip) end
            return mdd_data, ddFrame
        end

        ------------------------------------------------------------
        -- RadioGroup
        ------------------------------------------------------------
        function tab_data:AddRadioGroup(name, items, callback, tooltip)
            name     = tostring(name or "Radio Group")
            items    = typeof(items) == "table" and items or {}
            callback = typeof(callback) == "function" and callback or function() end

            local rgFrame = Instance.new("Frame")
            rgFrame.BackgroundTransparency = 1
            rgFrame.Size   = UDim2.new(1, 0, 0, 20 + #items * 28)
            rgFrame.ZIndex = wIdx * 10 + 3
            rgFrame.Parent = tabFrame

            local groupTitle = Instance.new("TextLabel")
            groupTitle.BackgroundTransparency = 1
            groupTitle.Size        = UDim2.new(1, 0, 0, 18)
            groupTitle.ZIndex      = wIdx * 10 + 3
            groupTitle.Font        = ui_options.font
            groupTitle.Text        = name
            groupTitle.TextColor3  = active_theme.text
            groupTitle.TextSize    = 14
            groupTitle.TextXAlignment = Enum.TextXAlignment.Left
            groupTitle.Parent      = rgFrame

            local rg_data = {}
            local selected = nil
            local radioList = {}

            for i, itemName in ipairs(items) do
                local row = Instance.new("Frame")
                row.BackgroundTransparency = 1
                row.Position = UDim2.new(0, 0, 0, 20 + (i - 1) * 28)
                row.Size     = UDim2.new(1, 0, 0, 24)
                row.ZIndex   = wIdx * 10 + 3
                row.Parent   = rgFrame

                local outer = Instance.new("Frame")
                outer.BackgroundColor3 = active_theme.surface2
                outer.BorderSizePixel  = 0
                outer.AnchorPoint      = Vector2.new(0, 0.5)
                outer.Position         = UDim2.new(0, 0, 0.5, 0)
                outer.Size             = UDim2.new(0, 18, 0, 18)
                outer.ZIndex           = wIdx * 10 + 4
                outer.Parent           = row
                AddCorner(outer, UDim.new(1, 0))
                AddStroke(outer, active_theme.border, 1.5)

                local inner = Instance.new("Frame")
                inner.BackgroundColor3     = options.main_color
                inner.BackgroundTransparency = 1
                inner.BorderSizePixel      = 0
                inner.AnchorPoint          = Vector2.new(0.5, 0.5)
                inner.Position             = UDim2.new(0.5, 0, 0.5, 0)
                inner.Size                 = UDim2.new(0, 10, 0, 10)
                inner.ZIndex               = wIdx * 10 + 5
                inner.Parent               = outer
                AddCorner(inner, UDim.new(1, 0))

                local rowLabel = Instance.new("TextLabel")
                rowLabel.BackgroundTransparency = 1
                rowLabel.Position       = UDim2.new(0, 26, 0, 0)
                rowLabel.Size           = UDim2.new(1, -26, 1, 0)
                rowLabel.ZIndex         = wIdx * 10 + 4
                rowLabel.Font           = ui_options.font
                rowLabel.Text           = tostring(itemName)
                rowLabel.TextColor3     = active_theme.text
                rowLabel.TextSize       = 13
                rowLabel.TextXAlignment = Enum.TextXAlignment.Left
                rowLabel.Parent         = row

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.BorderSizePixel        = 0
                hit.Size                   = UDim2.new(1, 0, 1, 0)
                hit.ZIndex                 = wIdx * 10 + 6
                hit.Text                   = ""
                hit.Parent                 = row

                local function select(n)
                    selected = n
                    for _, rd in ipairs(radioList) do
                        local isThis = (rd.name == n)
                        Tween(rd.inner, {BackgroundTransparency = isThis and 0 or 1}, 0.15)
                        Tween(rd.outer, {BackgroundColor3 = isThis and active_theme.surface or active_theme.surface2}, 0.15)
                        -- Reuse the existing UIStroke instead of stacking new ones
                        if rd.stroke then
                            rd.stroke.Color     = isThis and options.main_color or active_theme.border
                            rd.stroke.Thickness = isThis and 1.5 or 1
                        end
                    end
                    pcall(callback, n)
                end

                hit.MouseButton1Click:Connect(function() select(itemName) end)
                -- Capture the UIStroke reference so we can update it on selection instead of stacking new ones
                local outerStroke = outer:FindFirstChildOfClass("UIStroke")
                table.insert(radioList, {name = itemName, outer = outer, inner = inner, stroke = outerStroke})
            end

            function rg_data:GetSelected() return selected end
            function rg_data:SetSelected(n)
                for _, rd in ipairs(radioList) do
                    local isThis = (rd.name == n)
                    rd.inner.BackgroundTransparency = isThis and 0 or 1
                    rd.outer.BackgroundColor3 = isThis and active_theme.surface or active_theme.surface2
                end
                selected = n
            end

            if tooltip then attachTooltip(rgFrame, tooltip) end
            return rg_data, rgFrame
        end

        ------------------------------------------------------------
        -- NumberStepper
        ------------------------------------------------------------
        function tab_data:AddNumberStepper(name, callback, opts, tooltip)
            name     = tostring(name or "Number")
            callback = typeof(callback) == "function" and callback or function() end
            opts     = typeof(opts) == "table" and opts or {}
            local nMin  = tonumber(opts.min)     or 0
            local nMax  = tonumber(opts.max)     or 100
            local nStep = tonumber(opts.step)    or 1
            local nDef  = tonumber(opts.default) or nMin

            local nsFrame = Instance.new("Frame")
            nsFrame.BackgroundTransparency = 1
            nsFrame.Size   = UDim2.new(1, 0, 0, 32)
            nsFrame.ZIndex = wIdx * 10 + 3
            nsFrame.Parent = tabFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.BackgroundTransparency = 1
            titleLbl.AnchorPoint          = Vector2.new(0, 0.5)
            titleLbl.Position             = UDim2.new(0, 0, 0.5, 0)
            titleLbl.Size                 = UDim2.new(1, -130, 0, 20)
            titleLbl.ZIndex               = wIdx * 10 + 3
            titleLbl.Font                 = ui_options.font
            titleLbl.Text                 = name
            titleLbl.TextColor3           = active_theme.text
            titleLbl.TextSize             = 14
            titleLbl.TextXAlignment       = Enum.TextXAlignment.Left
            titleLbl.Parent               = nsFrame

            local minusBtn = Instance.new("TextButton")
            minusBtn.BackgroundColor3     = active_theme.surface2
            minusBtn.BorderSizePixel      = 0
            minusBtn.AutoButtonColor      = false
            minusBtn.AnchorPoint          = Vector2.new(1, 0.5)
            minusBtn.Position             = UDim2.new(1, -44, 0.5, 0)
            minusBtn.Size                 = UDim2.new(0, 28, 0, 28)
            minusBtn.Font                 = ui_options.font_bold
            minusBtn.Text                 = "−"
            minusBtn.TextColor3           = active_theme.text
            minusBtn.TextSize             = 16
            minusBtn.ZIndex               = wIdx * 10 + 4
            minusBtn.Parent               = nsFrame
            AddCorner(minusBtn, UDim.new(0, 5))
            AddStroke(minusBtn, active_theme.border, 1)

            local valLabel = Instance.new("TextLabel")
            valLabel.BackgroundColor3     = active_theme.surface2
            valLabel.BorderSizePixel      = 0
            valLabel.AnchorPoint          = Vector2.new(1, 0.5)
            valLabel.Position             = UDim2.new(1, -76, 0.5, 0)
            valLabel.Size                 = UDim2.new(0, 28, 0, 28)
            valLabel.Font                 = ui_options.font_bold
            valLabel.Text                 = tostring(nDef)
            valLabel.TextColor3           = active_theme.text
            valLabel.TextSize             = 13
            valLabel.ZIndex               = wIdx * 10 + 4
            valLabel.Parent               = nsFrame
            AddCorner(valLabel, UDim.new(0, 5))
            AddStroke(valLabel, active_theme.border, 1)

            local plusBtn = Instance.new("TextButton")
            plusBtn.BackgroundColor3     = options.main_color
            plusBtn.BorderSizePixel      = 0
            plusBtn.AutoButtonColor      = false
            plusBtn.AnchorPoint          = Vector2.new(1, 0.5)
            plusBtn.Position             = UDim2.new(1, -12, 0.5, 0)
            plusBtn.Size                 = UDim2.new(0, 28, 0, 28)
            plusBtn.Font                 = ui_options.font_bold
            plusBtn.Text                 = "+"
            plusBtn.TextColor3           = Color3.fromRGB(255, 255, 255)
            plusBtn.TextSize             = 16
            plusBtn.ZIndex               = wIdx * 10 + 4
            plusBtn.Parent               = nsFrame
            AddCorner(plusBtn, UDim.new(0, 5))

            local curVal = nDef
            local ns_data = {}

            local function setVal(v, fire)
                curVal = math.clamp(v, nMin, nMax)
                valLabel.Text = tostring(curVal)
                if fire then pcall(callback, curVal) end
            end

            minusBtn.MouseButton1Click:Connect(function()
                setVal(curVal - nStep, true)
                ripple(minusBtn, mouse.X, mouse.Y)
                Tween(minusBtn, {BackgroundColor3 = active_theme.surface}, 0.06)
                task.wait(0.1)
                Tween(minusBtn, {BackgroundColor3 = active_theme.surface2}, 0.1)
            end)
            plusBtn.MouseButton1Click:Connect(function()
                setVal(curVal + nStep, true)
                ripple(plusBtn, mouse.X, mouse.Y)
                Tween(plusBtn, {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}, 0.06)
                task.wait(0.1)
                Tween(plusBtn, {BackgroundColor3 = options.main_color}, 0.1)
            end)

            function ns_data:Set(v) setVal(v, false) end
            function ns_data:Get() return curVal end

            if tooltip then attachTooltip(nsFrame, tooltip) end
            return ns_data, nsFrame
        end

        ------------------------------------------------------------
        -- ColorPicker
        ------------------------------------------------------------
        function tab_data:AddColorPicker(callback, defaultColor, tooltip)
            callback     = typeof(callback) == "function" and callback or function() end
            defaultColor = typeof(defaultColor) == "Color3" and defaultColor or Color3.fromRGB(255, 0, 0)

            local cp = Instance.new("Frame")
            cp.BackgroundColor3 = active_theme.surface2
            cp.BorderSizePixel  = 0
            cp.Size             = UDim2.new(1, 0, 0, 130)
            cp.ZIndex           = wIdx * 10 + 3
            cp.Parent           = tabFrame
            AddCorner(cp)
            AddStroke(cp, active_theme.border, 1)
            AddPadding(cp, 8)

            local palette = Instance.new("ImageLabel")
            palette.BackgroundTransparency = 1
            palette.Size   = UDim2.new(0, 110, 0, 110)
            palette.ZIndex = wIdx * 10 + 4
            palette.Image  = "rbxassetid://698052001"
            palette.Parent = cp
            AddCorner(palette, UDim.new(0, 4))

            local palInd = Instance.new("Frame")
            palInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            palInd.BorderSizePixel  = 0
            palInd.AnchorPoint      = Vector2.new(0.5, 0.5)
            palInd.Size             = UDim2.new(0, 8, 0, 8)
            palInd.ZIndex           = wIdx * 10 + 6
            palInd.Parent           = palette
            AddCorner(palInd, UDim.new(1, 0))
            AddStroke(palInd, Color3.fromRGB(0, 0, 0), 1.5)

            local satBar = Instance.new("ImageLabel")
            satBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            satBar.Position         = UDim2.new(0, 118, 0, 0)
            satBar.Size             = UDim2.new(0, 18, 0, 110)
            satBar.ZIndex           = wIdx * 10 + 4
            satBar.Image            = "rbxassetid://3641079629"
            satBar.Parent           = cp
            AddCorner(satBar, UDim.new(0, 4))

            local satInd = Instance.new("Frame")
            satInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            satInd.BorderSizePixel  = 0
            satInd.AnchorPoint      = Vector2.new(0.5, 0.5)
            satInd.Size             = UDim2.new(1.5, 0, 0, 4)
            satInd.ZIndex           = wIdx * 10 + 6
            satInd.Parent           = satBar
            AddCorner(satInd, UDim.new(1, 0))
            AddStroke(satInd, Color3.fromRGB(0, 0, 0), 1)

            local sample = Instance.new("Frame")
            sample.BackgroundColor3 = defaultColor
            sample.BorderSizePixel  = 0
            sample.Position         = UDim2.new(0, 144, 0, 0)
            sample.Size             = UDim2.new(0, 30, 0, 30)
            sample.ZIndex           = wIdx * 10 + 4
            sample.Parent           = cp
            AddCorner(sample, UDim.new(0, 6))
            AddStroke(sample, active_theme.border, 1)

            -- Hex label
            local hexLabel = Instance.new("TextButton")
            hexLabel.BackgroundColor3     = active_theme.surface
            hexLabel.BorderSizePixel      = 0
            hexLabel.AutoButtonColor      = false
            hexLabel.Position             = UDim2.new(0, 144, 0, 36)
            hexLabel.Size                 = UDim2.new(0, 60, 0, 22)
            hexLabel.ZIndex               = wIdx * 10 + 4
            hexLabel.Font                 = ui_options.font_small
            hexLabel.Text                 = "#FF0000"
            hexLabel.TextColor3           = active_theme.text_dim
            hexLabel.TextSize             = 11
            hexLabel.Parent               = cp
            AddCorner(hexLabel, UDim.new(0, 4))
            AddStroke(hexLabel, active_theme.border, 1)

            local h_val, s_val, v_val = Color3.toHSV(defaultColor)
            local cp_data = {}

            local function updateSample()
                local c = Color3.fromHSV(h_val, s_val, v_val)
                sample.BackgroundColor3 = c
                satBar.ImageColor3 = Color3.fromHSV(h_val, 1, 1)
                hexLabel.Text = "#" .. string.format("%02X%02X%02X", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
                pcall(callback, c)
            end

            local paletteHeld = false
            local satHeld     = false
            local entered1    = false
            local entered2    = false

            palette.MouseEnter:Connect(function() entered1 = true;  win.Draggable = false end)
            palette.MouseLeave:Connect(function() entered1 = false; win.Draggable = not satHeld end)
            satBar.MouseEnter:Connect(function()  entered2 = true;  win.Draggable = false end)
            satBar.MouseLeave:Connect(function()  entered2 = false; win.Draggable = not paletteHeld end)

            UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if entered1 then paletteHeld = true end
                if entered2 then satHeld = true end
            end)
            UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    paletteHeld = false; satHeld = false; win.Draggable = true
                end
            end)

            RS.RenderStepped:Connect(function()
                if paletteHeld then
                    local mp = gMouse()
                    local relX = mp.X - palette.AbsolutePosition.X
                    local relY = mp.Y - palette.AbsolutePosition.Y
                    h_val = math.clamp(relX / palette.AbsoluteSize.X, 0, 1)
                    s_val = 1 - math.clamp(relY / palette.AbsoluteSize.Y, 0, 1)
                    palInd.Position = UDim2.new(math.clamp(h_val, 0.02, 0.98), 0, math.clamp(1 - s_val, 0.02, 0.98), 0)
                    updateSample()
                end
                if satHeld then
                    local mp = gMouse()
                    local relY = mp.Y - satBar.AbsolutePosition.Y
                    v_val = 1 - math.clamp(relY / satBar.AbsoluteSize.Y, 0, 1)
                    satInd.Position = UDim2.new(0.5, 0, math.clamp(1 - v_val, 0.02, 0.98), 0)
                    updateSample()
                end
            end)

            function cp_data:Set(color)
                if typeof(color) == "Color3" then
                    h_val, s_val, v_val = Color3.toHSV(color)
                    updateSample()
                end
            end
            function cp_data:Get()
                return Color3.fromHSV(h_val, s_val, v_val)
            end

            if tooltip then attachTooltip(cp, tooltip) end
            return cp_data, cp
        end

        ------------------------------------------------------------
        -- ImageDisplay
        ------------------------------------------------------------
        function tab_data:AddImage(imageId, caption, height, tooltip)
            height  = tonumber(height) or 120
            caption = tostring(caption or "")

            local widget = Instance.new("Frame")
            widget.BackgroundColor3 = active_theme.surface2
            widget.BorderSizePixel  = 0
            widget.Size             = UDim2.new(1, 0, 0, height)
            widget.ZIndex           = wIdx * 10 + 3
            widget.Parent           = tabFrame
            AddCorner(widget)
            AddStroke(widget, active_theme.border, 1)

            local img = Instance.new("ImageLabel")
            img.BackgroundTransparency = 1
            img.AnchorPoint            = Vector2.new(0.5, 0.5)
            img.Position               = UDim2.new(0.5, 0, 0.5, 0)
            img.Size                   = UDim2.new(1, -16, 1, caption ~= "" and -22 or -16)
            img.ZIndex                 = wIdx * 10 + 4
            img.Image                  = tostring(imageId or "")
            img.ScaleType              = Enum.ScaleType.Fit
            img.Parent                 = widget
            AddCorner(img, UDim.new(0, 5))

            if caption ~= "" then
                local cap = Instance.new("TextLabel")
                cap.BackgroundTransparency = 1
                cap.AnchorPoint            = Vector2.new(0, 1)
                cap.Position               = UDim2.new(0, 8, 1, -6)
                cap.Size                   = UDim2.new(1, -16, 0, 16)
                cap.ZIndex                 = wIdx * 10 + 4
                cap.Font                   = ui_options.font_small
                cap.Text                   = caption
                cap.TextColor3             = active_theme.text_dim
                cap.TextSize               = 12
                cap.TextXAlignment         = Enum.TextXAlignment.Left
                cap.Parent                 = widget
            end

            local img_data = {}
            function img_data:SetImage(id) img.Image = tostring(id) end
            function img_data:SetCaption(t)
                for _, c in ipairs(widget:GetChildren()) do
                    if c:IsA("TextLabel") then c.Text = tostring(t) end
                end
            end

            if tooltip then attachTooltip(widget, tooltip) end
            return img_data, widget
        end

        ------------------------------------------------------------
        -- Spinner / Loading
        ------------------------------------------------------------
        function tab_data:AddSpinner(text, color)
            text  = tostring(text  or "Loading...")
            color = typeof(color) == "Color3" and color or options.main_color

            local row = Instance.new("Frame")
            row.BackgroundTransparency = 1
            row.Size   = UDim2.new(1, 0, 0, 30)
            row.ZIndex = wIdx * 10 + 3
            row.Parent = tabFrame

            local spinner = MakeSpinner(22, color, row, wIdx * 10 + 3)
            spinner.AnchorPoint = Vector2.new(0, 0.5)
            spinner.Position    = UDim2.new(0, 0, 0.5, 0)

            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Position    = UDim2.new(0, 30, 0, 0)
            lbl.Size        = UDim2.new(1, -30, 1, 0)
            lbl.ZIndex      = wIdx * 10 + 4
            lbl.Font        = ui_options.font
            lbl.Text        = text
            lbl.TextColor3  = active_theme.text_dim
            lbl.TextSize    = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent      = row

            local sp_data = {}
            function sp_data:SetText(t) lbl.Text = tostring(t) end
            function sp_data:SetVisible(b) row.Visible = b end
            return sp_data, row
        end

        ------------------------------------------------------------
        -- Badge / Chip
        ------------------------------------------------------------
        function tab_data:AddBadge(text, color, tooltip)
            local container = Instance.new("Frame")
            container.BackgroundTransparency = 1
            container.Size   = UDim2.new(1, 0, 0, 26)
            container.ZIndex = wIdx * 10 + 3
            container.Parent = tabFrame

            local badge, lbl = MakeBadge(text, color or options.main_color, container, wIdx * 10 + 4)
            badge.AnchorPoint = Vector2.new(0, 0.5)
            badge.Position    = UDim2.new(0, 0, 0.5, 0)

            if tooltip then attachTooltip(badge, tooltip) end
            local badge_data = {}
            function badge_data:SetText(t)
                lbl.Text = tostring(t)
                local ts = game:GetService("TextService")
                local sz = ts:GetTextSize(tostring(t), 11, ui_options.font_bold, Vector2.new(9999, 9999))
                badge.Size = UDim2.new(0, sz.X + 14, 0, 18)
            end
            function badge_data:SetColor(c) badge.BackgroundColor3 = c end
            return badge_data, container
        end

        ------------------------------------------------------------
        -- StatusDot row
        ------------------------------------------------------------
        function tab_data:AddStatusRow(name, status, tooltip)
            status = status or "offline"
            local row = Instance.new("Frame")
            row.BackgroundTransparency = 1
            row.Size   = UDim2.new(1, 0, 0, 26)
            row.ZIndex = wIdx * 10 + 3
            row.Parent = tabFrame

            local dot = MakeStatusDot(status, row, wIdx * 10 + 4)
            dot.AnchorPoint = Vector2.new(0, 0.5)
            dot.Position    = UDim2.new(0, 0, 0.5, 0)

            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Position    = UDim2.new(0, 18, 0, 0)
            lbl.Size        = UDim2.new(1, -18, 1, 0)
            lbl.ZIndex      = wIdx * 10 + 4
            lbl.Font        = ui_options.font
            lbl.Text        = tostring(name or "Status")
            lbl.TextColor3  = active_theme.text
            lbl.TextSize    = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent      = row

            if tooltip then attachTooltip(row, tooltip) end

            local row_data = {}
            function row_data:SetStatus(s)
                dot.BackgroundColor3 = StatusColors[s] or StatusColors.offline
            end
            function row_data:SetLabel(t) lbl.Text = tostring(t) end
            return row_data, row
        end

        ------------------------------------------------------------
        -- HorizontalGroup (side-by-side buttons)
        ------------------------------------------------------------
        function tab_data:AddHorizontalGroup()
            local grp = Instance.new("Frame")
            grp.BackgroundTransparency = 1
            grp.Size   = UDim2.new(1, 0, 0, 32)
            grp.ZIndex = wIdx * 10 + 3
            grp.Parent = tabFrame

            local layout = Instance.new("UIListLayout")
            layout.FillDirection = Enum.FillDirection.Horizontal
            layout.SortOrder     = Enum.SortOrder.LayoutOrder
            layout.Padding       = UDim.new(0, 6)
            layout.Parent        = grp

            local grp_data = {}

            function grp_data:AddButton(text, callback, tooltip)
                local _, btn = tab_data:AddButton(text, callback, tooltip)
                btn.Parent = grp
                btn.Size   = UDim2.new(0, 0, 1, 0)  -- will be auto-sized
                task.defer(function()
                    local ts = game:GetService("TextService")
                    local w  = ts:GetTextSize(text, 14, ui_options.font, Vector2.new(9999, 9999)).X
                    btn.Size = UDim2.new(0, w + 28, 1, 0)
                end)
                return btn
            end

            return grp_data, grp
        end

        ------------------------------------------------------------
        -- Folder (collapsible section)
        ------------------------------------------------------------
        function tab_data:AddFolder(name, tooltip)
            name = tostring(name or "Section")

            local folderFrame = Instance.new("Frame")
            folderFrame.BackgroundTransparency = 1
            folderFrame.Size   = UDim2.new(1, 0, 0, 32)
            folderFrame.ZIndex = wIdx * 10 + 3
            folderFrame.Parent = tabFrame

            local header = Instance.new("TextButton")
            header.BackgroundColor3     = active_theme.surface
            header.BorderSizePixel      = 0
            header.AutoButtonColor      = false
            header.Size                 = UDim2.new(1, 0, 0, 32)
            header.ZIndex               = wIdx * 10 + 4
            header.Text                 = ""
            header.Parent               = folderFrame
            AddCorner(header)
            AddStroke(header, active_theme.border, 1)

            local leftAccent = Instance.new("Frame")
            leftAccent.BackgroundColor3 = options.main_color
            leftAccent.BorderSizePixel  = 0
            leftAccent.Size             = UDim2.new(0, 3, 1, 0)
            leftAccent.ZIndex           = wIdx * 10 + 5
            leftAccent.Parent           = header
            AddCorner(leftAccent, UDim.new(0, 3))

            local arrow = Instance.new("TextLabel")
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint            = Vector2.new(0, 0.5)
            arrow.Position               = UDim2.new(0, 10, 0.5, 0)
            arrow.Size                   = UDim2.new(0, 18, 0, 18)
            arrow.ZIndex                 = wIdx * 10 + 5
            arrow.Font                   = ui_options.font_bold
            arrow.Text                   = "▶"
            arrow.TextColor3             = active_theme.text_dim
            arrow.TextSize               = 11
            arrow.Parent                 = header

            local folderTitle = Instance.new("TextLabel")
            folderTitle.BackgroundTransparency = 1
            folderTitle.Position       = UDim2.new(0, 30, 0, 0)
            folderTitle.Size           = UDim2.new(1, -30, 1, 0)
            folderTitle.ZIndex         = wIdx * 10 + 5
            folderTitle.Font           = ui_options.font
            folderTitle.Text           = name
            folderTitle.TextColor3     = active_theme.text
            folderTitle.TextSize       = 14
            folderTitle.TextXAlignment = Enum.TextXAlignment.Left
            folderTitle.Parent         = header

            local content = Instance.new("Frame")
            content.BackgroundTransparency = 1
            content.BorderSizePixel        = 0
            content.ClipsDescendants       = true
            content.Position               = UDim2.new(0, 8, 0, 34)
            content.Size                   = UDim2.new(1, -8, 0, 0)
            content.ZIndex                 = wIdx * 10 + 3
            content.Parent                 = folderFrame

            local contentLayout = Instance.new("UIListLayout")
            contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            contentLayout.Padding   = UDim.new(0, 5)
            contentLayout.Parent    = content

            local isOpen  = false
            local folderH = 0

            contentLayout.Changed:Connect(function(prop)
                if prop == "AbsoluteContentSize" then
                    folderH = contentLayout.AbsoluteContentSize.Y + 8
                    if isOpen then
                        Tween(content, {Size = UDim2.new(1, -8, 0, folderH)}, 0.15)
                        Tween(folderFrame, {Size = UDim2.new(1, 0, 0, 32 + 6 + folderH)}, 0.15)
                    end
                end
            end)

            header.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    Tween(arrow, {Rotation = 90}, 0.15)
                    folderH = contentLayout.AbsoluteContentSize.Y + 8
                    Tween(content, {Size = UDim2.new(1, -8, 0, folderH)}, 0.2, Enum.EasingStyle.Quart)
                    Tween(folderFrame, {Size = UDim2.new(1, 0, 0, 32 + 6 + folderH)}, 0.2, Enum.EasingStyle.Quart)
                else
                    Tween(arrow, {Rotation = 0}, 0.15)
                    Tween(content, {Size = UDim2.new(1, -8, 0, 0)}, 0.18, Enum.EasingStyle.Quart)
                    Tween(folderFrame, {Size = UDim2.new(1, 0, 0, 32)}, 0.18, Enum.EasingStyle.Quart)
                end
                ripple(header, mouse.X, mouse.Y)
            end)

            header.MouseEnter:Connect(function()
                Tween(header, {BackgroundColor3 = active_theme.surface2}, 0.1)
            end)
            header.MouseLeave:Connect(function()
                Tween(header, {BackgroundColor3 = active_theme.surface}, 0.1)
            end)

            if tooltip then attachTooltip(header, tooltip) end

            -- Expose same API as tab_data but parented to content
            local folder_data = {}
            for k, fn in pairs(tab_data) do
                folder_data[k] = function(self, ...)
                    local results = {fn(tab_data, ...)}
                    -- Reparent last instance to content
                    local obj = results[#results]
                    if typeof(obj) == "Instance" then
                        obj.Parent = content
                    end
                    return table.unpack(results)
                end
            end
            -- Override AddFolder to prevent infinite nesting
            folder_data.AddFolder = nil

            return folder_data, folderFrame
        end

        ------------------------------------------------------------
        -- Console (log/code viewer)
        ------------------------------------------------------------
        function tab_data:AddConsole(opts)
            opts = typeof(opts) == "table" and opts or {}
            local height   = tonumber(opts.height)   or 180
            local readonly = (opts.readonly ~= false)

            local consoleFrame = Instance.new("Frame")
            consoleFrame.BackgroundColor3 = active_theme.surface2
            consoleFrame.BorderSizePixel  = 0
            consoleFrame.Size             = UDim2.new(1, 0, 0, height)
            consoleFrame.ZIndex           = wIdx * 10 + 3
            consoleFrame.Parent           = tabFrame
            AddCorner(consoleFrame)
            AddStroke(consoleFrame, active_theme.border, 1)

            -- Header
            local header = Instance.new("Frame")
            header.BackgroundColor3 = active_theme.surface
            header.BorderSizePixel  = 0
            header.Size             = UDim2.new(1, 0, 0, 26)
            header.ZIndex           = wIdx * 10 + 4
            header.Parent           = consoleFrame
            AddCorner(header, UDim.new(0, 6))

            local headerLbl = Instance.new("TextLabel")
            headerLbl.BackgroundTransparency = 1
            headerLbl.Position    = UDim2.new(0, 10, 0, 0)
            headerLbl.Size        = UDim2.new(1, -20, 1, 0)
            headerLbl.ZIndex      = wIdx * 10 + 5
            headerLbl.Font        = ui_options.font
            headerLbl.Text        = "Console"
            headerLbl.TextColor3  = active_theme.text_dim
            headerLbl.TextSize    = 12
            headerLbl.TextXAlignment = Enum.TextXAlignment.Left
            headerLbl.Parent      = header

            -- Scroll
            local sf = Instance.new("ScrollingFrame")
            sf.BackgroundTransparency = 1
            sf.BorderSizePixel        = 0
            sf.Position               = UDim2.new(0, 0, 0, 28)
            sf.Size                   = UDim2.new(1, 0, 1, -28)
            sf.CanvasSize             = UDim2.new(0, 0, 0, 0)
            sf.ScrollBarThickness     = 3
            sf.ScrollBarImageColor3   = active_theme.border
            sf.ZIndex                 = wIdx * 10 + 4
            sf.Parent                 = consoleFrame
            AddPadding(sf, 6)

            local lineNumbers = Instance.new("TextLabel")
            lineNumbers.BackgroundTransparency = 1
            lineNumbers.BorderSizePixel        = 0
            lineNumbers.Size                   = UDim2.new(0, 30, 0, 10000)
            lineNumbers.ZIndex                 = wIdx * 10 + 5
            lineNumbers.Font                   = Enum.Font.Code
            lineNumbers.Text                   = "1\n"
            lineNumbers.TextColor3             = active_theme.text_dim
            lineNumbers.TextSize               = 13
            lineNumbers.TextWrapped            = true
            lineNumbers.TextYAlignment         = Enum.TextYAlignment.Top
            lineNumbers.Parent                 = sf

            local source = Instance.new("TextBox")
            source.BackgroundTransparency = 1
            source.BorderSizePixel        = 0
            source.Position               = UDim2.new(0, 34, 0, 0)
            source.Size                   = UDim2.new(1, -34, 0, 10000)
            source.ZIndex                 = wIdx * 10 + 5
            source.ClearTextOnFocus       = false
            source.Font                   = Enum.Font.Code
            source.MultiLine              = true
            source.PlaceholderColor3      = active_theme.text_dim
            source.PlaceholderText        = "-- output"
            source.Text                   = ""
            source.TextColor3             = active_theme.text
            source.TextEditable           = not readonly
            source.TextSize               = 13
            source.TextXAlignment         = Enum.TextXAlignment.Left
            source.TextYAlignment         = Enum.TextYAlignment.Top
            source.TextWrapped            = true
            source.Parent                 = sf

            source.Changed:Connect(function(prop)
                if prop == "Text" then
                    local lines = 1
                    source.Text:gsub("\n", function() lines = lines + 1 end)
                    local lineStr = ""
                    for i = 1, lines do lineStr = lineStr .. i .. "\n" end
                    lineNumbers.Text = lineStr
                    sf.CanvasSize = UDim2.new(0, 0, 0, lines * 17 + 10)
                end
            end)

            local console_data = {}
            function console_data:Set(text) source.Text = tostring(text) end
            function console_data:Get()     return source.Text end
            function console_data:Clear()   source.Text = "" end
            function console_data:Log(msg)
                source.Text = source.Text .. "[*] " .. tostring(msg) .. "\n"
                -- Auto-scroll
                sf.CanvasPosition = Vector2.new(0, sf.AbsoluteCanvasSize.Y)
            end
            function console_data:Warn(msg)
                source.Text = source.Text .. "[!] " .. tostring(msg) .. "\n"
                sf.CanvasPosition = Vector2.new(0, sf.AbsoluteCanvasSize.Y)
            end
            function console_data:Error(msg)
                source.Text = source.Text .. "[✗] " .. tostring(msg) .. "\n"
                sf.CanvasPosition = Vector2.new(0, sf.AbsoluteCanvasSize.Y)
            end

            return console_data, consoleFrame
        end

        return tab_data, tabFrame
    end -- AddTab

    return window_data, win
end -- AddWindow

------------------------------------------------------------------------
-- PUBLIC: FormatWindows (arrange windows in grid)
------------------------------------------------------------------------

function library:FormatWindows()
    local x, y = 20, 20
    for _, win in ipairs(Windows:GetChildren()) do
        if win:IsA("Frame") then
            win.Position = UDim2.new(0, x, 0, y)
            x = x + win.AbsoluteSize.X + 20
            if x > 900 then x = 20; y = y + 320 end
        end
    end
end

------------------------------------------------------------------------
-- PUBLIC: ApplyAccentColor (change all windows' accent dynamically)
------------------------------------------------------------------------

function library:ApplyAccentColor(color)
    ui_options.main_color = color
    for _, win in ipairs(Windows:GetChildren()) do
        if win:IsA("Frame") then
            local tb = win:FindFirstChild("TitleBar")
            if tb then
                local al = tb:FindFirstChild("AccentLine") or tb:FindFirstChildOfClass("Frame")
                if al then al.BackgroundColor3 = color end
                local dot = tb:FindFirstChild("Dot")
                if dot then dot.BackgroundColor3 = color end
            end
        end
    end
end

------------------------------------------------------------------------
-- RETURN
------------------------------------------------------------------------

return library
