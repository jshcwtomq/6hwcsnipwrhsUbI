--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║   ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗    ██╗   ██╗██╗              ║
║   ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝    ██║   ██║██║              ║
║   ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗    ██║   ██║██║              ║
║   ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║    ██║   ██║██║              ║
║   ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║    ╚██████╔╝██║              ║
║   ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═╝              ║
║                                                                              ║
║   Modern Roblox UI Library — Version 2.0.0                                  ║
║   Designed for clean, polished, production-quality Roblox scripts.          ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║   FEATURES                                                                   ║
║   ─────────────────────────────────────────────────────────────────────────  ║
║   • Glass-morphism dark theme with gradient accents                          ║
║   • TweenService animations on every interactive element                     ║
║   • UICorner + UIStroke for crisp rounded elements                           ║
║   • UIGradient accents on headers, fills, and stripes                        ║
║   • Ripple click-feedback on all buttons                                     ║
║   • Glow layers on handles and thumbs                                        ║
║   • Drop-shadow beneath each window                                          ║
║   • Drag + Resize + Minimise on every window                                 ║
║   • Global toggle-key to show/hide all windows                               ║
║   • Live accent-color updates (call SetAccentColor anytime)                  ║
║   • Toast notification system with progress bar + slide animation            ║
║   • Notification queue (multiple toasts stack vertically)                    ║
║                                                                              ║
║   ELEMENTS                                                                   ║
║   ─────────────────────────────────────────────────────────────────────────  ║
║   Window        — draggable, resizable, minimisable glass card               ║
║   Tabs          — animated tab bar with auto-scroll                          ║
║   Section       — visual grouping separator with label                       ║
║   Label         — inline text with optional custom color                     ║
║   RichLabel     — multi-line auto-sizing label with markdown-lite markup     ║
║   Button        — ripple button with accent stripe                           ║
║   Switch        — animated pill toggle with glow thumb                       ║
║   TextBox       — focused-state text input with prefix icon                  ║
║   NumericBox    — validated numeric input with +/- stepper buttons           ║
║   Slider        — draggable track with gradient fill + glow thumb            ║
║   Dropdown      — animated single-select with search filter                  ║
║   MultiDropdown — animated multi-select with checkboxes + count badge        ║
║   SearchDropdown— dropdown with built-in search text box                     ║
║   Keybind       — click-to-capture keybind with live display badge           ║
║   ColorPicker   — SV square + hue bar + hex input                            ║
║   ProgressBar   — read-only animated progress bar                            ║
║   ImageLabel    — display an image asset with rounded corners                ║
║   Divider       — thin horizontal rule                                       ║
║   Spacer        — empty vertical gap                                         ║
║   Console       — Lua/Logs pane with full syntax highlighting                ║
║   Folder        — collapsible section that can hold any element              ║
║   HorizontalAlignment — row container for side-by-side elements              ║
║                                                                              ║
║   USAGE                                                                      ║
║   ─────────────────────────────────────────────────────────────────────────  ║
║                                                                              ║
║     local NexusUI = loadstring(game:HttpGet("..."))()                        ║
║                                                                              ║
║     local winData, win = NexusUI:CreateWindow({                              ║
║         title      = "My Script",                                            ║
║         subtitle   = "v1.0",                                                 ║
║         main_color = Color3.fromRGB(100, 160, 255),                          ║
║         toggle_key = Enum.KeyCode.RightShift,                                ║
║         min_size   = Vector2.new(440, 320),                                  ║
║         can_resize = true,                                                   ║
║     })                                                                       ║
║                                                                              ║
║     local tab = winData:AddTab("Main")                                       ║
║     tab:AddButton("Click Me", function() print("clicked") end)               ║
║     tab:AddSwitch("ESP", false, function(v) print(v) end)                    ║
║     tab:AddSlider("Speed", print, {min=0, max=200, default=16, suffix="u"})  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
--]]

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  S E R V I C E S                                                        │
-- └─────────────────────────────────────────────────────────────────────────┘
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")
local TextService      = game:GetService("TextService")
local HttpService      = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  T H E M E   C O N S T A N T S                                          │
-- └─────────────────────────────────────────────────────────────────────────┘
-- All colour values live here. Change these to retheme the whole library.

local THEME = {
    -- ── Background layers (darkest → lightest) ──────────────────────────
    BG_DEEP        = Color3.fromRGB(10,  11,  14),   -- deepest shadow / header
    BG_WINDOW      = Color3.fromRGB(15,  16,  21),   -- window body
    BG_PANEL       = Color3.fromRGB(20,  22,  28),   -- panel / folder
    BG_ELEMENT     = Color3.fromRGB(26,  28,  36),   -- individual element cards
    BG_HOVER       = Color3.fromRGB(33,  36,  46),   -- hover state
    BG_ACTIVE      = Color3.fromRGB(38,  41,  53),   -- pressed / active state

    -- ── Border / stroke colours ─────────────────────────────────────────
    STROKE_FAINT   = Color3.fromRGB(38,  41,  55),   -- barely-visible border
    STROKE_NORMAL  = Color3.fromRGB(55,  59,  75),   -- standard border
    STROKE_BRIGHT  = Color3.fromRGB(80,  86, 110),   -- highlighted / focused

    -- ── Text colours ─────────────────────────────────────────────────────
    TEXT_PRIMARY   = Color3.fromRGB(232, 234, 245),  -- main body text
    TEXT_SECONDARY = Color3.fromRGB(150, 155, 180),  -- sub-labels
    TEXT_MUTED     = Color3.fromRGB(85,  90, 115),   -- disabled / placeholder
    TEXT_ACCENT    = Color3.fromRGB(255, 255, 255),  -- on-accent text

    -- ── Accent colours (these are overridden per-window by main_color) ──
    ACCENT         = Color3.fromRGB(100, 160, 255),
    ACCENT_DIM     = Color3.fromRGB(50,  85, 160),
    ACCENT_GLOW    = Color3.fromRGB(140, 195, 255),

    -- ── Semantic / status colours ────────────────────────────────────────
    SUCCESS        = Color3.fromRGB(72,  208, 128),
    WARNING        = Color3.fromRGB(238, 182,  52),
    ERROR_C        = Color3.fromRGB(232,  68,  68),
    INFO           = Color3.fromRGB(72,  165, 255),

    -- ── Syntax-highlight colours (console element) ───────────────────────
    SYN_BASE       = Color3.fromRGB(210, 212, 225),  -- plain tokens
    SYN_KEYWORD    = Color3.fromRGB(210,  90, 128),  -- if / then / end …
    SYN_GLOBAL     = Color3.fromRGB(125, 205, 248),  -- game / workspace …
    SYN_STRING     = Color3.fromRGB(148, 226, 136),  -- "hello"
    SYN_NUMBER     = Color3.fromRGB(255, 192,  55),  -- 42 / 3.14
    SYN_COMMENT    = Color3.fromRGB(82,  120,  82),  -- -- comment
    SYN_REMOTE     = Color3.fromRGB(55,  145, 255),  -- FireServer / InvokeServer
    SYN_INFO_C     = Color3.fromRGB(55,  160, 255),  -- [TAG] in log mode
    SYN_OPERATOR   = Color3.fromRGB(200, 200, 200),  -- + - * / = …
    SYN_SELF       = Color3.fromRGB(220, 150, 255),  -- self
}

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  T W E E N   I N F O   P R E S E T S                                   │
-- └─────────────────────────────────────────────────────────────────────────┘
local TWEEN = {
    INSTANT = TweenInfo.new(0.06,  Enum.EasingStyle.Linear),
    FAST    = TweenInfo.new(0.12,  Enum.EasingStyle.Quad,   Enum.EasingDirection.Out),
    MEDIUM  = TweenInfo.new(0.22,  Enum.EasingStyle.Quad,   Enum.EasingDirection.Out),
    SLOW    = TweenInfo.new(0.38,  Enum.EasingStyle.Quint,  Enum.EasingDirection.Out),
    SPRING  = TweenInfo.new(0.42,  Enum.EasingStyle.Back,   Enum.EasingDirection.Out),
    BOUNCE  = TweenInfo.new(0.55,  Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
    LINEAR  = function(t) return TweenInfo.new(t, Enum.EasingStyle.Linear) end,
}

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  L U A   S Y N T A X   W O R D   L I S T S                             │
-- └─────────────────────────────────────────────────────────────────────────┘
local LUA_KEYWORDS = {
    "and","break","do","else","elseif","end","false","for","function",
    "if","in","local","nil","not","or","repeat","return","then","true",
    "until","while","continue","wait","spawn","delay","coroutine",
    "pairs","ipairs","next","unpack","select","type","typeof","tostring",
    "tonumber","rawget","rawset","rawequal","rawlen","setmetatable",
    "getmetatable","pcall","xpcall","error","assert","require",
    "print","warn","task","self",
}

local LUA_GLOBALS = {
    "game","workspace","script","Enum","math","table","string","os",
    "io","bit32","utf8","Vector2","Vector3","CFrame","Color3",
    "BrickColor","TweenInfo","UDim","UDim2","Rect","Instance","Ray",
    "NumberRange","NumberSequence","ColorSequence","Random","RaycastParams",
    "RunService","Players","UserInputService","TweenService","HttpService",
    "TextService","CoreGui","ReplicatedStorage","Workspace","RunService",
}

local LUA_REMOTE_FUNCS = {
    "FireServer","fireServer","InvokeServer","invokeServer",
    "FireClient","fireClient","InvokeClient","invokeClient",
    "FireAllClients","fireAllClients",
}

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  U T I L I T Y   H E L P E R S                                         │
-- └─────────────────────────────────────────────────────────────────────────┘

--- Animate object properties via TweenService.
-- @param obj     Instance to tween
-- @param props   Table of {Property = TargetValue}
-- @param info    TweenInfo (defaults to TWEEN.MEDIUM)
-- @return        Tween object (already playing)
local function Tween(obj, props, info)
    info = info or TWEEN.MEDIUM
    if not obj or not obj.Parent then return end
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

--- Create a Roblox Instance with properties and optional children table.
-- @param class    ClassName string
-- @param props    Table of {Property = Value}
-- @param children Table of Instance children
-- @return         Created Instance (unparented if no Parent in props)
local function New(class, props, children)
    local inst = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            inst[k] = v
        end
    end
    if children then
        for _, child in pairs(children) do
            if child and typeof(child) == "Instance" then
                child.Parent = inst
            end
        end
    end
    return inst
end

--- Attach a UICorner to an instance.
-- @param radius   Corner radius in pixels (default 8)
-- @param parent   Parent instance
-- @return         UICorner instance
local function Corner(radius, parent)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent       = parent,
    })
end

--- Attach a UIStroke to an instance.
-- @param color        Stroke color
-- @param thickness    Pixel thickness (default 1)
-- @param parent       Parent instance
-- @param transparency Transparency 0–1 (default 0)
-- @return             UIStroke instance
local function Stroke(color, thickness, parent, transparency)
    return New("UIStroke", {
        Color           = color or THEME.STROKE_NORMAL,
        Thickness       = thickness or 1,
        Transparency    = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent          = parent,
    })
end

--- Attach a UIPadding to an instance.
-- @param top    Top padding px
-- @param right  Right padding px
-- @param bottom Bottom padding px
-- @param left   Left padding px
-- @param parent Parent instance
-- @return       UIPadding instance
local function Padding(top, right, bottom, left, parent)
    return New("UIPadding", {
        PaddingTop    = UDim.new(0, top    or 6),
        PaddingRight  = UDim.new(0, right  or 6),
        PaddingBottom = UDim.new(0, bottom or 6),
        PaddingLeft   = UDim.new(0, left   or 6),
        Parent        = parent,
    })
end

--- Attach a UIListLayout to an instance.
-- @param dir    FillDirection (default Vertical)
-- @param gap    Gap in pixels  (default 6)
-- @param align  HorizontalAlignment (default Left)
-- @param parent Parent instance
-- @return       UIListLayout instance
local function List(dir, gap, align, parent)
    return New("UIListLayout", {
        FillDirection       = dir   or Enum.FillDirection.Vertical,
        SortOrder           = Enum.SortOrder.LayoutOrder,
        Padding             = UDim.new(0, gap or 6),
        HorizontalAlignment = align or Enum.HorizontalAlignment.Left,
        Parent              = parent,
    })
end

--- Measure the pixel width of a string.
-- @param text   String to measure
-- @param size   Font size in pixels
-- @param font   Enum.Font
-- @return       Width in pixels
local function TextWidth(text, size, font)
    local b = TextService:GetTextSize(
        text,
        size or 13,
        font or Enum.Font.GothamMedium,
        Vector2.new(9999, 9999)
    )
    return b.X
end

--- Linearly interpolate between two numbers.
-- @param a  Start value
-- @param b  End value
-- @param t  Alpha (0–1)
-- @return   Interpolated value
local function Lerp(a, b, t)
    return a + (b - a) * t
end

--- Convert HSV to Color3.
local function HSV(h, s, v)
    return Color3.fromHSV(
        math.clamp(h, 0, 1),
        math.clamp(s, 0, 1),
        math.clamp(v, 0, 1)
    )
end

--- Clamp a number between min and max.
local function Clamp(n, min, max)
    return math.max(min, math.min(max, n))
end

--- Round a number to the nearest step.
-- @param n     Number to round
-- @param step  Step size
-- @return      Rounded number
local function RoundToStep(n, step)
    if step <= 0 then return n end
    return math.floor(n / step + 0.5) * step
end

--- Produce a dimmer version of a colour (useful for accent-dim).
-- @param color   Base Color3
-- @param factor  Value multiplier (0–1, default 0.5)
-- @return        Dimmed Color3
local function DimColor(color, factor)
    local h, s, v = Color3.toHSV(color)
    return Color3.fromHSV(h, math.min(s * 1.05, 1), v * (factor or 0.5))
end

--- Produce a lighter/brighter version of a colour.
-- @param color  Base Color3
-- @param factor Value multiplier (>1 to brighten, default 1.3)
-- @return       Brightened Color3
local function BrightenColor(color, factor)
    local h, s, v = Color3.toHSV(color)
    return Color3.fromHSV(h, s, math.min(v * (factor or 1.3), 1))
end

--- Drop-shadow ImageLabel placed behind an element.
-- Uses a pre-baked 9-slice shadow texture.
-- @param parent          The element to shadow
-- @param spread          Pixel spread of shadow (default 12)
-- @param shadowAlpha     Shadow opacity 0–1 (default 0.55)
-- @return                Shadow ImageLabel
local function Shadow(parent, spread, shadowAlpha)
    spread      = spread      or 12
    shadowAlpha = shadowAlpha or 0.55
    return New("ImageLabel", {
        Name              = "_Shadow",
        AnchorPoint       = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position          = UDim2.new(0.5, 0, 0.5, spread / 2),
        Size              = UDim2.new(1, spread * 2, 1, spread * 2),
        Image             = "rbxassetid://6014261993",
        ImageColor3       = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 1 - shadowAlpha,
        ScaleType         = Enum.ScaleType.Slice,
        SliceCenter       = Rect.new(49, 49, 450, 450),
        SliceScale        = 1,
        ZIndex            = (parent.ZIndex or 1) - 1,
        Parent            = parent,
    })
end

--- Soft glow ImageLabel placed behind a small element (slider thumb, etc.).
-- @param parent     Parent element
-- @param color      Glow colour
-- @param spread     Pixel spread (default 14)
-- @param alpha      Glow opacity (default 0.5)
-- @return           Glow ImageLabel
local function Glow(parent, color, spread, alpha)
    spread = spread or 14
    alpha  = alpha  or 0.50
    return New("ImageLabel", {
        Name              = "_Glow",
        AnchorPoint       = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position          = UDim2.new(0.5, 0, 0.5, 0),
        Size              = UDim2.new(1, spread, 1, spread),
        Image             = "rbxassetid://5028857084",
        ImageColor3       = color or THEME.ACCENT,
        ImageTransparency = alpha,
        ZIndex            = (parent.ZIndex or 1) - 1,
        Parent            = parent,
    })
end

--- Ripple animation spawned at click position inside a button.
-- @param container  Frame that clips the ripple
-- @param x          Absolute X of click
-- @param y          Absolute Y of click
-- @param color      Ripple color (default white)
local function Ripple(container, x, y, color)
    color   = color or Color3.fromRGB(255, 255, 255)
    local rp = New("Frame", {
        Name              = "_Ripple",
        BackgroundColor3  = color,
        BackgroundTransparency = 0.72,
        BorderSizePixel   = 0,
        AnchorPoint       = Vector2.new(0.5, 0.5),
        Position          = UDim2.new(
            0, x - container.AbsolutePosition.X,
            0, y - container.AbsolutePosition.Y
        ),
        Size              = UDim2.new(0, 0, 0, 0),
        ZIndex            = (container.ZIndex or 1) + 8,
        ClipsDescendants  = false,
        Parent            = container,
    })
    Corner(999, rp)
    local sz = math.max(container.AbsoluteSize.X, container.AbsoluteSize.Y) * 2.8
    Tween(rp, {
        Size                  = UDim2.new(0, sz, 0, sz),
        BackgroundTransparency = 1,
    }, TWEEN.SLOW)
    game:GetService("Debris"):AddItem(rp, 0.65)
end

--- Create a thin 1px horizontal divider frame.
-- @param parent  Parent container
-- @param zIndex  ZIndex
-- @return        Frame
local function MakeDivider(parent, zIndex)
    return New("Frame", {
        BackgroundColor3  = THEME.STROKE_FAINT,
        BorderSizePixel   = 0,
        Size              = UDim2.new(1, 0, 0, 1),
        ZIndex            = zIndex or 1,
        Parent            = parent,
    })
end

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  S C R E E N G U I   I N I T I A L I S A T I O N                       │
-- └─────────────────────────────────────────────────────────────────────────┘
-- Destroy any previous instance to allow hot-reloads without duplicate UIs.
do
    local prev = CoreGui:FindFirstChild("NexusUI_v2")
    if prev then prev:Destroy() end
end

local ScreenGui = New("ScreenGui", {
    Name           = "NexusUI_v2",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})
-- Prefer CoreGui; fall back to PlayerGui in Studio / filtered executors.
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    pcall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
end

--- Root container for all windows (transparent, fills the whole screen).
local WindowContainer = New("Frame", {
    Name              = "WindowContainer",
    BackgroundTransparency = 1,
    Size              = UDim2.new(1, 0, 1, 0),
    ZIndex            = 1,
    Parent            = ScreenGui,
})

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  N O T I F I C A T I O N   Q U E U E                                   │
-- └─────────────────────────────────────────────────────────────────────────┘
-- Toasts stack vertically; each new toast slides in above the previous one.

local TOAST_H   = 68   -- height of each toast card in pixels
local TOAST_GAP = 8    -- vertical gap between stacked toasts
local TOAST_W   = 290  -- fixed toast width
local activeToasts = {}  -- array of currently visible toast frames

--- Recalculate positions of all active toasts so they stack neatly.
local function repositionToasts()
    for i, toast in ipairs(activeToasts) do
        local targetY = -(i * (TOAST_H + TOAST_GAP))
        Tween(toast, {
            Position = UDim2.new(1, -(TOAST_W + 14), 1, targetY),
        }, TWEEN.SPRING)
    end
end

--- Spawn a toast notification (used by both window_data:Notify and NexusUI:Notify).
-- @param title     Bold title text
-- @param message   Body text
-- @param duration  On-screen time in seconds
-- @param color     Accent color (stripe + border)
local function SpawnToast(title, message, duration, color)
    title    = tostring(title   or "Notice")
    message  = tostring(message or "")
    duration = tonumber(duration) or 3
    color    = color or THEME.ACCENT

    local toast = New("Frame", {
        Name              = "Toast",
        BackgroundColor3  = THEME.BG_PANEL,
        BorderSizePixel   = 0,
        AnchorPoint       = Vector2.new(0, 0),
        -- starts off-screen to the right
        Position          = UDim2.new(1, 14, 1, -(TOAST_H + TOAST_GAP)),
        Size              = UDim2.new(0, TOAST_W, 0, TOAST_H),
        ZIndex            = 500,
        Parent            = ScreenGui,
    })
    Corner(10, toast)
    Stroke(color, 1, toast, 0.3)
    Shadow(toast, 10, 0.4)

    -- Left colour stripe
    local stripe = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 3, 1, 0),
        ZIndex           = 501,
        Parent           = toast,
    })
    New("UICorner", {CornerRadius = UDim.new(0, 3), Parent = stripe})

    -- Icon circle
    local iconCircle = New("Frame", {
        BackgroundColor3 = color,
        BackgroundTransparency = 0.75,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 14, 0.5, -4),
        Size             = UDim2.new(0, 26, 0, 26),
        ZIndex           = 501,
        Parent           = toast,
    })
    Corner(13, iconCircle)
    New("TextLabel", {
        BackgroundTransparency = 1,
        Size       = UDim2.new(1, 0, 1, 0),
        Font       = Enum.Font.GothamBold,
        Text       = "!",
        TextColor3 = color,
        TextSize   = 14,
        ZIndex     = 502,
        Parent     = iconCircle,
    })

    -- Title text
    New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint    = Vector2.new(0, 0),
        Position       = UDim2.new(0, 48, 0, 10),
        Size           = UDim2.new(1, -58, 0, 18),
        Font           = Enum.Font.GothamBold,
        Text           = title,
        TextColor3     = THEME.TEXT_PRIMARY,
        TextSize       = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex         = 502,
        Parent         = toast,
    })

    -- Message text
    New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint    = Vector2.new(0, 0),
        Position       = UDim2.new(0, 48, 0, 30),
        Size           = UDim2.new(1, -58, 0, 30),
        Font           = Enum.Font.Gotham,
        Text           = message,
        TextColor3     = THEME.TEXT_SECONDARY,
        TextSize       = 11,
        TextWrapped    = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex         = 502,
        Parent         = toast,
    })

    -- Progress drain bar (shrinks from full to 0 over duration)
    local progBg = New("Frame", {
        BackgroundColor3 = THEME.BG_ACTIVE,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0, 1),
        Position         = UDim2.new(0, 0, 1, 0),
        Size             = UDim2.new(1, 0, 0, 2),
        ZIndex           = 502,
        Parent           = toast,
    })
    Corner(1, progBg)

    local progFill = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 1, 0),
        ZIndex           = 503,
        Parent           = progBg,
    })
    Corner(1, progFill)

    -- Register and slide in
    table.insert(activeToasts, 1, toast)
    repositionToasts()

    -- Drain the progress bar
    Tween(progFill, {Size = UDim2.new(0, 0, 1, 0)}, TWEEN.LINEAR(duration))

    -- Dismiss after duration
    task.delay(duration - 0.3, function()
        -- Remove from queue
        for i, t in ipairs(activeToasts) do
            if t == toast then
                table.remove(activeToasts, i)
                break
            end
        end
        repositionToasts()
        Tween(toast, {
            Position          = UDim2.new(1, 14, 1, -(TOAST_H + TOAST_GAP)),
            BackgroundTransparency = 1,
        }, TWEEN.MEDIUM)
        task.delay(0.28, function()
            if toast and toast.Parent then
                toast:Destroy()
            end
        end)
    end)
end

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  W I N D O W   C O U N T E R                                            │
-- └─────────────────────────────────────────────────────────────────────────┘
-- Each window gets its own ZIndex band so they stack correctly on top of each
-- other when clicked / dragged.
local windowCount = 0

-- ┌─────────────────────────────────────────────────────────────────────────┐
-- │  N E X U S U I   T A B L E                                              │
-- └─────────────────────────────────────────────────────────────────────────┘
local NexusUI   = {}
NexusUI.__index = NexusUI

-- ══════════════════════════════════════════════════════════════════════════
--  CreateWindow
--  Creates a draggable, resizable, minimisable floating window.
--
--  Options table fields:
--    title        (string)   Window title shown in title bar     ["NexusUI"]
--    subtitle     (string)   Smaller text below title            ["v2.0"]
--    main_color   (Color3)   Primary accent colour               [blue]
--    toggle_key   (KeyCode)  Key to toggle UI visibility         [RightShift]
--    min_size     (Vector2)  Minimum resize dimensions           [440×320]
--    can_resize   (boolean)  Allow corner-drag resize            [true]
--    transparency (number)   Window background alpha 0–1         [0.12]
--    position     (UDim2)    Initial screen position             [auto-offset]
--    size         (UDim2)    Initial window size                 [560×420]
-- ══════════════════════════════════════════════════════════════════════════
function NexusUI:CreateWindow(opts)
    opts = opts or {}

    -- ── Merge user options with defaults ──────────────────────────────────
    local options = {
        title        = tostring(opts.title      or "NexusUI"),
        subtitle     = tostring(opts.subtitle   or "v2.0"),
        main_color   = opts.main_color          or THEME.ACCENT,
        toggle_key   = opts.toggle_key          or Enum.KeyCode.RightShift,
        min_size     = opts.min_size            or Vector2.new(440, 320),
        can_resize   = (opts.can_resize ~= false),
        transparency = tonumber(opts.transparency) or 0.12,
        position     = opts.position            or UDim2.new(0, 80 + windowCount * 32, 0, 80 + windowCount * 32),
        size         = opts.size                or UDim2.new(0, 580, 0, 440),
        tween_time   = tonumber(opts.tween_time) or 0.20,
    }

    -- Helpers that reference the mutable options.main_color
    local function accent()    return options.main_color end
    local function accentDim() return DimColor(options.main_color, 0.45) end
    local function accentBright() return BrightenColor(options.main_color, 1.25) end

    windowCount = windowCount + 1
    local WIN_Z = windowCount * 25  -- base ZIndex for this window

    -- ──────────────────────────────────────────────────────────────────────
    --  Window root frame
    -- ──────────────────────────────────────────────────────────────────────
    local Window = New("Frame", {
        Name             = "NexusWindow_" .. windowCount,
        BackgroundColor3 = THEME.BG_WINDOW,
        BackgroundTransparency = options.transparency,
        BorderSizePixel  = 0,
        Position         = options.position,
        Size             = options.size,
        ClipsDescendants = true,
        Active           = true,
        Selectable       = false,
        ZIndex           = WIN_Z,
        Parent           = WindowContainer,
    })
    Corner(10, Window)
    Stroke(THEME.STROKE_FAINT, 1, Window)
    Shadow(Window, 14, 0.38)

    -- ──────────────────────────────────────────────────────────────────────
    --  Title bar  (top 44px, always visible)
    -- ──────────────────────────────────────────────────────────────────────
    local TitleBar = New("Frame", {
        Name             = "TitleBar",
        BackgroundColor3 = THEME.BG_DEEP,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 44),
        ZIndex           = WIN_Z + 1,
        Parent           = Window,
    })

    -- 2px accent line at the very top of the title bar
    local TitleAccentLine = New("Frame", {
        Name             = "AccentLine",
        BackgroundColor3 = accent(),
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 2),
        ZIndex           = WIN_Z + 2,
        Parent           = TitleBar,
    })
    local titleAccentGrad = New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   accent()),
            ColorSequenceKeypoint.new(0.6, accentBright()),
            ColorSequenceKeypoint.new(1,   accentDim()),
        }),
        Parent = TitleAccentLine,
    })

    -- Icon badge (first letter of title, rounded square with gradient)
    local IconFrame = New("Frame", {
        Name             = "Icon",
        BackgroundColor3 = accent(),
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 12, 0.5, 0),
        Size             = UDim2.new(0, 28, 0, 28),
        ZIndex           = WIN_Z + 2,
        Parent           = TitleBar,
    })
    Corner(7, IconFrame)
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, accent()),
        }),
        Rotation = 135,
        Parent   = IconFrame,
    })
    local IconLetter = New("TextLabel", {
        BackgroundTransparency = 1,
        Size       = UDim2.new(1, 0, 1, 0),
        Font       = Enum.Font.GothamBold,
        Text       = string.upper(string.sub(options.title, 1, 1)),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize   = 15,
        ZIndex     = WIN_Z + 3,
        Parent     = IconFrame,
    })

    -- Title + subtitle text stack
    local TitleLabel = New("TextLabel", {
        Name             = "Title",
        BackgroundTransparency = 1,
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 50, 0.5, -7),
        Size             = UDim2.new(0, 320, 0, 20),
        Font             = Enum.Font.GothamBold,
        Text             = options.title,
        TextColor3       = THEME.TEXT_PRIMARY,
        TextSize         = 15,
        TextXAlignment   = Enum.TextXAlignment.Left,
        ZIndex           = WIN_Z + 2,
        Parent           = TitleBar,
    })
    local SubLabel = New("TextLabel", {
        Name             = "Subtitle",
        BackgroundTransparency = 1,
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 50, 0.5, 8),
        Size             = UDim2.new(0, 320, 0, 14),
        Font             = Enum.Font.Gotham,
        Text             = options.subtitle,
        TextColor3       = THEME.TEXT_MUTED,
        TextSize         = 11,
        TextXAlignment   = Enum.TextXAlignment.Left,
        ZIndex           = WIN_Z + 2,
        Parent           = TitleBar,
    })

    -- Window control buttons (minimise + close)
    local ControlsRow = New("Frame", {
        Name             = "Controls",
        BackgroundTransparency = 1,
        AnchorPoint      = Vector2.new(1, 0.5),
        Position         = UDim2.new(1, -10, 0.5, 0),
        Size             = UDim2.new(0, 58, 0, 24),
        ZIndex           = WIN_Z + 3,
        Parent           = TitleBar,
    })
    List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, ControlsRow)

    local function MakeCtrlBtn(icon, hoverColor)
        local b = New("TextButton", {
            BackgroundColor3 = THEME.BG_ELEMENT,
            BorderSizePixel  = 0,
            Size             = UDim2.new(0, 24, 0, 24),
            Font             = Enum.Font.GothamBold,
            Text             = icon,
            TextColor3       = THEME.TEXT_MUTED,
            TextSize         = 10,
            ZIndex           = WIN_Z + 4,
            Parent           = ControlsRow,
        })
        Corner(6, b)
        b.MouseEnter:Connect(function()
            Tween(b, {BackgroundColor3 = hoverColor or THEME.BG_HOVER, TextColor3 = THEME.TEXT_PRIMARY}, TWEEN.FAST)
        end)
        b.MouseLeave:Connect(function()
            Tween(b, {BackgroundColor3 = THEME.BG_ELEMENT, TextColor3 = THEME.TEXT_MUTED}, TWEEN.FAST)
        end)
        return b
    end

    local MinBtn   = MakeCtrlBtn("—")
    local CloseBtn = MakeCtrlBtn("✕", THEME.ERROR_C)

    -- ──────────────────────────────────────────────────────────────────────
    --  Tab selection bar  (below title bar, 36px)
    -- ──────────────────────────────────────────────────────────────────────
    local TabBar = New("Frame", {
        Name             = "TabBar",
        BackgroundColor3 = THEME.BG_DEEP,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 0, 44),
        Size             = UDim2.new(1, 0, 0, 36),
        ZIndex           = WIN_Z + 1,
        Parent           = Window,
    })
    MakeDivider(TabBar, WIN_Z + 2)  -- top 1px sep
    -- Bottom separator
    New("Frame", {
        BackgroundColor3 = THEME.STROKE_FAINT,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0, 1),
        Position         = UDim2.new(0, 0, 1, 0),
        Size             = UDim2.new(1, 0, 0, 1),
        ZIndex           = WIN_Z + 2,
        Parent           = TabBar,
    })

    local TabScroll = New("ScrollingFrame", {
        Name             = "TabScroll",
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 8, 0, 5),
        Size             = UDim2.new(1, -16, 1, -10),
        CanvasSize       = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        ScrollBarThickness  = 0,
        ScrollingDirection  = Enum.ScrollingDirection.X,
        ZIndex           = WIN_Z + 2,
        Parent           = TabBar,
    })
    List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Left, TabScroll)

    -- ──────────────────────────────────────────────────────────────────────
    --  Content / scroll area  (below tab bar, fills remainder)
    -- ──────────────────────────────────────────────────────────────────────
    local ContentScroll = New("ScrollingFrame", {
        Name             = "ContentScroll",
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, 0, 0, 80),
        Size             = UDim2.new(1, 0, 1, -80),
        CanvasSize       = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness  = 3,
        ScrollBarImageColor3 = THEME.STROKE_BRIGHT,
        ClipsDescendants = true,
        ZIndex           = WIN_Z + 1,
        Parent           = Window,
    })
    Padding(10, 14, 14, 14, ContentScroll)

    -- ──────────────────────────────────────────────────────────────────────
    --  Resize handle  (bottom-right 18×18 grip)
    -- ──────────────────────────────────────────────────────────────────────
    local ResizerFrame = New("Frame", {
        Name             = "Resizer",
        BackgroundTransparency = 1,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(1, 1),
        Position         = UDim2.new(1, 0, 1, 0),
        Size             = UDim2.new(0, 18, 0, 18),
        Active           = true,
        ZIndex           = WIN_Z + 15,
        Parent           = Window,
    })
    -- 3×3 dot grip visual
    for row = 1, 3 do
        for col = 1, 3 do
            if row + col >= 4 then
                New("Frame", {
                    BackgroundColor3 = THEME.STROKE_NORMAL,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, (col - 1) * 5, 0, (row - 1) * 5),
                    Size             = UDim2.new(0, 2, 0, 2),
                    ZIndex           = WIN_Z + 16,
                    Parent           = ResizerFrame,
                })
            end
        end
    end

    -- ──────────────────────────────────────────────────────────────────────
    --  Drag  (TitleBar input)
    -- ──────────────────────────────────────────────────────────────────────
    local _dragActive, _dragStart, _dragWinPos
    TitleBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            _dragActive  = true
            _dragStart   = inp.Position
            _dragWinPos  = Window.Position
        end
    end)
    TitleBar.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            _dragActive = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if _dragActive and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d = inp.Position - _dragStart
            Window.Position = UDim2.new(
                _dragWinPos.X.Scale, _dragWinPos.X.Offset + d.X,
                _dragWinPos.Y.Scale, _dragWinPos.Y.Offset + d.Y
            )
        end
    end)

    -- ──────────────────────────────────────────────────────────────────────
    --  Resize  (ResizerFrame corner drag)
    -- ──────────────────────────────────────────────────────────────────────
    local _resizing, _resizeStart, _resizeInitSize
    ResizerFrame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 and options.can_resize then
            _resizing       = true
            _resizeStart    = inp.Position
            _resizeInitSize = Window.AbsoluteSize
        end
    end)
    ResizerFrame.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            _resizing = false
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if _resizing and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d    = inp.Position - _resizeStart
            local newW = math.max(_resizeInitSize.X + d.X, options.min_size.X)
            local newH = math.max(_resizeInitSize.Y + d.Y, options.min_size.Y)
            Window.Size = UDim2.new(0, newW, 0, newH)
        end
    end)

    -- ──────────────────────────────────────────────────────────────────────
    --  Minimise (MinBtn)
    -- ──────────────────────────────────────────────────────────────────────
    local _minimised   = false
    local _storedH     = 0
    MinBtn.MouseButton1Click:Connect(function()
        _minimised = not _minimised
        if _minimised then
            _storedH = Window.AbsoluteSize.Y
            ContentScroll.Visible = false
            TabBar.Visible        = false
            Tween(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, 44)}, TWEEN.MEDIUM)
            MinBtn.Text = "□"
        else
            ContentScroll.Visible = true
            TabBar.Visible        = true
            Tween(Window, {Size = UDim2.new(0, Window.AbsoluteSize.X, 0, _storedH)}, TWEEN.MEDIUM)
            MinBtn.Text = "—"
        end
    end)

    -- ──────────────────────────────────────────────────────────────────────
    --  Close (CloseBtn)
    -- ──────────────────────────────────────────────────────────────────────
    CloseBtn.MouseButton1Click:Connect(function()
        Tween(Window, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, Window.AbsoluteSize.X * 0.9, 0, Window.AbsoluteSize.Y * 0.9),
        }, TWEEN.MEDIUM)
        task.delay(0.24, function()
            if Window and Window.Parent then Window:Destroy() end
        end)
    end)

    -- ──────────────────────────────────────────────────────────────────────
    --  Global toggle key
    -- ──────────────────────────────────────────────────────────────────────
    local _visible = true
    UserInputService.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        if inp.KeyCode == options.toggle_key then
            _visible = not _visible
            Tween(Window, {BackgroundTransparency = _visible and options.transparency or 1}, TWEEN.FAST)
            Window.Visible = _visible
        end
    end)

    -- ──────────────────────────────────────────────────────────────────────
    --  Live accent-colour sync loop
    -- ──────────────────────────────────────────────────────────────────────
    task.spawn(function()
        while Window and Window.Parent do
            -- Update gradient endpoints whenever main_color changes
            titleAccentGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,   accent()),
                ColorSequenceKeypoint.new(0.6, accentBright()),
                ColorSequenceKeypoint.new(1,   accentDim()),
            })
            TitleAccentLine.BackgroundColor3 = accent()
            IconFrame.BackgroundColor3       = accent()
            RunService.Heartbeat:Wait()
        end
    end)

    -- ══════════════════════════════════════════════════════════════════════
    --  window_data  —  public API returned to the caller
    -- ══════════════════════════════════════════════════════════════════════
    local window_data = {}
    local _tabModules = {}   -- {btn, frame} pairs
    local _activeTab  = nil  -- currently visible tab frame

    --- Switch visibility to the given tab.
    local function selectTab(btn, frame)
        -- Deselect old
        if _activeTab then
            local oldBtn = _activeTab.btn
            Tween(oldBtn, {BackgroundColor3 = THEME.BG_ELEMENT, TextColor3 = THEME.TEXT_SECONDARY}, TWEEN.FAST)
            _activeTab.frame.Visible = false
        end
        -- Select new
        Tween(btn, {BackgroundColor3 = accent(), TextColor3 = THEME.TEXT_ACCENT}, TWEEN.FAST)
        frame.Visible = true
        _activeTab    = {btn = btn, frame = frame}
    end

    -- ════════════════════════════════════════════════════════════════════
    --  AddTab
    --  Creates a tab button in the tab bar and a matching content frame.
    --  Returns tab_data table with element builder methods.
    -- ════════════════════════════════════════════════════════════════════
    function window_data:AddTab(tab_name, icon_char)
        tab_name  = tostring(tab_name or "Tab")
        local tab_data = {}

        -- Tab button
        local btnText = (icon_char and (icon_char .. "  ") or "") .. tab_name
        local tabBtn  = New("TextButton", {
            Name             = "Tab_" .. tab_name,
            BackgroundColor3 = THEME.BG_ELEMENT,
            BorderSizePixel  = 0,
            Size             = UDim2.new(0, TextWidth(btnText, 12, Enum.Font.GothamMedium) + 24, 0, 26),
            Font             = Enum.Font.GothamMedium,
            Text             = btnText,
            TextColor3       = THEME.TEXT_SECONDARY,
            TextSize         = 12,
            ZIndex           = WIN_Z + 3,
            Parent           = TabScroll,
        })
        Corner(6, tabBtn)
        Stroke(THEME.STROKE_FAINT, 1, tabBtn)

        -- Content frame (one per tab, all share ContentScroll as parent)
        local tabFrame = New("Frame", {
            Name             = "TabFrame_" .. tab_name,
            BackgroundTransparency = 1,
            BorderSizePixel  = 0,
            Size             = UDim2.new(1, 0, 0, 0),
            AutomaticSize    = Enum.AutomaticSize.Y,
            Visible          = false,
            ZIndex           = WIN_Z + 1,
            Parent           = ContentScroll,
        })
        List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Left, tabFrame)

        table.insert(_tabModules, {btn = tabBtn, frame = tabFrame})

        -- Auto-select first tab
        if #_tabModules == 1 then
            selectTab(tabBtn, tabFrame)
        end

        tabBtn.MouseButton1Click:Connect(function()
            selectTab(tabBtn, tabFrame)
        end)
        tabBtn.MouseEnter:Connect(function()
            if not _activeTab or _activeTab.btn ~= tabBtn then
                Tween(tabBtn, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if not _activeTab or _activeTab.btn ~= tabBtn then
                Tween(tabBtn, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST)
            end
        end)

        function tab_data:Show() selectTab(tabBtn, tabFrame) end

        -- ─────────────────────────────────────────────────────────────────
        --  buildElements(targetFrame, zOff)
        --  Internal factory that attaches all element methods to a table.
        --  Re-used for both tab frames and folder content frames.
        -- ─────────────────────────────────────────────────────────────────
        local function buildElements(target, zOff)
            zOff = zOff or 0
            local E = {}   -- element method table

            -- ═══════════════════════════════════════════════════════════
            --  Section separator
            -- ═══════════════════════════════════════════════════════════
            function E:AddSection(title_text)
                title_text = tostring(title_text or "Section")

                local wrap = New("Frame", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 0, 24),
                    ZIndex       = WIN_Z + 2 + zOff,
                    Parent       = target,
                })

                -- Full-width rule
                New("Frame", {
                    BackgroundColor3 = THEME.STROKE_FAINT,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 0, 0.5, 0),
                    Size             = UDim2.new(1, 0, 0, 1),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = wrap,
                })

                -- Label pill on top of the rule
                local pill = New("Frame", {
                    BackgroundColor3 = THEME.BG_WINDOW,
                    BackgroundTransparency = 0,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 0, 0.5, 0),
                    AutomaticSize    = Enum.AutomaticSize.X,
                    Size             = UDim2.new(0, 0, 0, 18),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = wrap,
                })

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    Font         = Enum.Font.GothamBold,
                    Text         = "  " .. string.upper(title_text) .. "  ",
                    TextColor3   = THEME.TEXT_MUTED,
                    TextSize     = 10,
                    ZIndex       = WIN_Z + 4 + zOff,
                    Parent       = pill,
                })

                return wrap
            end

            -- ═══════════════════════════════════════════════════════════
            --  Spacer  (empty vertical gap)
            -- ═══════════════════════════════════════════════════════════
            function E:AddSpacer(pixels)
                return New("Frame", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 0, tonumber(pixels) or 8),
                    ZIndex       = WIN_Z + 2 + zOff,
                    Parent       = target,
                })
            end

            -- ═══════════════════════════════════════════════════════════
            --  Divider  (thin horizontal line)
            -- ═══════════════════════════════════════════════════════════
            function E:AddDivider()
                local d = New("Frame", {
                    BackgroundColor3 = THEME.STROKE_FAINT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 1),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                return d
            end

            -- ═══════════════════════════════════════════════════════════
            --  Label
            -- ═══════════════════════════════════════════════════════════
            function E:AddLabel(label_text, color)
                label_text = tostring(label_text or "Label")
                local lbl  = New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size             = UDim2.new(1, 0, 0, 0),
                    AutomaticSize    = Enum.AutomaticSize.Y,
                    Font             = Enum.Font.Gotham,
                    Text             = label_text,
                    TextColor3       = color or THEME.TEXT_SECONDARY,
                    TextSize         = 13,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    TextWrapped      = true,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                local api = {}
                function api:Set(t)   lbl.Text       = tostring(t) end
                function api:SetColor(c) lbl.TextColor3 = c end
                function api:SetSize(s)  lbl.TextSize   = s end
                return api, lbl
            end

            -- ═══════════════════════════════════════════════════════════
            --  RichLabel  (multi-line, auto-height, optional bold prefix)
            -- ═══════════════════════════════════════════════════════════
            function E:AddRichLabel(prefix_text, body_text, prefix_color)
                prefix_text  = tostring(prefix_text or "")
                body_text    = tostring(body_text    or "")
                prefix_color = prefix_color or accent()

                local card = New("Frame", {
                    BackgroundColor3  = THEME.BG_ELEMENT,
                    BorderSizePixel   = 0,
                    Size              = UDim2.new(1, 0, 0, 0),
                    AutomaticSize     = Enum.AutomaticSize.Y,
                    ZIndex            = WIN_Z + 2 + zOff,
                    Parent            = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)
                Padding(8, 12, 8, 12, card)

                local inner = New("Frame", {
                    BackgroundTransparency = 1,
                    Size          = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ZIndex        = WIN_Z + 3 + zOff,
                    Parent        = card,
                })

                local prefLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint    = Vector2.new(0, 0),
                    Size           = UDim2.new(1, 0, 0, 0),
                    AutomaticSize  = Enum.AutomaticSize.Y,
                    Font           = Enum.Font.GothamBold,
                    Text           = prefix_text,
                    TextColor3     = prefix_color,
                    TextSize       = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped    = true,
                    Visible        = (#prefix_text > 0),
                    ZIndex         = WIN_Z + 4 + zOff,
                    Parent         = inner,
                })

                local bodyLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size           = UDim2.new(1, 0, 0, 0),
                    AutomaticSize  = Enum.AutomaticSize.Y,
                    Font           = Enum.Font.Gotham,
                    Text           = body_text,
                    TextColor3     = THEME.TEXT_SECONDARY,
                    TextSize       = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped    = true,
                    ZIndex         = WIN_Z + 4 + zOff,
                    Parent         = inner,
                })
                List(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Left, inner)

                local api = {}
                function api:SetPrefix(t, c) prefLbl.Text = tostring(t); if c then prefLbl.TextColor3 = c end; prefLbl.Visible = (#tostring(t) > 0) end
                function api:SetBody(t)   bodyLbl.Text = tostring(t) end
                return api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  ImageLabel  (display a Roblox asset image)
            -- ═══════════════════════════════════════════════════════════
            function E:AddImage(asset_id, height, aspect_ratio)
                height       = tonumber(height) or 120
                aspect_ratio = tonumber(aspect_ratio) or 0
                local img_id = tostring(asset_id or "rbxassetid://0")
                if not img_id:match("rbxassetid://") then
                    img_id = "rbxassetid://" .. img_id
                end

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, height + (aspect_ratio > 0 and 0 or 0)),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)

                local imgLbl = New("ImageLabel", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 1, 0),
                    Image        = img_id,
                    ScaleType    = Enum.ScaleType.Fit,
                    ZIndex       = WIN_Z + 3 + zOff,
                    Parent       = card,
                })
                Corner(8, imgLbl)

                local api = {}
                function api:SetImage(id)
                    local s = tostring(id or "0")
                    if not s:match("rbxassetid://") then s = "rbxassetid://" .. s end
                    imgLbl.Image = s
                end
                function api:SetHeight(h) card.Size = UDim2.new(1, 0, 0, tonumber(h) or height) end
                return api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  ProgressBar
            -- ═══════════════════════════════════════════════════════════
            function E:AddProgressBar(label_text, initial_value, max_value, show_percent)
                label_text    = tostring(label_text or "Progress")
                initial_value = tonumber(initial_value) or 0
                max_value     = tonumber(max_value)     or 100
                show_percent  = (show_percent ~= false)

                local currentVal = Clamp(initial_value, 0, max_value)

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 48),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)
                Padding(8, 12, 8, 12, card)

                local topRow = New("Frame", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 0, 18),
                    ZIndex       = WIN_Z + 3 + zOff,
                    Parent       = card,
                })
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 0.5),
                    Position     = UDim2.new(0, 0, 0.5, 0),
                    Size         = UDim2.new(1, -56, 1, 0),
                    Font         = Enum.Font.GothamMedium,
                    Text         = label_text,
                    TextColor3   = THEME.TEXT_PRIMARY,
                    TextSize     = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex       = WIN_Z + 4 + zOff,
                    Parent       = topRow,
                })

                local pctLabel = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(1, 0.5),
                    Position     = UDim2.new(1, 0, 0.5, 0),
                    Size         = UDim2.new(0, 52, 1, 0),
                    Font         = Enum.Font.GothamMedium,
                    Text         = show_percent and (string.format("%.0f", currentVal / max_value * 100) .. "%") or "",
                    TextColor3   = accent(),
                    TextSize     = 11,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex       = WIN_Z + 4 + zOff,
                    Parent       = topRow,
                })

                -- Track
                local track = New("Frame", {
                    BackgroundColor3 = THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 1),
                    Position         = UDim2.new(0, 0, 1, 0),
                    Size             = UDim2.new(1, 0, 0, 8),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = card,
                })
                Corner(4, track)

                -- Fill
                local fill = New("Frame", {
                    BackgroundColor3 = accent(),
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(currentVal / max_value, 0, 1, 0),
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = track,
                })
                Corner(4, fill)
                New("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, accent()),
                        ColorSequenceKeypoint.new(1, accentBright()),
                    }),
                    Parent = fill,
                })

                local pb_api = {}
                function pb_api:Set(val)
                    val        = Clamp(tonumber(val) or 0, 0, max_value)
                    currentVal = val
                    local pct  = val / max_value
                    Tween(fill, {Size = UDim2.new(pct, 0, 1, 0)}, TWEEN.MEDIUM)
                    if show_percent then
                        pctLabel.Text = string.format("%.0f", pct * 100) .. "%"
                    end
                    fill.BackgroundColor3 = accent()
                end
                function pb_api:Get()     return currentVal end
                function pb_api:Animate(from, to, duration)
                    from     = Clamp(tonumber(from) or 0, 0, max_value)
                    to       = Clamp(tonumber(to)   or 0, 0, max_value)
                    duration = tonumber(duration) or 1
                    fill.Size = UDim2.new(from / max_value, 0, 1, 0)
                    Tween(fill, {Size = UDim2.new(to / max_value, 0, 1, 0)}, TWEEN.LINEAR(duration))
                    if show_percent then
                        -- update label at end
                        task.delay(duration, function()
                            currentVal    = to
                            pctLabel.Text = string.format("%.0f", to / max_value * 100) .. "%"
                        end)
                    end
                end
                return pb_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  Button
            -- ═══════════════════════════════════════════════════════════
            function E:AddButton(btn_text, callback)
                btn_text = tostring(btn_text or "Button")
                callback = type(callback) == "function" and callback or function() end

                local btn = New("TextButton", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    Font             = Enum.Font.GothamMedium,
                    Text             = btn_text,
                    TextColor3       = THEME.TEXT_PRIMARY,
                    TextSize         = 13,
                    ClipsDescendants = true,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, btn)
                Stroke(THEME.STROKE_FAINT, 1, btn)

                -- Left accent stripe
                local stripe = New("Frame", {
                    BackgroundColor3 = accent(),
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(0, 3, 1, 0),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = btn,
                })
                Corner(2, stripe)

                btn.MouseEnter:Connect(function()
                    Tween(btn,    {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST)
                    Tween(stripe, {Size = UDim2.new(0, 4, 1, 0)}, TWEEN.FAST)
                end)
                btn.MouseLeave:Connect(function()
                    Tween(btn,    {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST)
                    Tween(stripe, {Size = UDim2.new(0, 3, 1, 0)}, TWEEN.FAST)
                end)
                btn.MouseButton1Click:Connect(function()
                    Ripple(btn, Mouse.X, Mouse.Y, accent())
                    Tween(btn, {BackgroundColor3 = THEME.BG_ACTIVE}, TWEEN.INSTANT)
                    task.delay(0.12, function()
                        Tween(btn, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.MEDIUM)
                    end)
                    pcall(callback)
                end)

                -- Keep stripe colour in sync
                task.spawn(function()
                    while btn and btn.Parent do
                        stripe.BackgroundColor3 = accent()
                        RunService.Heartbeat:Wait()
                    end
                end)

                local api = {}
                function api:SetText(t)   btn.Text = tostring(t) end
                function api:SetEnabled(b)
                    btn.AutoButtonColor = b
                    Tween(btn, {TextColor3 = b and THEME.TEXT_PRIMARY or THEME.TEXT_MUTED}, TWEEN.FAST)
                end
                function api:SetColor(c)
                    Tween(stripe, {BackgroundColor3 = c}, TWEEN.FAST)
                end
                return api, btn
            end

            -- ═══════════════════════════════════════════════════════════
            --  Switch  (animated pill toggle)
            -- ═══════════════════════════════════════════════════════════
            function E:AddSwitch(sw_text, default_val, callback)
                sw_text     = tostring(sw_text or "Switch")
                default_val = (default_val == true)
                callback    = type(callback) == "function" and callback or function() end

                local toggled = default_val

                local row = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, row)
                Stroke(THEME.STROKE_FAINT, 1, row)

                local swLabel = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 12, 0.5, 0),
                    Size             = UDim2.new(1, -72, 0, 20),
                    Font             = Enum.Font.GothamMedium,
                    Text             = sw_text,
                    TextColor3       = THEME.TEXT_PRIMARY,
                    TextSize         = 13,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = row,
                })

                -- Pill track
                local track = New("Frame", {
                    BackgroundColor3 = toggled and accent() or THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -12, 0.5, 0),
                    Size             = UDim2.new(0, 42, 0, 22),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = row,
                })
                Corner(11, track)
                local trackStroke = Stroke(toggled and accent() or THEME.STROKE_NORMAL, 1, track)

                -- Thumb
                local thumb = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size             = UDim2.new(0, 16, 0, 16),
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = track,
                })
                Corner(8, thumb)
                local thumbGlow = Glow(thumb, accent(), 10, 0.65)

                -- "On" label inside track
                local onLabel = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 4, 0.5, 0),
                    Size             = UDim2.new(0, 14, 1, 0),
                    Font             = Enum.Font.GothamBold,
                    Text             = toggled and "I" or "",
                    TextColor3       = Color3.fromRGB(255, 255, 255),
                    TextSize         = 9,
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = track,
                })

                local function applyToggle(val, fire)
                    toggled = val
                    if toggled then
                        Tween(track,  {BackgroundColor3 = accent()},                   TWEEN.FAST)
                        Tween(trackStroke, {Color = accent()},                         TWEEN.FAST)
                        Tween(thumb,  {Position = UDim2.new(1, -18, 0.5, 0)},          TWEEN.SPRING)
                        Tween(thumbGlow, {ImageColor3 = accent(), ImageTransparency = 0.55}, TWEEN.FAST)
                        onLabel.Text = "I"
                    else
                        Tween(track,  {BackgroundColor3 = THEME.BG_ACTIVE},            TWEEN.FAST)
                        Tween(trackStroke, {Color = THEME.STROKE_NORMAL},              TWEEN.FAST)
                        Tween(thumb,  {Position = UDim2.new(0, 2, 0.5, 0)},            TWEEN.SPRING)
                        Tween(thumbGlow, {ImageColor3 = THEME.STROKE_NORMAL, ImageTransparency = 0.85}, TWEEN.FAST)
                        onLabel.Text = ""
                    end
                    if fire then pcall(callback, toggled) end
                end

                -- Invisible full-row click button
                local clickBtn = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 1, 0),
                    Text   = "",
                    ZIndex = WIN_Z + 5 + zOff,
                    Parent = row,
                })
                clickBtn.MouseButton1Click:Connect(function()
                    applyToggle(not toggled, true)
                    Ripple(row, Mouse.X, Mouse.Y, accent())
                end)
                row.MouseEnter:Connect(function() Tween(row, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                row.MouseLeave:Connect(function() Tween(row, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                applyToggle(default_val, false)

                local sw_api = {}
                function sw_api:Set(val)    applyToggle((val == true), true) end
                function sw_api:Get()       return toggled end
                function sw_api:SetText(t)  swLabel.Text = tostring(t) end
                return sw_api, row
            end

            -- ═══════════════════════════════════════════════════════════
            --  TextBox
            -- ═══════════════════════════════════════════════════════════
            function E:AddTextBox(placeholder, callback, tb_opts)
                placeholder = tostring(placeholder or "Type here…")
                callback    = type(callback) == "function" and callback or function() end
                tb_opts     = type(tb_opts) == "table" and tb_opts or {}

                local clear_on_submit = (tb_opts.clear ~= false)
                local numeric_only    = (tb_opts.numeric == true)
                local max_chars       = tonumber(tb_opts.max_chars) or 0

                local row = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 36),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, row)
                local rowStroke = Stroke(THEME.STROKE_FAINT, 1, row)

                local prefixLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 10, 0.5, 0),
                    Size             = UDim2.new(0, 16, 0, 18),
                    Font             = Enum.Font.GothamBold,
                    Text             = numeric_only and "#" or "›",
                    TextColor3       = THEME.TEXT_MUTED,
                    TextSize         = 16,
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = row,
                })

                local tb = New("TextBox", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 30, 0.5, 0),
                    Size             = UDim2.new(1, -40, 0, 24),
                    Font             = Enum.Font.Gotham,
                    PlaceholderColor3 = THEME.TEXT_MUTED,
                    PlaceholderText  = placeholder,
                    Text             = "",
                    TextColor3       = THEME.TEXT_PRIMARY,
                    TextSize         = 13,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false,
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = row,
                })

                tb.Focused:Connect(function()
                    Tween(rowStroke, {Color = accent(), Thickness = 1.5}, TWEEN.FAST)
                    Tween(prefixLbl, {TextColor3 = accent()},              TWEEN.FAST)
                end)
                tb.FocusLost:Connect(function(ep)
                    Tween(rowStroke, {Color = THEME.STROKE_FAINT, Thickness = 1}, TWEEN.FAST)
                    Tween(prefixLbl, {TextColor3 = THEME.TEXT_MUTED},             TWEEN.FAST)
                    if ep then
                        local txt = tb.Text
                        if numeric_only and tonumber(txt) == nil then
                            tb.Text = ""
                            return
                        end
                        if #txt > 0 then
                            pcall(callback, txt)
                            if clear_on_submit then tb.Text = "" end
                        end
                    end
                end)

                if max_chars > 0 then
                    tb:GetPropertyChangedSignal("Text"):Connect(function()
                        if #tb.Text > max_chars then
                            tb.Text = string.sub(tb.Text, 1, max_chars)
                        end
                    end)
                end

                local tb_api = {}
                function tb_api:Set(val)  tb.Text = tostring(val) end
                function tb_api:Get()     return tb.Text end
                function tb_api:Clear()   tb.Text = "" end
                function tb_api:SetPlaceholder(p) tb.PlaceholderText = tostring(p) end
                function tb_api:Focus()   tb:CaptureFocus() end
                return tb_api, row
            end

            -- ═══════════════════════════════════════════════════════════
            --  NumericBox  (text box with − / + stepper buttons)
            -- ═══════════════════════════════════════════════════════════
            function E:AddNumericBox(label_text, callback, nb_opts)
                label_text = tostring(label_text or "Value")
                callback   = type(callback) == "function" and callback or function() end
                nb_opts    = type(nb_opts) == "table" and nb_opts or {}

                local min_v  = tonumber(nb_opts.min)     or 0
                local max_v  = tonumber(nb_opts.max)     or 9999
                local step   = tonumber(nb_opts.step)    or 1
                local def    = tonumber(nb_opts.default) or min_v
                local suffix = tostring(nb_opts.suffix   or "")

                local curVal = Clamp(def, min_v, max_v)

                local row = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, row)
                Stroke(THEME.STROKE_FAINT, 1, row)

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 12, 0.5, 0),
                    Size             = UDim2.new(1, -160, 0, 20),
                    Font             = Enum.Font.GothamMedium,
                    Text             = label_text,
                    TextColor3       = THEME.TEXT_PRIMARY,
                    TextSize         = 13,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = row,
                })

                -- − button
                local function StepBtn(sym, xOffset)
                    local b = New("TextButton", {
                        BackgroundColor3 = THEME.BG_ACTIVE,
                        BorderSizePixel  = 0,
                        AnchorPoint      = Vector2.new(1, 0.5),
                        Position         = UDim2.new(1, xOffset, 0.5, 0),
                        Size             = UDim2.new(0, 24, 0, 24),
                        Font             = Enum.Font.GothamBold,
                        Text             = sym,
                        TextColor3       = THEME.TEXT_SECONDARY,
                        TextSize         = 14,
                        ZIndex           = WIN_Z + 4 + zOff,
                        Parent           = row,
                    })
                    Corner(6, b)
                    b.MouseEnter:Connect(function() Tween(b, {BackgroundColor3 = accent(), TextColor3 = THEME.TEXT_ACCENT}, TWEEN.FAST) end)
                    b.MouseLeave:Connect(function() Tween(b, {BackgroundColor3 = THEME.BG_ACTIVE, TextColor3 = THEME.TEXT_SECONDARY}, TWEEN.FAST) end)
                    return b
                end

                local decBtn = StepBtn("−", -88)
                local incBtn = StepBtn("+", -60)

                local valBox = New("TextBox", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -116, 0.5, 0),
                    Size             = UDim2.new(0, 48, 0, 24),
                    Font             = Enum.Font.GothamMedium,
                    Text             = tostring(curVal) .. suffix,
                    TextColor3       = accent(),
                    TextSize         = 12,
                    ZIndex           = WIN_Z + 4 + zOff,
                    ClearTextOnFocus = true,
                    Parent           = row,
                })

                local function ApplyVal(v, fire)
                    v      = Clamp(RoundToStep(tonumber(v) or curVal, step), min_v, max_v)
                    curVal = v
                    valBox.Text = tostring(v) .. suffix
                    if fire then pcall(callback, v) end
                end

                decBtn.MouseButton1Click:Connect(function() ApplyVal(curVal - step, true) end)
                incBtn.MouseButton1Click:Connect(function() ApplyVal(curVal + step, true) end)
                valBox.FocusLost:Connect(function(ep)
                    if ep then ApplyVal(tonumber(valBox.Text) or curVal, true) end
                end)

                local api = {}
                function api:Set(v)  ApplyVal(v, true) end
                function api:Get()   return curVal end
                return api, row
            end

            -- ═══════════════════════════════════════════════════════════
            --  Slider
            -- ═══════════════════════════════════════════════════════════
            function E:AddSlider(sl_text, callback, sl_opts)
                sl_text  = tostring(sl_text or "Slider")
                callback = type(callback) == "function" and callback or function() end
                sl_opts  = type(sl_opts) == "table" and sl_opts or {}

                local min_v    = tonumber(sl_opts.min)     or 0
                local max_v    = tonumber(sl_opts.max)     or 100
                local def      = tonumber(sl_opts.default) or min_v
                local step     = tonumber(sl_opts.step)    or 1
                local suffix   = tostring(sl_opts.suffix   or "")
                local readonly = (sl_opts.readonly == true)
                local curVal   = Clamp(def, min_v, max_v)

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 54),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)
                Padding(8, 12, 8, 12, card)

                -- Label row
                local topRow = New("Frame", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 0, 18),
                    ZIndex       = WIN_Z + 3 + zOff,
                    Parent       = card,
                })
                local slLabel = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 0.5),
                    Position     = UDim2.new(0, 0, 0.5, 0),
                    Size         = UDim2.new(1, -60, 1, 0),
                    Font         = Enum.Font.GothamMedium,
                    Text         = sl_text,
                    TextColor3   = THEME.TEXT_PRIMARY,
                    TextSize     = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex       = WIN_Z + 4 + zOff,
                    Parent       = topRow,
                })
                local valBadge = New("Frame", {
                    BackgroundColor3 = THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, 0, 0.5, 0),
                    Size             = UDim2.new(0, 54, 0, 18),
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = topRow,
                })
                Corner(4, valBadge)
                local valLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size         = UDim2.new(1, 0, 1, 0),
                    Font         = Enum.Font.GothamMedium,
                    Text         = tostring(curVal) .. suffix,
                    TextColor3   = accent(),
                    TextSize     = 11,
                    ZIndex       = WIN_Z + 5 + zOff,
                    Parent       = valBadge,
                })

                -- Track row
                local trackRow = New("Frame", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 1),
                    Position     = UDim2.new(0, 0, 1, 0),
                    Size         = UDim2.new(1, 0, 0, 20),
                    ZIndex       = WIN_Z + 3 + zOff,
                    Parent       = card,
                })

                local track = New("Frame", {
                    BackgroundColor3 = THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 0, 0.5, 0),
                    Size             = UDim2.new(1, 0, 0, 6),
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = trackRow,
                })
                Corner(3, track)

                local fill = New("Frame", {
                    BackgroundColor3 = accent(),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 0, 0.5, 0),
                    Size             = UDim2.new(0, 0, 0, 6),
                    ZIndex           = WIN_Z + 5 + zOff,
                    Parent           = track,
                })
                Corner(3, fill)
                New("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, accent()),
                        ColorSequenceKeypoint.new(1, accentBright()),
                    }),
                    Parent = fill,
                })

                local thumb = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0.5, 0.5),
                    Position         = UDim2.new(0, 0, 0.5, 0),
                    Size             = UDim2.new(0, 16, 0, 16),
                    Active           = true,
                    ZIndex           = WIN_Z + 6 + zOff,
                    Parent           = track,
                })
                Corner(8, thumb)
                Stroke(accent(), 2, thumb)
                local thumbGlow = Glow(thumb, accent(), 14, 0.52)

                local function CalcPercent(val)
                    return (Clamp(val, min_v, max_v) - min_v) / math.max(max_v - min_v, 0.001)
                end

                local function ApplySlider(val, fire)
                    val    = RoundToStep(val, step)
                    val    = Clamp(val, min_v, max_v)
                    curVal = val
                    local pct = CalcPercent(val)
                    Tween(fill,  {Size = UDim2.new(pct, 0, 0, 6)},      TWEEN.FAST)
                    Tween(thumb, {Position = UDim2.new(pct, 0, 0.5, 0)}, TWEEN.FAST)
                    valLbl.Text = tostring(val) .. suffix
                    fill.BackgroundColor3   = accent()
                    thumb:FindFirstChild("_Stroke") and (thumb:FindFirstChild("_Stroke").Color = accent())
                    thumbGlow.ImageColor3   = accent()
                    if fire then pcall(callback, val) end
                end

                local function InputPosToVal(absX)
                    local rel = absX - track.AbsolutePosition.X
                    local pct = Clamp(rel / track.AbsoluteSize.X, 0, 1)
                    return min_v + pct * (max_v - min_v)
                end

                local _slDragging = false
                track.InputBegan:Connect(function(inp)
                    if readonly then return end
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        _slDragging = true
                        ApplySlider(InputPosToVal(inp.Position.X), true)
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if _slDragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
                        ApplySlider(InputPosToVal(inp.Position.X), true)
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        _slDragging = false
                    end
                end)

                thumb.MouseEnter:Connect(function()
                    if not readonly then Tween(thumb, {Size = UDim2.new(0, 20, 0, 20)}, TWEEN.FAST) end
                end)
                thumb.MouseLeave:Connect(function()
                    if not _slDragging then Tween(thumb, {Size = UDim2.new(0, 16, 0, 16)}, TWEEN.FAST) end
                end)
                card.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                card.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                ApplySlider(def, false)

                local sl_api = {}
                function sl_api:Set(val) ApplySlider(tonumber(val) or min_v, true) end
                function sl_api:Get()    return curVal end
                function sl_api:SetText(t) slLabel.Text = tostring(t) end
                function sl_api:SetMin(m) min_v = tonumber(m) or min_v end
                function sl_api:SetMax(m) max_v = tonumber(m) or max_v end
                return sl_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  Dropdown  (single-select, animated list)
            -- ═══════════════════════════════════════════════════════════
            function E:AddDropdown(dd_text, items, callback, dd_opts)
                dd_text  = tostring(dd_text or "Dropdown")
                items    = type(items) == "table" and items or {}
                callback = type(callback) == "function" and callback or function() end
                dd_opts  = type(dd_opts) == "table" and dd_opts or {}

                local def_idx = tonumber(dd_opts.default) or 1
                local selected = tostring(items[def_idx] or "Select…")
                local opened   = false

                local ITEM_H  = 30
                local MAX_H   = math.min(#items * (ITEM_H + 3) + 8, 180)

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ClipsDescendants = false,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                local cardStroke = Stroke(THEME.STROKE_FAINT, 1, card)

                local header = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 34),
                    Text   = "",
                    ZIndex = WIN_Z + 5 + zOff,
                    Parent = card,
                })

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 0.5),
                    Position     = UDim2.new(0, 12, 0.5, -8),
                    Size         = UDim2.new(1, -50, 0, 14),
                    Font         = Enum.Font.GothamMedium,
                    Text         = dd_text,
                    TextColor3   = THEME.TEXT_SECONDARY,
                    TextSize     = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex       = WIN_Z + 6 + zOff,
                    Parent       = header,
                })

                local selLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 0.5),
                    Position     = UDim2.new(0, 12, 0.5, 8),
                    Size         = UDim2.new(1, -50, 0, 14),
                    Font         = Enum.Font.Gotham,
                    Text         = selected,
                    TextColor3   = THEME.TEXT_PRIMARY,
                    TextSize     = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex       = WIN_Z + 6 + zOff,
                    Parent       = header,
                })

                local chevron = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(1, 0.5),
                    Position     = UDim2.new(1, -12, 0.5, 0),
                    Size         = UDim2.new(0, 14, 0, 14),
                    Font         = Enum.Font.GothamBold,
                    Text         = "⌄",
                    TextColor3   = THEME.TEXT_MUTED,
                    TextSize     = 14,
                    ZIndex       = WIN_Z + 6 + zOff,
                    Parent       = header,
                })

                local listBg = New("Frame", {
                    BackgroundColor3 = THEME.BG_PANEL,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 1, 4),
                    Size             = UDim2.new(1, 0, 0, 0),
                    ClipsDescendants = true,
                    Visible          = false,
                    ZIndex           = WIN_Z + 28 + zOff,
                    Parent           = card,
                })
                Corner(8, listBg)
                Stroke(THEME.STROKE_NORMAL, 1, listBg)

                local listScroll = New("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 1, 0),
                    CanvasSize       = UDim2.new(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness  = 3,
                    ScrollBarImageColor3 = THEME.STROKE_BRIGHT,
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = listBg,
                })
                Padding(4, 4, 4, 4, listScroll)
                List(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Left, listScroll)

                local function buildItems()
                    for _, c in pairs(listScroll:GetChildren()) do
                        if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
                    end
                    for idx, item_text in ipairs(items) do
                        local str  = tostring(item_text)
                        local iBtn = New("TextButton", {
                            BackgroundColor3 = THEME.BG_PANEL,
                            BorderSizePixel  = 0,
                            Size             = UDim2.new(1, 0, 0, ITEM_H),
                            Font             = Enum.Font.Gotham,
                            Text             = str,
                            TextColor3       = str == selected and accent() or THEME.TEXT_PRIMARY,
                            TextSize         = 13,
                            ZIndex           = WIN_Z + 30 + zOff,
                            Parent           = listScroll,
                        })
                        Corner(6, iBtn)
                        iBtn.MouseEnter:Connect(function() Tween(iBtn, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST) end)
                        iBtn.MouseLeave:Connect(function() Tween(iBtn, {BackgroundColor3 = THEME.BG_PANEL}, TWEEN.FAST) end)
                        iBtn.MouseButton1Click:Connect(function()
                            selected    = str
                            selLbl.Text = selected
                            opened      = false
                            Tween(card,    {Size = UDim2.new(1, 0, 0, 34)}, TWEEN.MEDIUM)
                            Tween(listBg,  {Size = UDim2.new(1, 0, 0, 0)},  TWEEN.MEDIUM)
                            Tween(chevron, {Rotation = 0},                   TWEEN.MEDIUM)
                            Tween(cardStroke, {Color = THEME.STROKE_FAINT},  TWEEN.FAST)
                            task.delay(0.22, function() listBg.Visible = false end)
                            for _, b in pairs(listScroll:GetChildren()) do
                                if b:IsA("TextButton") then
                                    Tween(b, {TextColor3 = b.Text == selected and accent() or THEME.TEXT_PRIMARY}, TWEEN.FAST)
                                end
                            end
                            pcall(callback, selected, idx)
                        end)
                    end
                end
                buildItems()

                header.MouseButton1Click:Connect(function()
                    opened = not opened
                    if opened then
                        listBg.Visible = true
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34 + MAX_H + 4)}, TWEEN.MEDIUM)
                        Tween(listBg,  {Size = UDim2.new(1, 0, 0, MAX_H)},          TWEEN.MEDIUM)
                        Tween(chevron, {Rotation = 180},                             TWEEN.MEDIUM)
                        Tween(cardStroke, {Color = accent()},                        TWEEN.FAST)
                    else
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34)},             TWEEN.MEDIUM)
                        Tween(listBg,  {Size = UDim2.new(1, 0, 0, 0)},              TWEEN.MEDIUM)
                        Tween(chevron, {Rotation = 0},                               TWEEN.MEDIUM)
                        Tween(cardStroke, {Color = THEME.STROKE_FAINT},              TWEEN.FAST)
                        task.delay(0.22, function() listBg.Visible = false end)
                    end
                end)
                header.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                header.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                local dd_api = {}
                function dd_api:Set(val)
                    selected    = tostring(val)
                    selLbl.Text = selected
                end
                function dd_api:Get() return selected end
                function dd_api:Refresh(new_items)
                    items   = new_items or {}
                    MAX_H   = math.min(#items * (ITEM_H + 3) + 8, 180)
                    buildItems()
                end
                return dd_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  SearchDropdown  (dropdown with built-in search field)
            -- ═══════════════════════════════════════════════════════════
            function E:AddSearchDropdown(dd_text, items, callback)
                dd_text  = tostring(dd_text or "Search…")
                items    = type(items) == "table" and items or {}
                callback = type(callback) == "function" and callback or function() end

                local allItems = {}
                for _, v in ipairs(items) do table.insert(allItems, tostring(v)) end

                local selected = "Select…"
                local opened   = false
                local ITEM_H   = 28

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ClipsDescendants = false,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                local cStroke = Stroke(THEME.STROKE_FAINT, 1, card)

                local header = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 34),
                    Text   = "",
                    ZIndex = WIN_Z + 5 + zOff,
                    Parent = card,
                })
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, -8),
                    Size        = UDim2.new(1, -50, 0, 12),
                    Font        = Enum.Font.GothamMedium,
                    Text        = dd_text,
                    TextColor3  = THEME.TEXT_SECONDARY,
                    TextSize    = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })
                local selLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, 8),
                    Size        = UDim2.new(1, -50, 0, 14),
                    Font        = Enum.Font.Gotham,
                    Text        = selected,
                    TextColor3  = THEME.TEXT_PRIMARY,
                    TextSize    = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })
                local chevron = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position    = UDim2.new(1, -12, 0.5, 0),
                    Size        = UDim2.new(0, 14, 0, 14),
                    Font        = Enum.Font.GothamBold,
                    Text        = "⌄",
                    TextColor3  = THEME.TEXT_MUTED,
                    TextSize    = 14,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })

                -- Panel
                local panel = New("Frame", {
                    BackgroundColor3 = THEME.BG_PANEL,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 1, 4),
                    Size             = UDim2.new(1, 0, 0, 0),
                    ClipsDescendants = true,
                    Visible          = false,
                    ZIndex           = WIN_Z + 28 + zOff,
                    Parent           = card,
                })
                Corner(8, panel)
                Stroke(THEME.STROKE_NORMAL, 1, panel)

                -- Search input inside panel
                local searchRow = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 6, 0, 6),
                    Size             = UDim2.new(1, -12, 0, 28),
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = panel,
                })
                Corner(6, searchRow)
                Stroke(THEME.STROKE_FAINT, 1, searchRow)

                local searchBox = New("TextBox", {
                    BackgroundTransparency = 1,
                    Position         = UDim2.new(0, 8, 0, 0),
                    Size             = UDim2.new(1, -16, 1, 0),
                    Font             = Enum.Font.Gotham,
                    PlaceholderText  = "Search…",
                    PlaceholderColor3 = THEME.TEXT_MUTED,
                    Text             = "",
                    TextColor3       = THEME.TEXT_PRIMARY,
                    TextSize         = 12,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false,
                    ZIndex           = WIN_Z + 30 + zOff,
                    Parent           = searchRow,
                })

                -- Scrolling item list
                local listScroll = New("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 0, 40),
                    Size             = UDim2.new(1, 0, 1, -40),
                    CanvasSize       = UDim2.new(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness  = 3,
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = panel,
                })
                Padding(0, 4, 4, 4, listScroll)
                List(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Left, listScroll)

                local function populateItems(filter)
                    for _, c in pairs(listScroll:GetChildren()) do
                        if c:IsA("TextButton") then c:Destroy() end
                    end
                    local count = 0
                    for _, str in ipairs(allItems) do
                        if filter == "" or str:lower():find(filter:lower(), 1, true) then
                            count = count + 1
                            local iBtn = New("TextButton", {
                                BackgroundColor3 = THEME.BG_PANEL,
                                BorderSizePixel  = 0,
                                Size             = UDim2.new(1, 0, 0, ITEM_H),
                                Font             = Enum.Font.Gotham,
                                Text             = str,
                                TextColor3       = str == selected and accent() or THEME.TEXT_PRIMARY,
                                TextSize         = 12,
                                ZIndex           = WIN_Z + 30 + zOff,
                                Parent           = listScroll,
                            })
                            Corner(5, iBtn)
                            iBtn.MouseEnter:Connect(function() Tween(iBtn, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST) end)
                            iBtn.MouseLeave:Connect(function() Tween(iBtn, {BackgroundColor3 = THEME.BG_PANEL}, TWEEN.FAST) end)
                            local captured = str
                            iBtn.MouseButton1Click:Connect(function()
                                selected    = captured
                                selLbl.Text = captured
                                opened      = false
                                local totalH = 34 + math.min(count * (ITEM_H + 3) + 8, 160) + 46
                                Tween(card,  {Size = UDim2.new(1, 0, 0, 34)}, TWEEN.MEDIUM)
                                Tween(panel, {Size = UDim2.new(1, 0, 0, 0)},  TWEEN.MEDIUM)
                                Tween(chevron, {Rotation = 0},                 TWEEN.MEDIUM)
                                task.delay(0.22, function() panel.Visible = false end)
                                pcall(callback, captured)
                            end)
                        end
                    end
                    -- Update panel height
                    local itemArea = math.min(count * (ITEM_H + 3) + 4, 150)
                    local totalH   = 46 + itemArea
                    if opened then
                        Tween(card,  {Size = UDim2.new(1, 0, 0, 34 + totalH + 4)}, TWEEN.FAST)
                        Tween(panel, {Size = UDim2.new(1, 0, 0, totalH)},           TWEEN.FAST)
                    end
                end

                searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                    populateItems(searchBox.Text)
                end)
                populateItems("")

                header.MouseButton1Click:Connect(function()
                    opened = not opened
                    local itemArea = math.min(#allItems * (ITEM_H + 3) + 4, 150)
                    local totalH   = 46 + itemArea
                    if opened then
                        panel.Visible = true
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34 + totalH + 4)}, TWEEN.MEDIUM)
                        Tween(panel,   {Size = UDim2.new(1, 0, 0, totalH)},           TWEEN.MEDIUM)
                        Tween(chevron, {Rotation = 180},                               TWEEN.MEDIUM)
                        Tween(cStroke, {Color = accent()},                             TWEEN.FAST)
                    else
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34)},              TWEEN.MEDIUM)
                        Tween(panel,   {Size = UDim2.new(1, 0, 0, 0)},               TWEEN.MEDIUM)
                        Tween(chevron, {Rotation = 0},                                TWEEN.MEDIUM)
                        Tween(cStroke, {Color = THEME.STROKE_FAINT},                  TWEEN.FAST)
                        task.delay(0.22, function() panel.Visible = false end)
                    end
                end)
                header.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                header.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                local api = {}
                function api:Get()  return selected end
                function api:Set(v) selected = tostring(v); selLbl.Text = selected end
                function api:Refresh(new) allItems = {}; for _, v in ipairs(new or {}) do table.insert(allItems, tostring(v)) end; populateItems("") end
                return api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  MultiDropdown
            -- ═══════════════════════════════════════════════════════════
            function E:AddMultiDropdown(dd_text, items, callback, max_sel)
                dd_text  = tostring(dd_text or "Multi-Select")
                items    = type(items) == "table" and items or {}
                callback = type(callback) == "function" and callback or function() end
                max_sel  = tonumber(max_sel) or #items

                local selected = {}
                local opened   = false
                local ITEM_H   = 30
                local MAX_H    = math.min(#items * (ITEM_H + 3) + 8, 180)

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ClipsDescendants = false,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                local cStroke = Stroke(THEME.STROKE_FAINT, 1, card)

                local header = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 34),
                    Text   = "",
                    ZIndex = WIN_Z + 5 + zOff,
                    Parent = card,
                })
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, -8),
                    Size        = UDim2.new(1, -55, 0, 12),
                    Font        = Enum.Font.GothamMedium,
                    Text        = dd_text,
                    TextColor3  = THEME.TEXT_SECONDARY,
                    TextSize    = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })
                local valLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, 8),
                    Size        = UDim2.new(1, -55, 0, 14),
                    Font        = Enum.Font.Gotham,
                    Text        = "None",
                    TextColor3  = THEME.TEXT_MUTED,
                    TextSize    = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })

                -- Count badge
                local countBadge = New("Frame", {
                    BackgroundColor3 = THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -30, 0.5, 0),
                    Size             = UDim2.new(0, 18, 0, 18),
                    Visible          = false,
                    ZIndex           = WIN_Z + 6 + zOff,
                    Parent           = header,
                })
                Corner(9, countBadge)
                local countLbl = New("TextLabel", {
                    BackgroundTransparency = 1,
                    Size       = UDim2.new(1, 0, 1, 0),
                    Font       = Enum.Font.GothamBold,
                    Text       = "0",
                    TextColor3 = accent(),
                    TextSize   = 10,
                    ZIndex     = WIN_Z + 7 + zOff,
                    Parent     = countBadge,
                })

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position    = UDim2.new(1, -12, 0.5, 0),
                    Size        = UDim2.new(0, 14, 0, 14),
                    Font        = Enum.Font.GothamBold,
                    Text        = "⌄",
                    TextColor3  = THEME.TEXT_MUTED,
                    TextSize    = 14,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = header,
                })

                local listBg = New("Frame", {
                    BackgroundColor3 = THEME.BG_PANEL,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 1, 4),
                    Size             = UDim2.new(1, 0, 0, 0),
                    ClipsDescendants = true,
                    Visible          = false,
                    ZIndex           = WIN_Z + 28 + zOff,
                    Parent           = card,
                })
                Corner(8, listBg)
                Stroke(THEME.STROKE_NORMAL, 1, listBg)

                local listScroll = New("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 1, 0),
                    CanvasSize       = UDim2.new(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness  = 3,
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = listBg,
                })
                Padding(4, 4, 4, 4, listScroll)
                List(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Left, listScroll)

                local function UpdateCount()
                    if #selected == 0 then
                        valLbl.Text  = "None"
                        valLbl.TextColor3 = THEME.TEXT_MUTED
                        countBadge.Visible = false
                    else
                        valLbl.Text  = table.concat(selected, ", ")
                        valLbl.TextColor3 = THEME.TEXT_PRIMARY
                        countBadge.Visible = true
                        countLbl.Text = tostring(#selected)
                    end
                end

                for _, item_text in ipairs(items) do
                    local str  = tostring(item_text)
                    local chk  = false

                    local row_ = New("Frame", {
                        BackgroundColor3 = THEME.BG_PANEL,
                        BorderSizePixel  = 0,
                        Size             = UDim2.new(1, 0, 0, ITEM_H),
                        ZIndex           = WIN_Z + 30 + zOff,
                        Parent           = listScroll,
                    })
                    Corner(6, row_)

                    local checkBg = New("Frame", {
                        BackgroundColor3 = THEME.BG_ACTIVE,
                        BorderSizePixel  = 0,
                        AnchorPoint      = Vector2.new(0, 0.5),
                        Position         = UDim2.new(0, 8, 0.5, 0),
                        Size             = UDim2.new(0, 16, 0, 16),
                        ZIndex           = WIN_Z + 31 + zOff,
                        Parent           = row_,
                    })
                    Corner(4, checkBg)
                    Stroke(THEME.STROKE_NORMAL, 1, checkBg)

                    local checkMark_ = New("TextLabel", {
                        BackgroundTransparency = 1,
                        Size       = UDim2.new(1, 0, 1, 0),
                        Font       = Enum.Font.GothamBold,
                        Text       = "✓",
                        TextColor3 = accent(),
                        TextSize   = 10,
                        Visible    = false,
                        ZIndex     = WIN_Z + 32 + zOff,
                        Parent     = checkBg,
                    })

                    New("TextLabel", {
                        BackgroundTransparency = 1,
                        AnchorPoint      = Vector2.new(0, 0.5),
                        Position         = UDim2.new(0, 32, 0.5, 0),
                        Size             = UDim2.new(1, -40, 1, 0),
                        Font             = Enum.Font.Gotham,
                        Text             = str,
                        TextColor3       = THEME.TEXT_PRIMARY,
                        TextSize         = 13,
                        TextXAlignment   = Enum.TextXAlignment.Left,
                        ZIndex           = WIN_Z + 31 + zOff,
                        Parent           = row_,
                    })

                    local rowBtn = New("TextButton", {
                        BackgroundTransparency = 1,
                        Size   = UDim2.new(1, 0, 1, 0),
                        Text   = "",
                        ZIndex = WIN_Z + 33 + zOff,
                        Parent = row_,
                    })
                    rowBtn.MouseEnter:Connect(function() Tween(row_, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST) end)
                    rowBtn.MouseLeave:Connect(function() Tween(row_, {BackgroundColor3 = THEME.BG_PANEL}, TWEEN.FAST) end)
                    rowBtn.MouseButton1Click:Connect(function()
                        chk = not chk
                        if chk then
                            if #selected >= max_sel then chk = false; return end
                            table.insert(selected, str)
                            checkMark_.Visible = true
                            Tween(checkBg, {BackgroundColor3 = accent()}, TWEEN.FAST)
                        else
                            for i, v in ipairs(selected) do
                                if v == str then table.remove(selected, i); break end
                            end
                            checkMark_.Visible = false
                            Tween(checkBg, {BackgroundColor3 = THEME.BG_ACTIVE}, TWEEN.FAST)
                        end
                        UpdateCount()
                        pcall(callback, selected)
                    end)
                end

                header.MouseButton1Click:Connect(function()
                    opened = not opened
                    if opened then
                        listBg.Visible = true
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34 + MAX_H + 4)}, TWEEN.MEDIUM)
                        Tween(listBg,  {Size = UDim2.new(1, 0, 0, MAX_H)},          TWEEN.MEDIUM)
                        Tween(cStroke, {Color = accent()},                           TWEEN.FAST)
                    else
                        Tween(card,    {Size = UDim2.new(1, 0, 0, 34)},             TWEEN.MEDIUM)
                        Tween(listBg,  {Size = UDim2.new(1, 0, 0, 0)},              TWEEN.MEDIUM)
                        Tween(cStroke, {Color = THEME.STROKE_FAINT},                TWEEN.FAST)
                        task.delay(0.22, function() listBg.Visible = false end)
                    end
                end)
                header.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                header.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                local mdd_api = {}
                function mdd_api:GetSelected() return selected end
                function mdd_api:Clear()
                    selected = {}
                    UpdateCount()
                    for _, c in pairs(listScroll:GetChildren()) do
                        if c:IsA("Frame") then
                            local cb_ = c:FindFirstChildOfClass("Frame")
                            if cb_ then Tween(cb_, {BackgroundColor3 = THEME.BG_ACTIVE}, TWEEN.FAST) end
                            local cm_ = c:FindFirstChild("TextLabel")
                            if cm_ and cm_.Text == "✓" then cm_.Visible = false end
                        end
                    end
                end
                return mdd_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  Keybind
            -- ═══════════════════════════════════════════════════════════
            function E:AddKeybind(kb_text, default_key, callback)
                kb_text     = tostring(kb_text or "Keybind")
                default_key = default_key or Enum.KeyCode.Unknown
                callback    = type(callback) == "function" and callback or function() end

                local curKey    = default_key
                local listening = false

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, 0),
                    Size        = UDim2.new(1, -120, 0, 20),
                    Font        = Enum.Font.GothamMedium,
                    Text        = kb_text,
                    TextColor3  = THEME.TEXT_PRIMARY,
                    TextSize    = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 3 + zOff,
                    Parent      = card,
                })

                local badge = New("TextButton", {
                    BackgroundColor3 = THEME.BG_ACTIVE,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -10, 0.5, 0),
                    Size             = UDim2.new(0, 100, 0, 22),
                    Font             = Enum.Font.GothamMedium,
                    Text             = tostring(curKey.Name),
                    TextColor3       = accent(),
                    TextSize         = 11,
                    ZIndex           = WIN_Z + 4 + zOff,
                    Parent           = card,
                })
                Corner(5, badge)
                Stroke(THEME.STROKE_NORMAL, 1, badge)

                badge.MouseButton1Click:Connect(function()
                    if listening then return end
                    listening   = true
                    badge.Text  = "…press key…"
                    badge.TextColor3 = THEME.WARNING
                    Tween(badge, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST)

                    local conn
                    conn = UserInputService.InputBegan:Connect(function(inp, gpe)
                        if gpe then return end
                        if inp.UserInputType == Enum.UserInputType.Keyboard then
                            curKey      = inp.KeyCode
                            badge.Text  = tostring(curKey.Name)
                            badge.TextColor3 = accent()
                            Tween(badge, {BackgroundColor3 = THEME.BG_ACTIVE}, TWEEN.FAST)
                            listening   = false
                            conn:Disconnect()
                            pcall(callback, curKey)
                        end
                    end)
                end)

                -- Global key listener (fires callback on press after binding)
                UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe or listening then return end
                    if inp.KeyCode == curKey then pcall(callback, curKey) end
                end)

                card.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                card.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                -- Keep badge accent in sync
                task.spawn(function()
                    while card and card.Parent do
                        if not listening then badge.TextColor3 = accent() end
                        RunService.Heartbeat:Wait()
                    end
                end)

                local api = {}
                function api:GetKey() return curKey end
                function api:Set(k)   curKey = k; badge.Text = tostring(k.Name) end
                return api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  ColorPicker
            -- ═══════════════════════════════════════════════════════════
            function E:AddColorPicker(cp_text, default_color, callback)
                cp_text       = tostring(cp_text or "Color")
                default_color = default_color or Color3.fromRGB(255, 100, 100)
                callback      = type(callback) == "function" and callback or function() end

                local curColor   = default_color
                local cpOpen     = false
                local hue_, sat_, val__ = Color3.toHSV(curColor)

                local card = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ClipsDescendants = false,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                local cpStroke = Stroke(THEME.STROKE_FAINT, 1, card)

                local hdrBtn = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 34),
                    Text   = "",
                    ZIndex = WIN_Z + 5 + zOff,
                    Parent = card,
                })
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 12, 0.5, 0),
                    Size        = UDim2.new(1, -80, 0, 20),
                    Font        = Enum.Font.GothamMedium,
                    Text        = cp_text,
                    TextColor3  = THEME.TEXT_PRIMARY,
                    TextSize    = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 6 + zOff,
                    Parent      = hdrBtn,
                })
                local swatch = New("Frame", {
                    BackgroundColor3 = curColor,
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(1, 0.5),
                    Position         = UDim2.new(1, -12, 0.5, 0),
                    Size             = UDim2.new(0, 52, 0, 20),
                    ZIndex           = WIN_Z + 6 + zOff,
                    Parent           = hdrBtn,
                })
                Corner(4, swatch)
                Stroke(THEME.STROKE_NORMAL, 1, swatch)

                -- Picker panel
                local panel = New("Frame", {
                    BackgroundColor3 = THEME.BG_PANEL,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 1, 4),
                    Size             = UDim2.new(1, 0, 0, 0),
                    ClipsDescendants = true,
                    Visible          = false,
                    ZIndex           = WIN_Z + 28 + zOff,
                    Parent           = card,
                })
                Corner(8, panel)
                Stroke(THEME.STROKE_NORMAL, 1, panel)

                -- SV gradient square
                local svSq = New("ImageLabel", {
                    BackgroundColor3 = Color3.fromHSV(hue_, 1, 1),
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 8, 0, 8),
                    Size             = UDim2.new(1, -16, 0, 130),
                    Image            = "rbxassetid://698052951",
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = panel,
                })
                Corner(6, svSq)

                local svCur = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0.5, 0.5),
                    Position         = UDim2.new(sat_, 0, 1 - val__, 0),
                    Size             = UDim2.new(0, 10, 0, 10),
                    ZIndex           = WIN_Z + 30 + zOff,
                    Parent           = svSq,
                })
                Corner(5, svCur)
                Stroke(Color3.fromRGB(0, 0, 0), 1.5, svCur)

                -- Hue bar
                local hueBar_ = New("ImageLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 8, 0, 148),
                    Size             = UDim2.new(1, -16, 0, 14),
                    Image            = "rbxassetid://698053212",
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = panel,
                })
                Corner(4, hueBar_)

                local hueCur_ = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0.5, 0.5),
                    Position         = UDim2.new(hue_, 0, 0.5, 0),
                    Size             = UDim2.new(0, 6, 1, 4),
                    ZIndex           = WIN_Z + 30 + zOff,
                    Parent           = hueBar_,
                })
                Corner(3, hueCur_)
                Stroke(Color3.fromRGB(0, 0, 0), 1, hueCur_)

                -- Hex row
                local hexRow = New("Frame", {
                    BackgroundColor3 = THEME.BG_ELEMENT,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 8, 0, 172),
                    Size             = UDim2.new(1, -16, 0, 28),
                    ZIndex           = WIN_Z + 29 + zOff,
                    Parent           = panel,
                })
                Corner(6, hexRow)
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 8, 0.5, 0),
                    Size        = UDim2.new(0, 14, 0, 18),
                    Font        = Enum.Font.GothamBold,
                    Text        = "#",
                    TextColor3  = THEME.TEXT_MUTED,
                    TextSize    = 13,
                    ZIndex      = WIN_Z + 30 + zOff,
                    Parent      = hexRow,
                })
                local hexBox = New("TextBox", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 22, 0.5, 0),
                    Size        = UDim2.new(1, -30, 0, 20),
                    Font        = Enum.Font.GothamMedium,
                    Text        = string.format("%02X%02X%02X",
                        math.floor(curColor.R * 255),
                        math.floor(curColor.G * 255),
                        math.floor(curColor.B * 255)),
                    TextColor3  = THEME.TEXT_PRIMARY,
                    TextSize    = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false,
                    ZIndex      = WIN_Z + 30 + zOff,
                    Parent      = hexRow,
                })

                local function SyncAll()
                    curColor              = Color3.fromHSV(hue_, sat_, val__)
                    swatch.BackgroundColor3  = curColor
                    svSq.BackgroundColor3    = Color3.fromHSV(hue_, 1, 1)
                    svCur.Position           = UDim2.new(sat_, 0, 1 - val__, 0)
                    hueCur_.Position         = UDim2.new(hue_, 0, 0.5, 0)
                    hexBox.Text              = string.format("%02X%02X%02X",
                        math.floor(curColor.R * 255),
                        math.floor(curColor.G * 255),
                        math.floor(curColor.B * 255))
                    pcall(callback, curColor)
                end

                -- SV drag
                local svDrag = false
                svSq.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        svDrag = true
                        sat_  = Clamp((inp.Position.X - svSq.AbsolutePosition.X) / svSq.AbsoluteSize.X, 0, 1)
                        val__ = 1 - Clamp((inp.Position.Y - svSq.AbsolutePosition.Y) / svSq.AbsoluteSize.Y, 0, 1)
                        SyncAll()
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if svDrag and inp.UserInputType == Enum.UserInputType.MouseMovement then
                        sat_  = Clamp((inp.Position.X - svSq.AbsolutePosition.X) / svSq.AbsoluteSize.X, 0, 1)
                        val__ = 1 - Clamp((inp.Position.Y - svSq.AbsolutePosition.Y) / svSq.AbsoluteSize.Y, 0, 1)
                        SyncAll()
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then svDrag = false end
                end)

                -- Hue drag
                local hueDrag = false
                hueBar_.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                        hueDrag = true
                        hue_ = Clamp((inp.Position.X - hueBar_.AbsolutePosition.X) / hueBar_.AbsoluteSize.X, 0, 1)
                        SyncAll()
                    end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if hueDrag and inp.UserInputType == Enum.UserInputType.MouseMovement then
                        hue_ = Clamp((inp.Position.X - hueBar_.AbsolutePosition.X) / hueBar_.AbsoluteSize.X, 0, 1)
                        SyncAll()
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 then hueDrag = false end
                end)

                -- Hex input
                hexBox.FocusLost:Connect(function()
                    local hex = hexBox.Text:gsub("[^%x]", "")
                    if #hex == 6 then
                        local r = tonumber("0x" .. hex:sub(1, 2)) or 0
                        local g = tonumber("0x" .. hex:sub(3, 4)) or 0
                        local b = tonumber("0x" .. hex:sub(5, 6)) or 0
                        curColor = Color3.fromRGB(r, g, b)
                        hue_, sat_, val__ = Color3.toHSV(curColor)
                        SyncAll()
                    end
                end)

                hdrBtn.MouseButton1Click:Connect(function()
                    cpOpen = not cpOpen
                    if cpOpen then
                        panel.Visible = true
                        Tween(card,     {Size = UDim2.new(1, 0, 0, 34 + 210 + 4)}, TWEEN.MEDIUM)
                        Tween(panel,    {Size = UDim2.new(1, 0, 0, 210)},           TWEEN.MEDIUM)
                        Tween(cpStroke, {Color = accent()},                         TWEEN.FAST)
                    else
                        Tween(card,     {Size = UDim2.new(1, 0, 0, 34)},            TWEEN.MEDIUM)
                        Tween(panel,    {Size = UDim2.new(1, 0, 0, 0)},             TWEEN.MEDIUM)
                        Tween(cpStroke, {Color = THEME.STROKE_FAINT},               TWEEN.FAST)
                        task.delay(0.22, function() panel.Visible = false end)
                    end
                end)
                card.MouseEnter:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_HOVER},    TWEEN.FAST) end)
                card.MouseLeave:Connect(function() Tween(card, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST) end)

                local cp_api = {}
                function cp_api:Get() return curColor end
                function cp_api:Set(col)
                    curColor = col
                    hue_, sat_, val__ = Color3.toHSV(col)
                    SyncAll()
                end
                return cp_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  Console  (Lua / Logs pane with full syntax highlighting)
            -- ═══════════════════════════════════════════════════════════
            function E:AddConsole(height, con_opts)
                height   = tonumber(height) or 200
                con_opts = type(con_opts) == "table" and con_opts or {}

                local source    = con_opts.source    or "Lua"   -- "Lua" | "Logs"
                local read_only = (con_opts.read_only == true)
                local font_size = tonumber(con_opts.font_size) or 14

                local card = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(13, 14, 18),
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, height),
                    ClipsDescendants = true,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, card)
                Stroke(THEME.STROKE_FAINT, 1, card)

                -- Header
                local hdr = New("Frame", {
                    BackgroundColor3 = Color3.fromRGB(10, 11, 15),
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 26),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = card,
                })
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 10, 0.5, 0),
                    Size        = UDim2.new(1, -100, 0, 16),
                    Font        = Enum.Font.GothamMedium,
                    Text        = source == "Logs" and "› Output" or "› Lua Editor",
                    TextColor3  = THEME.TEXT_MUTED,
                    TextSize    = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 4 + zOff,
                    Parent      = hdr,
                })

                -- Toolbar buttons (Clear + Copy)
                local function HdrBtn(lbl, xOff)
                    local b = New("TextButton", {
                        BackgroundColor3 = THEME.BG_ELEMENT,
                        BorderSizePixel  = 0,
                        AnchorPoint      = Vector2.new(1, 0.5),
                        Position         = UDim2.new(1, xOff, 0.5, 0),
                        Size             = UDim2.new(0, 42, 0, 18),
                        Font             = Enum.Font.GothamMedium,
                        Text             = lbl,
                        TextColor3       = THEME.TEXT_MUTED,
                        TextSize         = 10,
                        ZIndex           = WIN_Z + 4 + zOff,
                        Parent           = hdr,
                    })
                    Corner(4, b)
                    b.MouseEnter:Connect(function() Tween(b, {TextColor3 = THEME.TEXT_PRIMARY}, TWEEN.FAST) end)
                    b.MouseLeave:Connect(function() Tween(b, {TextColor3 = THEME.TEXT_MUTED},   TWEEN.FAST) end)
                    return b
                end
                local clearBtn = HdrBtn("Clear", -8)
                local copyBtn  = HdrBtn("Copy", -54)

                -- Scrolling editor area
                local sf = New("ScrollingFrame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 0, 0, 26),
                    Size             = UDim2.new(1, 0, 1, -26),
                    CanvasSize       = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness  = 3,
                    ScrollBarImageColor3 = Color3.fromRGB(55, 60, 80),
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = card,
                })

                -- Line number gutter
                local lineGutter = New("TextLabel", {
                    Name             = "Lines",
                    BackgroundColor3 = Color3.fromRGB(17, 18, 23),
                    BackgroundTransparency = 0,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(0, 36, 0, 10000),
                    Font             = Enum.Font.Code,
                    Text             = "1\n",
                    TextColor3       = Color3.fromRGB(60, 65, 88),
                    TextSize         = font_size,
                    TextWrapped      = true,
                    TextYAlignment   = Enum.TextYAlignment.Top,
                    ZIndex           = WIN_Z + 5 + zOff,
                    Parent           = sf,
                })

                -- Main source box
                local src = New("TextBox", {
                    Name             = "Source",
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 38, 0, 2),
                    Size             = UDim2.new(1, -42, 0, 10000),
                    ZIndex           = WIN_Z + 4 + zOff,
                    ClearTextOnFocus = false,
                    Font             = Enum.Font.Code,
                    MultiLine        = true,
                    PlaceholderColor3 = Color3.fromRGB(55, 60, 80),
                    PlaceholderText  = source == "Lua" and "-- Lua code here…" or "Logs appear here…",
                    Text             = "",
                    TextColor3       = THEME.SYN_BASE,
                    TextSize         = font_size,
                    TextEditable     = not read_only,
                    TextWrapped      = false,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    TextYAlignment   = Enum.TextYAlignment.Top,
                    Parent           = sf,
                })

                -- Syntax highlight overlay layers (each covers same area as src)
                local function MakeSynLayer(name_, color_)
                    return New("TextLabel", {
                        Name             = name_,
                        BackgroundTransparency = 1,
                        BorderSizePixel  = 0,
                        Position         = UDim2.new(0, 38, 0, 2),
                        Size             = UDim2.new(1, -42, 0, 10000),
                        ZIndex           = WIN_Z + 5 + zOff,
                        Font             = Enum.Font.Code,
                        Text             = "",
                        TextColor3       = color_,
                        TextSize         = font_size,
                        TextWrapped      = false,
                        TextXAlignment   = Enum.TextXAlignment.Left,
                        TextYAlignment   = Enum.TextYAlignment.Top,
                        Parent           = sf,
                    })
                end

                local lyrKeywords = MakeSynLayer("Keywords", THEME.SYN_KEYWORD)
                local lyrGlobals  = MakeSynLayer("Globals",  THEME.SYN_GLOBAL)
                local lyrStrings  = MakeSynLayer("Strings",  THEME.SYN_STRING)
                local lyrNumbers  = MakeSynLayer("Numbers",  THEME.SYN_NUMBER)
                local lyrComments = MakeSynLayer("Comments", THEME.SYN_COMMENT)
                local lyrRemotes  = MakeSynLayer("Remotes",  THEME.SYN_REMOTE)
                local lyrInfo     = MakeSynLayer("Info",     THEME.SYN_INFO_C)

                -- ── Highlighter helpers ───────────────────────────────────
                local function SpaceWord(text_, wordlist)
                    local out = string.rep(" ", #text_)
                    for _, word in ipairs(wordlist) do
                        local esc = word:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
                        local i   = 1
                        while i <= #text_ do
                            local ms, me = text_:find(esc, i, true)
                            if not ms then break end
                            -- Word boundary check
                            local b_ = ms > 1       and text_:sub(ms - 1, ms - 1) or ""
                            local a_ = me < #text_  and text_:sub(me + 1, me + 1) or ""
                            if (b_ == "" or not b_:match("[%w_]")) and (a_ == "" or not a_:match("[%w_]")) then
                                out = out:sub(1, ms - 1) .. text_:sub(ms, me) .. out:sub(me + 1)
                            end
                            i = me + 1
                        end
                    end
                    -- preserve newlines and tabs
                    local fixed = ""
                    for ci = 1, #text_ do
                        local c_ = text_:sub(ci, ci)
                        local o_ = out:sub(ci, ci)
                        if c_ == "\n" then fixed = fixed .. "\n"
                        elseif c_ == "\t" then fixed = fixed .. "\t"
                        else fixed = fixed .. o_ end
                    end
                    return fixed
                end

                local function HlStrings(str)
                    local out  = string.rep(" ", #str)
                    local inQ  = false
                    local delQ = nil
                    for i = 1, #str do
                        local c = str:sub(i, i)
                        if not inQ and (c == '"' or c == "'") then
                            inQ = true; delQ = c; out = out:sub(1, i - 1) .. c .. out:sub(i + 1)
                        elseif inQ and c == delQ then
                            inQ = false; out = out:sub(1, i - 1) .. c .. out:sub(i + 1)
                        elseif inQ then
                            if c == "\n" then inQ = false; out = out:sub(1, i - 1) .. "\n" .. out:sub(i + 1)
                            else out = out:sub(1, i - 1) .. c .. out:sub(i + 1) end
                        end
                    end
                    return out
                end

                local function HlComments(str)
                    local out = ""
                    for line in (str .. "\n"):gmatch("([^\n]*)\n") do
                        local inC  = false
                        local inS_ = false
                        local dS   = nil
                        for i = 1, #line do
                            local c  = line:sub(i, i)
                            local c2 = line:sub(i, i + 1)
                            if not inC and not inS_ and (c == '"' or c == "'") then
                                inS_ = true; dS = c; out = out .. " "
                            elseif inS_ and c == dS then
                                inS_ = false; out = out .. " "
                            elseif not inS_ and c2 == "--" then
                                inC = true; out = out .. c
                            elseif inC then
                                out = out .. c
                            else
                                out = out .. " "
                            end
                        end
                        out = out .. "\n"
                    end
                    return out
                end

                local function HlNumbers(str)
                    local out = ""
                    for i = 1, #str do
                        local c  = str:sub(i, i)
                        local pv = i > 1 and str:sub(i - 1, i - 1) or ""
                        if c:match("%d") and (pv == "" or not pv:match("[%w_]")) then
                            out = out .. c
                        elseif c == "\n" then out = out .. "\n"
                        elseif c == "\t" then out = out .. "\t"
                        else out = out .. " " end
                    end
                    return out
                end

                local function HlLogInfo(str)
                    local out = ""
                    local inB = false
                    for i = 1, #str do
                        local c = str:sub(i, i)
                        if     c == "["  then inB = true;  out = out .. c
                        elseif c == "]"  then inB = false; out = out .. c
                        elseif inB       then               out = out .. c
                        elseif c == "\n" then               out = out .. "\n"
                        else                                out = out .. " " end
                    end
                    return out
                end

                local LINE_H = font_size + 3

                local function UpdateLines(text_)
                    local n = 1
                    for _ in text_:gmatch("\n") do n = n + 1 end
                    local s = ""
                    for i = 1, n do s = s .. i .. "\n" end
                    lineGutter.Text = s
                    sf.CanvasSize = UDim2.new(0, 0, 0, n * LINE_H + 10)
                end

                local function RunHighlight()
                    local text_ = src.Text
                    if source == "Lua" then
                        lyrKeywords.Text = SpaceWord(text_, LUA_KEYWORDS)
                        lyrGlobals.Text  = SpaceWord(text_, LUA_GLOBALS)
                        lyrStrings.Text  = HlStrings(text_)
                        lyrNumbers.Text  = HlNumbers(text_)
                        lyrComments.Text = HlComments(text_)
                        lyrRemotes.Text  = SpaceWord(text_, LUA_REMOTE_FUNCS)
                    elseif source == "Logs" then
                        lyrInfo.Text     = HlLogInfo(text_)
                    end
                    UpdateLines(text_)
                end

                src:GetPropertyChangedSignal("Text"):Connect(RunHighlight)

                clearBtn.MouseButton1Click:Connect(function() src.Text = "" end)
                copyBtn.MouseButton1Click:Connect(function()
                    if setclipboard then pcall(setclipboard, src.Text) end
                    Tween(copyBtn, {TextColor3 = THEME.SUCCESS}, TWEEN.FAST)
                    task.delay(1, function() Tween(copyBtn, {TextColor3 = THEME.TEXT_MUTED}, TWEEN.MEDIUM) end)
                end)

                local console_api = {}
                function console_api:Set(code)   src.Text = tostring(code); RunHighlight() end
                function console_api:Get()        return src.Text end
                function console_api:Clear()      src.Text = "" end
                function console_api:Log(msg, tag)
                    tag = tag or "*"
                    src.Text = src.Text .. "[" .. tag .. "] " .. tostring(msg) .. "\n"
                    sf.CanvasPosition = Vector2.new(0, math.huge)
                end
                function console_api:Execute()
                    if loadstring then
                        local fn, err = loadstring(src.Text)
                        if fn then pcall(fn) else warn("[NexusUI Console] " .. tostring(err)) end
                    end
                end
                return console_api, card
            end

            -- ═══════════════════════════════════════════════════════════
            --  Folder  (collapsible section container)
            -- ═══════════════════════════════════════════════════════════
            function E:AddFolder(folder_name)
                folder_name = tostring(folder_name or "Folder")
                local folder_data = {}
                local folderOpen  = false

                local folderCard = New("Frame", {
                    BackgroundColor3 = THEME.BG_PANEL,
                    BorderSizePixel  = 0,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ClipsDescendants = true,
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                Corner(8, folderCard)
                local fStroke = Stroke(THEME.STROKE_FAINT, 1, folderCard)

                local folderBtn = New("TextButton", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 34),
                    Text   = "",
                    ZIndex = WIN_Z + 4 + zOff,
                    Parent = folderCard,
                })

                local chevron_ = New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 10, 0.5, 0),
                    Size        = UDim2.new(0, 16, 0, 16),
                    Font        = Enum.Font.GothamBold,
                    Text        = "›",
                    TextColor3  = accent(),
                    TextSize    = 16,
                    ZIndex      = WIN_Z + 5 + zOff,
                    Parent      = folderBtn,
                })

                -- Colour stripe accent
                local fStripe = New("Frame", {
                    BackgroundColor3 = accent(),
                    BorderSizePixel  = 0,
                    AnchorPoint      = Vector2.new(0, 0.5),
                    Position         = UDim2.new(0, 28, 0.5, 0),
                    Size             = UDim2.new(0, 2, 0, 18),
                    ZIndex           = WIN_Z + 5 + zOff,
                    Parent           = folderBtn,
                })
                Corner(1, fStripe)

                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position    = UDim2.new(0, 38, 0.5, 0),
                    Size        = UDim2.new(1, -50, 0, 20),
                    Font        = Enum.Font.GothamMedium,
                    Text        = folder_name,
                    TextColor3  = THEME.TEXT_PRIMARY,
                    TextSize    = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex      = WIN_Z + 5 + zOff,
                    Parent      = folderBtn,
                })

                -- Content frame (hidden when collapsed)
                local content = New("Frame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel  = 0,
                    Position         = UDim2.new(0, 10, 0, 38),
                    Size             = UDim2.new(1, -10, 0, 0),
                    AutomaticSize    = Enum.AutomaticSize.Y,
                    Visible          = false,
                    ZIndex           = WIN_Z + 3 + zOff,
                    Parent           = folderCard,
                })
                List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Left, content)

                -- Bottom padding spacer inside content
                local bottomSpacer = New("Frame", {
                    BackgroundTransparency = 1,
                    Size   = UDim2.new(1, 0, 0, 6),
                    ZIndex = WIN_Z + 3 + zOff,
                    Parent = content,
                })

                local function CalcFolderH()
                    local h = 34 + 6
                    for _, c in pairs(content:GetChildren()) do
                        if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then
                            h = h + c.AbsoluteSize.Y + 6
                        end
                    end
                    return h
                end

                folderBtn.MouseButton1Click:Connect(function()
                    folderOpen = not folderOpen
                    if folderOpen then
                        content.Visible = true
                        Tween(chevron_,  {Rotation = 90},            TWEEN.MEDIUM)
                        Tween(fStroke,   {Color = accent()},         TWEEN.FAST)
                        Tween(fStripe,   {BackgroundColor3 = accent()}, TWEEN.FAST)
                        task.spawn(function()
                            task.wait(0.02)
                            Tween(folderCard, {Size = UDim2.new(1, 0, 0, CalcFolderH())}, TWEEN.MEDIUM)
                        end)
                    else
                        Tween(chevron_,  {Rotation = 0},             TWEEN.MEDIUM)
                        Tween(fStroke,   {Color = THEME.STROKE_FAINT}, TWEEN.FAST)
                        Tween(folderCard, {Size = UDim2.new(1, 0, 0, 34)}, TWEEN.MEDIUM)
                        task.delay(0.22, function() content.Visible = false end)
                    end
                end)
                folderBtn.MouseEnter:Connect(function() Tween(folderCard, {BackgroundColor3 = THEME.BG_HOVER},   TWEEN.FAST) end)
                folderBtn.MouseLeave:Connect(function() Tween(folderCard, {BackgroundColor3 = THEME.BG_PANEL}, TWEEN.FAST) end)

                content.Visible = false

                -- Keep stripe/chevron accent in sync
                task.spawn(function()
                    while folderCard and folderCard.Parent do
                        chevron_.TextColor3     = accent()
                        fStripe.BackgroundColor3 = accent()
                        RunService.Heartbeat:Wait()
                    end
                end)

                -- Delegate all element builders into folder
                local innerE = buildElements(content, zOff + 6)
                for k, v in pairs(innerE) do
                    local captured_k = k
                    local captured_v = v
                    folder_data[captured_k] = function(self_, ...)
                        local res = {captured_v(innerE, ...)}
                        -- Refresh folder height after inserting element
                        if folderOpen then
                            task.spawn(function()
                                task.wait(0.06)
                                Tween(folderCard, {Size = UDim2.new(1, 0, 0, CalcFolderH())}, TWEEN.FAST)
                            end)
                        end
                        return table.unpack(res)
                    end
                end

                return folder_data, folderCard
            end

            -- ═══════════════════════════════════════════════════════════
            --  HorizontalAlignment  (side-by-side element row)
            -- ═══════════════════════════════════════════════════════════
            function E:AddHorizontalAlignment()
                local ha_data = {}
                local haFrame = New("Frame", {
                    BackgroundTransparency = 1,
                    Size             = UDim2.new(1, 0, 0, 34),
                    ZIndex           = WIN_Z + 2 + zOff,
                    Parent           = target,
                })
                List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, haFrame)

                local innerEl = buildElements(haFrame, zOff)

                local function wrapHoriz(fnName, ...)
                    local fn = innerEl[fnName]
                    if fn then
                        local api_, obj_ = fn(innerEl, ...)
                        if obj_ then
                            -- Remove fixed width so items auto-fit horizontally
                            obj_.Size         = UDim2.new(0, 0, 0, 34)
                            obj_.AutomaticSize = Enum.AutomaticSize.X
                        end
                        return api_, obj_
                    end
                end

                function ha_data:AddButton(...)     return wrapHoriz("AddButton", ...) end
                function ha_data:AddSwitch(...)     return wrapHoriz("AddSwitch", ...) end
                function ha_data:AddKeybind(...)    return wrapHoriz("AddKeybind", ...) end
                function ha_data:AddLabel(...)      return wrapHoriz("AddLabel",  ...) end

                return ha_data, haFrame
            end

            return E
        end  -- buildElements

        -- ── Attach all element builders directly onto tab_data ────────────
        local tabElems = buildElements(tabFrame, 0)
        for k, v in pairs(tabElems) do
            local kk = k
            local vv = v
            tab_data[kk] = function(self_, ...)
                return vv(tabElems, ...)
            end
        end

        return tab_data, tabFrame
    end  -- AddTab

    -- ══════════════════════════════════════════════════════════════════════
    --  window_data utility methods
    -- ══════════════════════════════════════════════════════════════════════

    --- Show a toast notification anchored to this window.
    -- @param title     Bold header text
    -- @param message   Body text
    -- @param duration  Seconds on screen (default 3)
    -- @param color     Accent color for stripe + border
    function window_data:Notify(title, message, duration, color)
        SpawnToast(title, message, duration, color or accent())
    end

    --- Dynamically update the window's accent colour at runtime.
    -- All elements that poll options.main_color will update on the next
    -- Heartbeat tick.
    -- @param col  New Color3 accent
    function window_data:SetAccentColor(col)
        options.main_color = col
    end

    --- Retrieve current accent colour.
    function window_data:GetAccentColor()
        return options.main_color
    end

    --- Update the window title text.
    -- @param title  New title string
    function window_data:SetTitle(title)
        options.title     = tostring(title)
        TitleLabel.Text   = options.title
        IconLetter.Text   = string.upper(string.sub(options.title, 1, 1))
    end

    --- Update the window subtitle text.
    -- @param sub  New subtitle string
    function window_data:SetSubtitle(sub)
        options.subtitle = tostring(sub)
        SubLabel.Text    = options.subtitle
    end

    --- Programmatically toggle window visibility.
    -- @param bool  true = show, false = hide
    function window_data:SetVisible(bool)
        _visible       = (bool ~= false)
        Window.Visible = _visible
    end

    --- Returns true if the window is currently visible.
    function window_data:IsVisible()
        return _visible
    end

    --- Destroy this window with a fade-out animation.
    function window_data:Destroy()
        Tween(Window, {BackgroundTransparency = 1}, TWEEN.MEDIUM)
        task.delay(0.25, function()
            if Window and Window.Parent then Window:Destroy() end
        end)
    end

    --- Bring this window to the front (raises ZIndex above other windows).
    function window_data:Focus()
        windowCount = windowCount + 1
        Window.ZIndex = windowCount * 25
    end

    return window_data, Window
end  -- CreateWindow

-- ══════════════════════════════════════════════════════════════════════════
--  NexusUI global helpers
-- ══════════════════════════════════════════════════════════════════════════

--- Spawn a standalone notification toast (no window required).
-- @param title    Bold header text
-- @param message  Body text
-- @param duration Seconds on screen (default 3)
-- @param color    Accent color (default blue)
function NexusUI:Notify(title, message, duration, color)
    SpawnToast(title, message, duration, color or THEME.ACCENT)
end

--- Destroy all NexusUI windows and the ScreenGui.
function NexusUI:DestroyAll()
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end

--- Expose the Theme table for external inspection or extension.
NexusUI.Theme   = THEME

--- Version string.
NexusUI.Version = "2.0.0"

-- ══════════════════════════════════════════════════════════════════════════
--  DEMO  (remove or comment out in production scripts)
-- ══════════════════════════════════════════════════════════════════════════
--[[
do
    -- ── Create a window ──────────────────────────────────────────────────
    local winData, win = NexusUI:CreateWindow({
        title      = "NexusUI v2",
        subtitle   = "Demo Script",
        main_color = Color3.fromRGB(100, 155, 255),
        size       = UDim2.new(0, 600, 0, 480),
        toggle_key = Enum.KeyCode.RightShift,
    })

    -- ── Tab 1 — Controls ─────────────────────────────────────────────────
    local t1 = winData:AddTab("Controls", "⚙")

    t1:AddSection("Labels & Text")
    local lbl = t1:AddLabel("This is a label with default color.")
    t1:AddRichLabel("INFO ", "RichLabel supports a bold prefix in accent color.")
    t1:AddDivider()

    t1:AddSection("Buttons")
    t1:AddButton("Primary Button", function()
        winData:Notify("Button", "Primary button was clicked!", 2.5)
    end)
    t1:AddButton("Success Action", function() print("success") end)

    local ha, _ = t1:AddHorizontalAlignment()
    ha:AddButton("Left",   function() print("left")  end)
    ha:AddButton("Right",  function() print("right") end)

    t1:AddSection("Toggle Switches")
    local sw1 = t1:AddSwitch("Enable Feature A", false, function(v)
        print("Feature A:", v)
    end)
    local sw2 = t1:AddSwitch("Enable Feature B", true, function(v)
        print("Feature B:", v)
    end)

    t1:AddSection("Text Inputs")
    t1:AddTextBox("Enter username…", function(txt)
        print("Username:", txt)
    end, {clear = true})

    t1:AddNumericBox("Walk Speed", function(v)
        print("Speed set:", v)
    end, {min = 0, max = 500, step = 1, default = 16, suffix = " stud/s"})

    -- ── Tab 2 — Sliders ──────────────────────────────────────────────────
    local t2 = winData:AddTab("Sliders", "◈")
    t2:AddSection("Slider Controls")

    local sl1 = t2:AddSlider("Walk Speed", function(v)
        print("WalkSpeed:", v)
    end, {min = 0, max = 250, default = 16, step = 1, suffix = " u/s"})

    local sl2 = t2:AddSlider("Jump Power", function(v) print("Jump:", v) end,
        {min = 0, max = 200, default = 50, step = 5, suffix = " N"})

    local sl3 = t2:AddSlider("FOV", function(v) print("FOV:", v) end,
        {min = 30, max = 120, default = 70, step = 1, suffix = "°"})

    local sl4 = t2:AddSlider("Gravity", function(v) print("Grav:", v) end,
        {min = 0, max = 196, default = 196, step = 4, suffix = " u/s²"})

    t2:AddSection("Progress Bar")
    local pb = t2:AddProgressBar("Loading…", 0, 100, true)
    t2:AddButton("Animate Progress", function()
        pb:Animate(0, 100, 2)
    end)

    -- ── Tab 3 — Dropdowns ────────────────────────────────────────────────
    local t3 = winData:AddTab("Dropdowns", "▾")
    t3:AddSection("Single Select")

    t3:AddDropdown("Team", {"Red", "Blue", "Green", "Yellow", "Spectator"}, function(v, i)
        print("Team:", v, i)
    end)

    t3:AddSection("Search Dropdown")
    t3:AddSearchDropdown("Select Weapon", {
        "Sword","Bow","Staff","Dagger","Hammer","Spear",
        "Crossbow","Wand","Axe","Shield","Scythe","Flail",
    }, function(v) print("Weapon:", v) end)

    t3:AddSection("Multi Select")
    t3:AddMultiDropdown("ESP Targets", {
        "Players","NPCs","Items","Vehicles","Bosses","Pets",
    }, function(sel)
        print("ESP:", table.concat(sel, ", "))
    end, 4)

    -- ── Tab 4 — Appearance ───────────────────────────────────────────────
    local t4 = winData:AddTab("Style", "◑")

    t4:AddSection("Color Picker")
    t4:AddColorPicker("Accent Color", Color3.fromRGB(100, 155, 255), function(col)
        winData:SetAccentColor(col)
    end)

    t4:AddSection("Keybind")
    t4:AddKeybind("Toggle UI", Enum.KeyCode.RightShift, function(k)
        print("Keybind:", k)
    end)

    t4:AddSection("Image")
    t4:AddImage("rbxassetid://7229442422", 100)

    -- ── Tab 5 — Console ──────────────────────────────────────────────────
    local t5 = winData:AddTab("Console", "»")

    t5:AddSection("Lua Editor")
    local con = t5:AddConsole(220, {source = "Lua"})
    con:Set('-- NexusUI v2 Console\nprint("Hello from NexusUI!")\n\nfor i = 1, 5 do\n\tprint("Loop:", i)\nend')

    t5:AddSection("Output Log")
    local logs = t5:AddConsole(130, {source = "Logs", read_only = true})
    logs:Log("Script loaded OK", "INFO")
    logs:Log("Player: " .. LocalPlayer.Name, "GAME")
    logs:Log("NexusUI version 2.0.0 active", "SYS")

    t5:AddButton("Run Script", function()
        con:Execute()
    end)

    -- ── Tab 6 — Folders ──────────────────────────────────────────────────
    local t6 = winData:AddTab("Folders", "▸")

    t6:AddSection("Collapsible Groups")

    local f1, _ = t6:AddFolder("Combat")
    f1:AddSwitch("Aimbot",       false, function(v) print("Aimbot:", v) end)
    f1:AddSwitch("Silent Aim",   false)
    f1:AddSwitch("Prediction",   true)
    f1:AddSlider("FOV",          function(v) end, {min=1, max=360, default=90, suffix="°"})
    f1:AddSlider("Smooth",       function(v) end, {min=1, max=20,  default=5})

    local f2, _ = t6:AddFolder("Visuals")
    f2:AddSwitch("ESP Players",  false)
    f2:AddSwitch("ESP NPCs",     false)
    f2:AddSwitch("Tracers",      false)
    f2:AddColorPicker("ESP Color", Color3.fromRGB(255, 80, 80))

    local f3, _ = t6:AddFolder("Movement")
    f3:AddSwitch("Fly",          false)
    f3:AddSwitch("NoClip",       false)
    f3:AddSlider("Fly Speed",    function(v) end, {min=0, max=300, default=50, suffix=" u/s"})
    f3:AddSlider("Jump Power",   function(v) end, {min=0, max=500, default=50})

    -- ── Greeting toast ───────────────────────────────────────────────────
    task.delay(0.6, function()
        winData:Notify(
            "NexusUI v2 Loaded",
            "Modern UI library ready. Toggle with RightShift.",
            4,
            Color3.fromRGB(72, 208, 128)
        )
    end)
end
--]]

-- ══════════════════════════════════════════════════════════════════════════
--  LOADING SCREEN  utility
--  Creates a full-screen overlay that plays a spinner animation and then
--  fades out.  Useful for showing progress while a script initialises.
--
--  Usage:
--    local ls = NexusUI:CreateLoadingScreen({
--        title    = "Loading…",
--        subtitle = "Please wait while the script sets up.",
--        color    = Color3.fromRGB(100, 155, 255),
--    })
--    -- … do your initialisation …
--    ls:SetProgress(50, "Halfway there!")
--    task.wait(1)
--    ls:SetProgress(100, "Done!")
--    task.wait(0.5)
--    ls:Dismiss()
-- ══════════════════════════════════════════════════════════════════════════
function NexusUI:CreateLoadingScreen(opts)
    opts = opts or {}
    local title    = tostring(opts.title    or "Loading…")
    local subtitle = tostring(opts.subtitle or "Please wait")
    local color    = opts.color             or THEME.ACCENT

    -- Full-screen dark overlay
    local overlay = New("Frame", {
        Name             = "LoadingOverlay",
        BackgroundColor3 = Color3.fromRGB(8, 9, 12),
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 1, 0),
        ZIndex           = 900,
        Parent           = ScreenGui,
    })

    -- Central card
    local card = New("Frame", {
        BackgroundColor3 = THEME.BG_WINDOW,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0.5, 0.5),
        Position         = UDim2.new(0.5, 0, 0.5, 0),
        Size             = UDim2.new(0, 340, 0, 200),
        ZIndex           = 901,
        Parent           = overlay,
    })
    Corner(12, card)
    Stroke(THEME.STROKE_FAINT, 1, card)
    Shadow(card, 18, 0.35)

    -- Accent top bar
    local topBar = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 3),
        ZIndex           = 902,
        Parent           = card,
    })
    Corner(3, topBar)
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(1, BrightenColor(color, 1.4)),
        }),
        Parent = topBar,
    })

    -- Spinner ring (rotates)
    local spinnerRing = New("ImageLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 0),
        Position     = UDim2.new(0.5, 0, 0, 24),
        Size         = UDim2.new(0, 48, 0, 48),
        Image        = "rbxassetid://4965945816",
        ImageColor3  = color,
        ZIndex       = 902,
        Parent       = card,
    })

    -- Spinner inner dot
    local spinnerDot = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0.5, 0.5),
        Position         = UDim2.new(0.5, 0, 0, 48),
        Size             = UDim2.new(0, 10, 0, 10),
        ZIndex           = 902,
        Parent           = card,
    })
    Corner(5, spinnerDot)
    Glow(spinnerDot, color, 10, 0.55)

    -- Title text
    local titleLbl = New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 0),
        Position     = UDim2.new(0.5, 0, 0, 88),
        Size         = UDim2.new(1, -24, 0, 22),
        Font         = Enum.Font.GothamBold,
        Text         = title,
        TextColor3   = THEME.TEXT_PRIMARY,
        TextSize     = 16,
        ZIndex       = 902,
        Parent       = card,
    })

    -- Subtitle text
    local subLbl = New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 0),
        Position     = UDim2.new(0.5, 0, 0, 114),
        Size         = UDim2.new(1, -32, 0, 16),
        Font         = Enum.Font.Gotham,
        Text         = subtitle,
        TextColor3   = THEME.TEXT_SECONDARY,
        TextSize     = 12,
        ZIndex       = 902,
        Parent       = card,
    })

    -- Progress bar (thin strip at bottom)
    local progTrack = New("Frame", {
        BackgroundColor3 = THEME.BG_ACTIVE,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0, 1),
        Position         = UDim2.new(0, 0, 1, 0),
        Size             = UDim2.new(1, 0, 0, 4),
        ZIndex           = 902,
        Parent           = card,
    })
    Corner(2, progTrack)

    local progFill = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 0, 1, 0),
        ZIndex           = 903,
        Parent           = progTrack,
    })
    Corner(2, progFill)
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(1, BrightenColor(color, 1.3)),
        }),
        Parent = progFill,
    })

    -- Progress percentage label
    local pctLbl = New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(1, 1),
        Position     = UDim2.new(1, -8, 1, -10),
        Size         = UDim2.new(0, 40, 0, 14),
        Font         = Enum.Font.GothamBold,
        Text         = "0%",
        TextColor3   = color,
        TextSize     = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex       = 902,
        Parent       = card,
    })

    -- Animate spinner rotation
    local spinnerRunning = true
    task.spawn(function()
        local angle = 0
        while spinnerRunning and spinnerRing and spinnerRing.Parent do
            angle = (angle + 3) % 360
            spinnerRing.Rotation = angle
            RunService.Heartbeat:Wait()
        end
    end)

    -- Pulse dot scale
    task.spawn(function()
        local t_ = 0
        while spinnerRunning and spinnerDot and spinnerDot.Parent do
            t_ = t_ + 0.06
            local s  = 10 + math.sin(t_) * 3
            spinnerDot.Size = UDim2.new(0, s, 0, s)
            RunService.Heartbeat:Wait()
        end
    end)

    local ls_api = {}

    --- Update the loading progress.
    -- @param percent   0–100
    -- @param msg       Optional status message
    function ls_api:SetProgress(percent, msg)
        percent = Clamp(tonumber(percent) or 0, 0, 100)
        Tween(progFill, {Size = UDim2.new(percent / 100, 0, 1, 0)}, TWEEN.MEDIUM)
        pctLbl.Text = tostring(math.floor(percent)) .. "%"
        if msg then subLbl.Text = tostring(msg) end
    end

    --- Update the main title.
    function ls_api:SetTitle(t_) titleLbl.Text = tostring(t_) end

    --- Dismiss the loading screen with a fade-out.
    -- @param delay_s  Optional extra delay before fade (default 0)
    function ls_api:Dismiss(delay_s)
        delay_s = tonumber(delay_s) or 0
        task.delay(delay_s, function()
            spinnerRunning = false
            Tween(overlay, {BackgroundTransparency = 1}, TWEEN.SLOW)
            Tween(card,    {BackgroundTransparency = 1, Size = UDim2.new(0, 320, 0, 180)}, TWEEN.SLOW)
            task.delay(0.4, function()
                if overlay and overlay.Parent then overlay:Destroy() end
            end)
        end)
    end

    return ls_api
end

-- ══════════════════════════════════════════════════════════════════════════
--  CONFIRM DIALOG  utility
--  Shows a modal dialog asking the user to confirm or cancel an action.
--  Blocks asynchronously; the callback receives true (confirm) or false
--  (cancel).
--
--  Usage:
--    NexusUI:Confirm({
--        title   = "Are you sure?",
--        message = "This will reset all your settings.",
--        color   = Color3.fromRGB(235, 75, 75),
--        confirm_text = "Yes, reset",
--        cancel_text  = "Cancel",
--    }, function(ok)
--        if ok then resetSettings() end
--    end)
-- ══════════════════════════════════════════════════════════════════════════
function NexusUI:Confirm(opts, callback)
    opts     = opts     or {}
    callback = type(callback) == "function" and callback or function() end

    local title        = tostring(opts.title        or "Confirm")
    local message      = tostring(opts.message      or "Are you sure?")
    local color        = opts.color                 or THEME.ACCENT
    local confirm_text = tostring(opts.confirm_text or "Confirm")
    local cancel_text  = tostring(opts.cancel_text  or "Cancel")

    -- Dimmed overlay
    local dimOverlay = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 1, 0),
        ZIndex           = 800,
        Parent           = ScreenGui,
    })
    Tween(dimOverlay, {BackgroundTransparency = 0.4}, TWEEN.MEDIUM)

    -- Dialog card
    local dialog = New("Frame", {
        BackgroundColor3 = THEME.BG_WINDOW,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        AnchorPoint      = Vector2.new(0.5, 0.5),
        Position         = UDim2.new(0.5, 0, 0.4, 0),
        Size             = UDim2.new(0, 320, 0, 160),
        ZIndex           = 801,
        Parent           = ScreenGui,
    })
    Corner(12, dialog)
    Stroke(color, 1.5, dialog)
    Shadow(dialog, 20, 0.4)

    -- Slide-in entrance
    dialog.Position = UDim2.new(0.5, 0, 0.35, 0)
    Tween(dialog, {Position = UDim2.new(0.5, 0, 0.4, 0)}, TWEEN.SPRING)

    -- Top accent bar
    local dBar = New("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 0, 3),
        ZIndex           = 802,
        Parent           = dialog,
    })
    Corner(2, dBar)

    New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 0),
        Position     = UDim2.new(0.5, 0, 0, 18),
        Size         = UDim2.new(1, -24, 0, 22),
        Font         = Enum.Font.GothamBold,
        Text         = title,
        TextColor3   = THEME.TEXT_PRIMARY,
        TextSize     = 15,
        ZIndex       = 802,
        Parent       = dialog,
    })

    New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 0),
        Position     = UDim2.new(0.5, 0, 0, 46),
        Size         = UDim2.new(1, -32, 0, 48),
        Font         = Enum.Font.Gotham,
        Text         = message,
        TextColor3   = THEME.TEXT_SECONDARY,
        TextSize     = 13,
        TextWrapped  = true,
        ZIndex       = 802,
        Parent       = dialog,
    })

    -- Button row
    local btnRow = New("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint  = Vector2.new(0.5, 1),
        Position     = UDim2.new(0.5, 0, 1, -14),
        Size         = UDim2.new(1, -24, 0, 32),
        ZIndex       = 802,
        Parent       = dialog,
    })
    List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, btnRow)

    -- Cancel button
    local cancelBtn = New("TextButton", {
        BackgroundColor3 = THEME.BG_ELEMENT,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 110, 0, 30),
        Font             = Enum.Font.GothamMedium,
        Text             = cancel_text,
        TextColor3       = THEME.TEXT_SECONDARY,
        TextSize         = 13,
        ZIndex           = 803,
        Parent           = btnRow,
    })
    Corner(7, cancelBtn)
    Stroke(THEME.STROKE_NORMAL, 1, cancelBtn)

    -- Confirm button
    local confirmBtn = New("TextButton", {
        BackgroundColor3 = color,
        BorderSizePixel  = 0,
        Size             = UDim2.new(0, 120, 0, 30),
        Font             = Enum.Font.GothamBold,
        Text             = confirm_text,
        TextColor3       = Color3.fromRGB(255, 255, 255),
        TextSize         = 13,
        ZIndex           = 803,
        Parent           = btnRow,
    })
    Corner(7, confirmBtn)
    Glow(confirmBtn, color, 10, 0.6)

    cancelBtn.MouseEnter:Connect(function()
        Tween(cancelBtn, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST)
    end)
    cancelBtn.MouseLeave:Connect(function()
        Tween(cancelBtn, {BackgroundColor3 = THEME.BG_ELEMENT}, TWEEN.FAST)
    end)
    confirmBtn.MouseEnter:Connect(function()
        Tween(confirmBtn, {BackgroundColor3 = BrightenColor(color, 1.2)}, TWEEN.FAST)
    end)
    confirmBtn.MouseLeave:Connect(function()
        Tween(confirmBtn, {BackgroundColor3 = color}, TWEEN.FAST)
    end)

    local function dismiss(result)
        Tween(dialog,     {BackgroundTransparency = 1, Size = UDim2.new(0, 310, 0, 145)}, TWEEN.MEDIUM)
        Tween(dimOverlay, {BackgroundTransparency = 1}, TWEEN.MEDIUM)
        task.delay(0.25, function()
            if dialog    and dialog.Parent    then dialog:Destroy()     end
            if dimOverlay and dimOverlay.Parent then dimOverlay:Destroy() end
        end)
        pcall(callback, result)
    end

    cancelBtn.MouseButton1Click:Connect(function()  dismiss(false) end)
    confirmBtn.MouseButton1Click:Connect(function() dismiss(true)  end)
end

-- ══════════════════════════════════════════════════════════════════════════
--  CONTEXT MENU  utility
--  Right-click (or programmatic) context menu.
--
--  Usage:
--    NexusUI:ContextMenu(Mouse.X, Mouse.Y, {
--        {label = "Copy",   icon = "📋", callback = function() end},
--        {label = "Paste",  icon = "📄", callback = function() end},
--        {separator = true},
--        {label = "Delete", icon = "🗑", color = THEME.ERROR_C, callback = function() end},
--    })
-- ══════════════════════════════════════════════════════════════════════════
function NexusUI:ContextMenu(x, y, items)
    x     = tonumber(x) or 0
    y     = tonumber(y) or 0
    items = type(items) == "table" and items or {}

    -- Destroy any existing context menu
    local prev = ScreenGui:FindFirstChild("_ContextMenu")
    if prev then prev:Destroy() end

    local ITEM_H = 30
    local SEP_H  = 8
    local MENU_W = 180

    -- Calculate total height
    local totalH = 8
    for _, item in ipairs(items) do
        totalH = totalH + (item.separator and SEP_H or ITEM_H) + 3
    end

    local menu = New("Frame", {
        Name             = "_ContextMenu",
        BackgroundColor3 = THEME.BG_PANEL,
        BorderSizePixel  = 0,
        Position         = UDim2.new(0, math.min(x, 1200 - MENU_W), 0, y),
        Size             = UDim2.new(0, MENU_W, 0, totalH),
        ZIndex           = 600,
        ClipsDescendants = true,
        Parent           = ScreenGui,
    })
    Corner(8, menu)
    Stroke(THEME.STROKE_NORMAL, 1, menu)
    Shadow(menu, 10, 0.38)
    Padding(4, 4, 4, 4, menu)
    List(Enum.FillDirection.Vertical, 3, Enum.HorizontalAlignment.Left, menu)

    -- Slide in from tiny
    menu.Size = UDim2.new(0, MENU_W, 0, 0)
    Tween(menu, {Size = UDim2.new(0, MENU_W, 0, totalH)}, TWEEN.SPRING)

    for _, item in ipairs(items) do
        if item.separator then
            New("Frame", {
                BackgroundColor3 = THEME.STROKE_FAINT,
                BorderSizePixel  = 0,
                Size             = UDim2.new(1, 0, 0, 1),
                ZIndex           = 601,
                Parent           = menu,
            })
        else
            local label   = tostring(item.label    or "")
            local icon    = tostring(item.icon     or "")
            local cb      = type(item.callback) == "function" and item.callback or function() end
            local itemClr = item.color or THEME.TEXT_PRIMARY

            local itemBtn = New("TextButton", {
                BackgroundColor3 = THEME.BG_PANEL,
                BorderSizePixel  = 0,
                Size             = UDim2.new(1, 0, 0, ITEM_H),
                Text             = "",
                ZIndex           = 602,
                Parent           = menu,
            })
            Corner(5, itemBtn)

            if #icon > 0 then
                New("TextLabel", {
                    BackgroundTransparency = 1,
                    AnchorPoint  = Vector2.new(0, 0.5),
                    Position     = UDim2.new(0, 8, 0.5, 0),
                    Size         = UDim2.new(0, 18, 0, 18),
                    Font         = Enum.Font.Gotham,
                    Text         = icon,
                    TextColor3   = itemClr,
                    TextSize     = 13,
                    ZIndex       = 603,
                    Parent       = itemBtn,
                })
            end

            New("TextLabel", {
                BackgroundTransparency = 1,
                AnchorPoint  = Vector2.new(0, 0.5),
                Position     = UDim2.new(0, #icon > 0 and 30 or 10, 0.5, 0),
                Size         = UDim2.new(1, -40, 0, 20),
                Font         = Enum.Font.GothamMedium,
                Text         = label,
                TextColor3   = itemClr,
                TextSize     = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex       = 603,
                Parent       = itemBtn,
            })

            itemBtn.MouseEnter:Connect(function()
                Tween(itemBtn, {BackgroundColor3 = THEME.BG_HOVER}, TWEEN.FAST)
            end)
            itemBtn.MouseLeave:Connect(function()
                Tween(itemBtn, {BackgroundColor3 = THEME.BG_PANEL}, TWEEN.FAST)
            end)
            itemBtn.MouseButton1Click:Connect(function()
                Tween(menu, {Size = UDim2.new(0, MENU_W, 0, 0), BackgroundTransparency = 1}, TWEEN.FAST)
                task.delay(0.15, function() if menu and menu.Parent then menu:Destroy() end end)
                pcall(cb)
            end)
        end
    end

    -- Close on click-away
    local closeConn
    closeConn = UserInputService.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx, my = inp.Position.X, inp.Position.Y
            local ax, ay = menu.AbsolutePosition.X, menu.AbsolutePosition.Y
            local aw, ah = menu.AbsoluteSize.X,     menu.AbsoluteSize.Y
            if mx < ax or mx > ax + aw or my < ay or my > ay + ah then
                closeConn:Disconnect()
                Tween(menu, {Size = UDim2.new(0, MENU_W, 0, 0)}, TWEEN.FAST)
                task.delay(0.15, function() if menu and menu.Parent then menu:Destroy() end end)
            end
        end
    end)
end

-- ══════════════════════════════════════════════════════════════════════════
--  THEME PRESETS
--  Ready-to-use colour schemes.  Pass the result as main_color.
-- ══════════════════════════════════════════════════════════════════════════
NexusUI.Presets = {
    Blue      = Color3.fromRGB(100, 155, 255),
    Cyan      = Color3.fromRGB(60,  200, 220),
    Green     = Color3.fromRGB(72,  210, 128),
    Emerald   = Color3.fromRGB(50,  185, 100),
    Purple    = Color3.fromRGB(155, 100, 255),
    Pink      = Color3.fromRGB(235,  90, 170),
    Red       = Color3.fromRGB(235,  75,  75),
    Orange    = Color3.fromRGB(245, 140,  50),
    Yellow    = Color3.fromRGB(238, 182,  52),
    White     = Color3.fromRGB(220, 220, 230),
    Steel     = Color3.fromRGB(130, 145, 175),
    Gold      = Color3.fromRGB(215, 175,  55),
}

-- ══════════════════════════════════════════════════════════════════════════
--  CHANGELOG / RELEASE NOTES
-- ══════════════════════════════════════════════════════════════════════════
--[[
  NexusUI  —  Changelog
  ─────────────────────────────────────────────────────────────────────────

  v2.0.0  (2025)
  ──────────────────────────────────────────────────────────────────────────
  BREAKING CHANGES
  • Complete rewrite from scratch.  No API compatibility with v1.
  • All elements now return (api_table, frame) instead of just frame.
  • Options table replaces individual function arguments for all elements.

  NEW ELEMENTS
  • RichLabel        — multi-line label with bold prefix + body.
  • NumericBox       — text box with − / + stepper buttons.
  • SearchDropdown   — dropdown with built-in live search filter.
  • ProgressBar      — animated progress bar with percentage badge.
  • ImageLabel       — display any Roblox asset image with rounded corners.
  • Divider          — thin horizontal rule.
  • Spacer           — explicit vertical gap.

  NEW UTILITIES
  • NexusUI:CreateLoadingScreen()  — full-screen animated loading overlay.
  • NexusUI:Confirm()              — modal confirmation dialog.
  • NexusUI:ContextMenu()          — right-click context menu.
  • NexusUI:Notify()               — standalone toast, no window required.
  • NexusUI.Presets                — colour preset table for main_color.

  VISUAL IMPROVEMENTS
  • Glass-morphism dark theme (BG_WINDOW = RGB 15,16,21).
  • UIGradient accent lines on title bars.
  • Gradient fill on Slider track.
  • Glow effect on Switch thumb and Slider handle.
  • Drop-shadow (9-slice ImageLabel) on windows, dialogs, and toasts.
  • Toast notification queue — multiple toasts stack vertically.
  • Ripple click-feedback on all buttons and switch rows.
  • UICorner (radius 8px) on every element card.
  • UIStroke (1px, #263748) on all cards; brightens to accent on focus.
  • Spring tween on minimise, confirm dialog entrance, and context menu.

  INTERACTIONS
  • Window drag (title bar), resize (bottom-right grip), minimise, close.
  • Global toggle key (default RightShift) hides/shows window.
  • Tab bar auto-scrolls horizontally when many tabs are added.
  • ColorPicker supports SV square drag, hue bar drag, and hex input.
  • Slider thumb grows on hover and supports mobile touch input.
  • SearchDropdown live-filters items as you type.
  • MultiDropdown shows item count badge and supports max_sel cap.
  • Keybind badge shows "…press key…" and captures the next keypress.

  DEVELOPER EXPERIENCE
  • All element builders share the same buildElements() factory so Folder
    and HorizontalAlignment automatically get every element type.
  • window_data:SetAccentColor(col) updates all live accent references
    on the next Heartbeat tick.
  • console_api:Execute() calls loadstring() on the console content.
  • tab_data:Show() programmatically switches to that tab.
  • folder_data:AddXxx()  delegates to the same element factory as tabs.

  PERFORMANCE
  • Accent-colour sync uses RunService.Heartbeat (not task.wait(0)).
  • Ripple frames are cleaned up by Debris:AddItem after 0.65s.
  • TweenService instances are created per-call and not stored.
  • Loading screen spinner uses a single Heartbeat loop per overlay.

  ─────────────────────────────────────────────────────────────────────────
  v1.x  (original, 2262 lines)
  ──────────────────────────────────────────────────────────────────────────
  • ImageLabel-based window with rbxassetid:// 9-slice backgrounds.
  • UIListLayout-based tab system.
  • Elements: Label, Button, Switch, TextBox, Slider, Dropdown,
    MultiDropdown, Keybind, ColorPicker, Console, Folder,
    HorizontalAlignment.
  • Resize via corner drag.
  • Toggle via Bar > Toggle ImageButton.
  • Syntax highlighting via SpaceOut pattern-match overlay layers.
--]]

-- ══════════════════════════════════════════════════════════════════════════
--  INTERNAL HELPERS  (advanced / expert usage)
-- ══════════════════════════════════════════════════════════════════════════

--- Returns the ScreenGui that hosts all NexusUI elements.
-- Useful if you need to parent custom elements alongside NexusUI.
-- @return ScreenGui
function NexusUI:GetScreenGui()
    return ScreenGui
end

--- Returns the WindowContainer frame.
-- @return Frame
function NexusUI:GetWindowContainer()
    return WindowContainer
end

--- Destroy all active toast notifications.
function NexusUI:ClearToasts()
    for _, toast in ipairs(activeToasts) do
        if toast and toast.Parent then toast:Destroy() end
    end
    activeToasts = {}
end

--- Force all windows to a specific position (useful for centering on resize).
-- @param pos  UDim2 position applied to every window
function NexusUI:SetAllWindowPositions(pos)
    for _, child in pairs(WindowContainer:GetChildren()) do
        if child:IsA("Frame") then
            Tween(child, {Position = pos}, TWEEN.MEDIUM)
        end
    end
end

--- Count how many windows are currently active.
-- @return integer
function NexusUI:GetWindowCount()
    local n = 0
    for _, c in pairs(WindowContainer:GetChildren()) do
        if c:IsA("Frame") then n = n + 1 end
    end
    return n
end

--- Apply a tint to the entire ScreenGui overlay (e.g. for accessibility).
-- @param color  Tint Color3
-- @param alpha  Transparency 0–1 (0 = fully visible tint, 1 = invisible)
function NexusUI:SetGlobalTint(color, alpha)
    local existing = ScreenGui:FindFirstChild("_GlobalTint")
    if existing then existing:Destroy() end
    if alpha and alpha >= 1 then return end
    New("Frame", {
        Name             = "_GlobalTint",
        BackgroundColor3 = color or Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = alpha or 0.85,
        BorderSizePixel  = 0,
        Size             = UDim2.new(1, 0, 1, 0),
        ZIndex           = 1,
        Parent           = ScreenGui,
    })
end

--- Remove any global tint overlay.
function NexusUI:ClearGlobalTint()
    local t = ScreenGui:FindFirstChild("_GlobalTint")
    if t then t:Destroy() end
end

-- ══════════════════════════════════════════════════════════════════════════
--  EXTENDED ELEMENT REFERENCE
--  This section documents every public method returned by each element's
--  api table.  It is purely documentary — no executable code.
-- ══════════════════════════════════════════════════════════════════════════
--[[

  ELEMENT API REFERENCE
  ─────────────────────────────────────────────────────────────────────────

  AddSection(title_text)
  ─────────────────────
  Returns:  (Frame)
  No api table; returns the separator frame directly.

  AddSpacer(pixels)
  ─────────────────────────────────────────────
  Returns:  (Frame)
  pixels:  Height in pixels (default 8).

  AddDivider()
  ─────────────────────────────────────────────
  Returns:  (Frame)
  1px horizontal rule.

  AddLabel(label_text, color?)
  ─────────────────────────────────────────────
  Returns:  (label_api, TextLabel)
  label_api methods:
    :Set(text)      — update the label text
    :SetColor(col)  — update the text colour
    :SetSize(px)    — update the font size in pixels

  AddRichLabel(prefix_text, body_text, prefix_color?)
  ─────────────────────────────────────────────
  Returns:  (api, Frame)
  api methods:
    :SetPrefix(text, color?) — update the bold prefix
    :SetBody(text)           — update the body text

  AddImage(asset_id, height?, aspect_ratio?)
  ─────────────────────────────────────────────
  Returns:  (api, Frame)
  api methods:
    :SetImage(asset_id) — change the displayed image asset
    :SetHeight(px)      — resize the card height

  AddProgressBar(label_text, initial, max, show_percent?)
  ─────────────────────────────────────────────────────────
  Returns:  (pb_api, Frame)
  pb_api methods:
    :Set(value)                    — jump to a value (fires no callback)
    :Get()                         — returns current value
    :Animate(from, to, duration)   — smoothly animate from→to over duration

  AddButton(btn_text, callback)
  ─────────────────────────────────────────────
  Returns:  (api, TextButton)
  api methods:
    :SetText(text)      — update button label
    :SetEnabled(bool)   — grey out if false
    :SetColor(col)      — change the left accent stripe colour

  AddSwitch(sw_text, default_val, callback)
  ─────────────────────────────────────────────
  Returns:  (sw_api, Frame)
  callback  (bool) — called on every toggle
  sw_api methods:
    :Set(bool)      — set toggle state, fires callback
    :Get()          — returns current toggled bool
    :SetText(text)  — update the switch label

  AddTextBox(placeholder, callback, opts?)
  ─────────────────────────────────────────────
  Returns:  (tb_api, Frame)
  opts fields:
    clear      (bool)  — clear on submit, default true
    numeric    (bool)  — reject non-numeric input
    max_chars  (int)   — character limit (0 = unlimited)
  callback  (string) — called with typed text on Enter
  tb_api methods:
    :Set(val)              — set current text
    :Get()                 — returns current text
    :Clear()               — clear current text
    :SetPlaceholder(text)  — update placeholder
    :Focus()               — programmatically focus the box

  AddNumericBox(label_text, callback, opts?)
  ─────────────────────────────────────────────
  Returns:  (api, Frame)
  opts fields:
    min, max, step, default, suffix
  api methods:
    :Set(val)  — set value, fires callback
    :Get()     — returns current value

  AddSlider(sl_text, callback, opts?)
  ─────────────────────────────────────────────
  Returns:  (sl_api, Frame)
  opts fields:
    min, max, default, step, suffix, readonly
  callback  (number) — called on drag
  sl_api methods:
    :Set(val)          — set value, fires callback
    :Get()             — returns current value
    :SetText(text)     — update label
    :SetMin(n)         — update minimum bound
    :SetMax(n)         — update maximum bound

  AddDropdown(dd_text, items, callback, opts?)
  ─────────────────────────────────────────────
  Returns:  (dd_api, Frame)
  opts fields:
    default (integer)  — index of initially selected item
  callback  (string, integer) — called with (selected_text, index)
  dd_api methods:
    :Set(val)           — update displayed selection
    :Get()              — returns current selection string
    :Refresh(new_items) — replace item list

  AddSearchDropdown(dd_text, items, callback)
  ─────────────────────────────────────────────
  Returns:  (api, Frame)
  Same callback and api as AddDropdown but with live search filtering.
  api methods:
    :Get()              — returns current selection
    :Set(val)           — update displayed selection
    :Refresh(new_items) — replace item list and rebuild

  AddMultiDropdown(dd_text, items, callback, max_sel?)
  ─────────────────────────────────────────────────────
  Returns:  (mdd_api, Frame)
  callback  (table) — called with array of selected strings
  mdd_api methods:
    :GetSelected()  — returns table of selected strings
    :Clear()        — deselect all items

  AddKeybind(kb_text, default_key, callback)
  ─────────────────────────────────────────────
  Returns:  (kb_api, Frame)
  callback  (KeyCode) — called both when key is bound AND when key is pressed
  kb_api methods:
    :GetKey()    — returns current KeyCode
    :Set(key)    — programmatically bind a KeyCode

  AddColorPicker(cp_text, default_color, callback)
  ─────────────────────────────────────────────────
  Returns:  (cp_api, Frame)
  callback  (Color3) — called on every colour change
  cp_api methods:
    :Get()       — returns current Color3
    :Set(col)    — programmatically set colour

  AddConsole(height, opts?)
  ─────────────────────────────────────────────
  Returns:  (console_api, Frame)
  opts fields:
    source     ("Lua" | "Logs")  — syntax mode
    read_only  (bool)            — disable editing
    font_size  (integer)         — default 14
  console_api methods:
    :Set(code)       — replace entire content
    :Get()           — return current text
    :Clear()         — wipe content
    :Log(msg, tag)   — append "[tag] msg\n", auto-scrolls
    :Execute()       — run content through loadstring()

  AddFolder(folder_name)
  ─────────────────────────────────────────────
  Returns:  (folder_data, Frame)
  folder_data has the same methods as tab_data (all element builders).
  Elements added to folder_data appear inside the collapsible section.
  The folder auto-resizes when elements are added while open.

  AddHorizontalAlignment()
  ─────────────────────────────────────────────
  Returns:  (ha_data, Frame)
  ha_data methods:
    :AddButton(...)   — add a button to the row
    :AddSwitch(...)   — add a switch to the row
    :AddKeybind(...)  — add a keybind to the row
    :AddLabel(...)    — add a label to the row

  ─────────────────────────────────────────────────────────────────────────
  WINDOW API REFERENCE
  ─────────────────────────────────────────────────────────────────────────

  winData:AddTab(tab_name, icon_char?)
    Returns tab_data table.  icon_char is an optional emoji/symbol prefix.

  winData:Notify(title, message, duration?, color?)
    Shows a toast notification in the bottom-right corner.

  winData:SetAccentColor(col)
    Immediately updates the accent colour variable.  All elements that
    poll options.main_color will reflect the change within one Heartbeat.

  winData:GetAccentColor()
    Returns the current accent Color3.

  winData:SetTitle(title)
    Updates the window title text and icon letter.

  winData:SetSubtitle(sub)
    Updates the subtitle text beneath the title.

  winData:SetVisible(bool)
    Show (true) or hide (false) the window programmatically.

  winData:IsVisible()
    Returns true if the window is currently visible.

  winData:Destroy()
    Animate-out and destroy the window.

  winData:Focus()
    Raise this window above all others.

  ─────────────────────────────────────────────────────────────────────────
  GLOBAL API REFERENCE
  ─────────────────────────────────────────────────────────────────────────

  NexusUI:CreateWindow(opts)            → (winData, Window)
  NexusUI:CreateLoadingScreen(opts)     → ls_api
  NexusUI:Confirm(opts, callback)       → void
  NexusUI:ContextMenu(x, y, items)      → void
  NexusUI:Notify(title, msg, dur?, col?) → void
  NexusUI:DestroyAll()                  → void
  NexusUI:GetScreenGui()                → ScreenGui
  NexusUI:GetWindowContainer()          → Frame
  NexusUI:ClearToasts()                 → void
  NexusUI:SetAllWindowPositions(pos)    → void
  NexusUI:GetWindowCount()              → integer
  NexusUI:SetGlobalTint(color, alpha)   → void
  NexusUI:ClearGlobalTint()             → void
  NexusUI.Version                       → "2.0.0"
  NexusUI.Theme                         → THEME table
  NexusUI.Presets                       → colour preset table

--]]

-- ══════════════════════════════════════════════════════════════════════════
--  QUICK-START TEMPLATES
--  Copy-paste-friendly boilerplate for the most common use-cases.
-- ══════════════════════════════════════════════════════════════════════════
--[[

  ─── TEMPLATE 1 : Basic combat script UI ────────────────────────────────

  local NexusUI = loadstring(game:HttpGet("..."))()
  local W, _ = NexusUI:CreateWindow({
      title      = "Combat Script",
      subtitle   = "v1.0",
      main_color = NexusUI.Presets.Red,
  })
  local tab = W:AddTab("Main")

  tab:AddSection("Aimbot")
  local aimEnabled = tab:AddSwitch("Enable Aimbot", false, function(v)
      -- toggle aimbot
  end)
  tab:AddSlider("FOV", function(v)
      -- update aimbot FOV
  end, {min=1, max=360, default=90, suffix="°"})
  tab:AddSlider("Smooth", function(v)
      -- update smoothing
  end, {min=1, max=50, default=10})

  tab:AddSection("Aim Key")
  tab:AddKeybind("Hold Key", Enum.KeyCode.E, function(k)
      print("Aim key:", k)
  end)

  ─── TEMPLATE 2 : Visual / ESP script ───────────────────────────────────

  local W2, _ = NexusUI:CreateWindow({
      title      = "Visual Script",
      main_color = NexusUI.Presets.Cyan,
  })
  local vTab = W2:AddTab("ESP")

  vTab:AddSection("Players")
  vTab:AddSwitch("Box ESP",     false, function(v) end)
  vTab:AddSwitch("Name ESP",    false, function(v) end)
  vTab:AddSwitch("Tracers",     false, function(v) end)
  vTab:AddSwitch("Skeleton",    false, function(v) end)
  vTab:AddColorPicker("ESP Color", Color3.fromRGB(255, 80, 80), function(col) end)

  local sTab = W2:AddTab("Settings")
  sTab:AddSlider("Max Distance", function(v) end, {min=0, max=2000, default=500, suffix=" studs"})

  ─── TEMPLATE 3 : Loading screen then UI ────────────────────────────────

  local ls = NexusUI:CreateLoadingScreen({
      title    = "My Script",
      subtitle = "Loading modules…",
      color    = NexusUI.Presets.Green,
  })

  ls:SetProgress(25, "Loading player data…")
  task.wait(0.8)
  ls:SetProgress(60, "Patching functions…")
  task.wait(0.6)
  ls:SetProgress(100, "Done!")
  task.wait(0.4)
  ls:Dismiss()

  -- Window appears after loading screen fades
  task.wait(0.5)
  local W3, _ = NexusUI:CreateWindow({title = "My Script"})
  W3:Notify("Ready", "Script loaded successfully.", 3, NexusUI.Presets.Green)

  ─── TEMPLATE 4 : Confirm before destructive action ─────────────────────

  tab:AddButton("Reset Data", function()
      NexusUI:Confirm({
          title        = "Reset Data",
          message      = "All saved settings will be lost. Continue?",
          color        = NexusUI.Presets.Red,
          confirm_text = "Yes, reset",
          cancel_text  = "Cancel",
      }, function(ok)
          if ok then
              -- perform reset
              W:Notify("Reset", "Data has been reset.", 2)
          end
      end)
  end)

--]]

-- ══════════════════════════════════════════════════════════════════════════
--  DEPENDENCY / ENVIRONMENT NOTES
-- ══════════════════════════════════════════════════════════════════════════
--[[

  NexusUI requires the following Roblox services to be accessible:
    game:GetService("Players")            ✓ always available
    game:GetService("RunService")         ✓ always available
    game:GetService("TweenService")       ✓ always available
    game:GetService("UserInputService")   ✓ always available
    game:GetService("CoreGui")            ⚠ may be filtered in some executors
    game:GetService("TextService")        ✓ always available

  If CoreGui is inaccessible (filtered executor), NexusUI automatically falls
  back to PlayerGui, which works in all environments but means the GUI is
  visible in StarterGui replication.

  Optional executor globals used (will silently no-op if unavailable):
    setclipboard(text)   — used by Console "Copy" button
    loadstring(code)     — used by console_api:Execute()
    gethui()             — not used directly; CoreGui fallback handles this

  Image assets used:
    rbxassetid://6014261993   — 9-slice shadow (window, dialog, toast)
    rbxassetid://5028857084   — radial glow  (thumb, slider handle)
    rbxassetid://698052951    — SV gradient  (color picker saturation square)
    rbxassetid://698053212    — hue rainbow  (color picker hue bar)
    rbxassetid://4965945816   — spinner ring (loading screen)

  All images are publicly accessible Roblox assets and do not require
  any additional permissions or mesh/texture uploads.

  Minimum tested Roblox version: January 2023 client
  Minimum Lua version:           Luau (Roblox)
  Minimum executor compatibility: any executor with CoreGui or PlayerGui access

--]]

-- ══════════════════════════════════════════════════════════════════════════
--  END OF FILE
-- ══════════════════════════════════════════════════════════════════════════
return NexusUI
