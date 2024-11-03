local Library = {
    Themes = {
        Default = {
            MainColor = Color3.fromRGB(25, 25, 35),
            SecondaryColor = Color3.fromRGB(35, 35, 45),
            AccentColor = Color3.fromRGB(65, 105, 225),
            TextColor = Color3.fromRGB(255, 255, 255),
            BorderColor = Color3.fromRGB(50, 50, 60)
        },
        Dark = {
            MainColor = Color3.fromRGB(15, 15, 20),
            SecondaryColor = Color3.fromRGB(20, 20, 25),
            AccentColor = Color3.fromRGB(120, 0, 255),
            TextColor = Color3.fromRGB(240, 240, 240),
            BorderColor = Color3.fromRGB(30, 30, 35)
        },
        Light = {
            MainColor = Color3.fromRGB(240, 240, 245),
            SecondaryColor = Color3.fromRGB(230, 230, 235),
            AccentColor = Color3.fromRGB(0, 120, 255),
            TextColor = Color3.fromRGB(40, 40, 40),
            BorderColor = Color3.fromRGB(200, 200, 200)
        },
        Purple = {
            MainColor = Color3.fromRGB(30, 25, 40),
            SecondaryColor = Color3.fromRGB(40, 35, 50),
            AccentColor = Color3.fromRGB(150, 50, 255),
            TextColor = Color3.fromRGB(255, 255, 255),
            BorderColor = Color3.fromRGB(60, 50, 70)
        }
    },
    Settings = {
        Sounds = true,
        Watermark = true,
        CustomCursor = true
    },
    Sounds = {
        OpenSound = "rbxassetid://6895079853",
        ClickSound = "rbxassetid://6895079733",
        SliderSound = "rbxassetid://6895079999",
        ToggleSound = "rbxassetid://6895079832"
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Utility Functions
local function CreateTween(instance, properties, duration, style, direction)
    return TweenService:Create(
        instance,
        TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
        properties
    )
end

local function PlaySound(soundId)
    if Library.Settings.Sounds then
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        game.Debris:AddItem(sound, sound.TimeLength)
    end
end

local function CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.6
    ripple.BorderSizePixel = 0
    ripple.Position = UDim2.new(0, position.X - parent.AbsolutePosition.X, 0, position.Y - parent.AbsolutePosition.Y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    ripple.Parent = parent
    
    local size = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2
    CreateTween(ripple, {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1
    }, 0.5):Play()
    
    game.Debris:AddItem(ripple, 0.5)
end

-- Watermark
function Library:CreateWatermark()
    if not Library.Settings.Watermark then return end
    
    local Watermark = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Text = Instance.new("TextLabel")
    local FPS = Instance.new("TextLabel")
    local PlayerName = Instance.new("TextLabel")
    
    Watermark.Name = "Watermark"
    Watermark.Parent = CoreGui:WaitForChild("ModernUI")
    Watermark.BackgroundColor3 = Library.CurrentTheme.MainColor
    Watermark.Position = UDim2.new(0, 10, 0, 10)
    Watermark.Size = UDim2.new(0, 200, 0, 30)
    Watermark.Active = true
    
    -- Make watermark draggable
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    Watermark.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Watermark.Position
        end
    end)
    
    Watermark.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Watermark.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Watermark
    
    Text.Name = "Text"
    Text.Parent = Watermark
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0, 10, 0, 0)
    Text.Size = UDim2.new(0, 100, 1, 0)
    Text.Font = Enum.Font.GothamSemibold
    Text.TextColor3 = Library.CurrentTheme.TextColor
    Text.TextSize = 14
    Text.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Animated text
    local function AnimateText()
        local text = "lucille.cc"
        local displayText = ""
        local i = 1
        
        spawn(function()
            while i <= #text do
                displayText = displayText .. text:sub(i,i)
                Text.Text = displayText .. "_"
                i = i + 1
                wait(0.1)
            end
            Text.Text = displayText
        end)
    end
    
    FPS.Name = "FPS"
    FPS.Parent = Watermark
    FPS.BackgroundTransparency = 1
    FPS.Position = UDim2.new(1, -100, 0, 0)
    FPS.Size = UDim2.new(0, 50, 1, 0)
    FPS.Font = Enum.Font.GothamSemibold
    FPS.TextColor3 = Library.CurrentTheme.TextColor
    FPS.TextSize = 14
    
    PlayerName.Name = "PlayerName"
    PlayerName.Parent = Watermark
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(1, -50, 0, 0)
    PlayerName.Size = UDim2.new(0, 40, 1, 0)
    PlayerName.Font = Enum.Font.GothamSemibold
    PlayerName.Text = LocalPlayer.Name
    PlayerName.TextColor3 = Library.CurrentTheme.TextColor
    PlayerName.TextSize = 14
    
    -- FPS Counter
    local fps = 0
    local frames = 0
    local lastTime = tick()
    
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastTime >= 1 then
            fps = frames
            frames = 0
            lastTime = tick()
            FPS.Text = fps.." FPS"
        end
    end)
    
    AnimateText()
    return Watermark
end
function Library:CreateWindow(title, theme)
    Library.CurrentTheme = Library.Themes[theme] or Library.Themes.Default
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    
    -- Play opening sound
    PlaySound(Library.Sounds.OpenSound)
    
    -- Main Frame
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabContainer = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("Frame")
    
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Library.CurrentTheme.MainColor
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true
    
    -- Opening Animation
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.BackgroundTransparency = 1
    
    CreateTween(Main, {
        Size = UDim2.new(0, 500, 0, 350),
        BackgroundTransparency = 0
    }, 0.5, Enum.EasingStyle.Back):Play()
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 6)
    TopBarCorner.Parent = TopBar
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Library.CurrentTheme.TextColor
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
    TabHolder.Position = UDim2.new(0, 5, 0, 35)
    TabHolder.Size = UDim2.new(0, 140, 1, -40)
    
    local TabHolderCorner = Instance.new("UICorner")
    TabHolderCorner.CornerRadius = UDim.new(0, 6)
    TabHolderCorner.Parent = TabHolder
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TabHolder
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
    TabContainer.ScrollBarThickness = 2
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 150, 0, 35)
    ContentContainer.Size = UDim2.new(1, -155, 1, -40)
    
    local Window = {}
    
    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        local ModuleList = Instance.new("UIListLayout")
        
        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
        Tab.Size = UDim2.new(1, -10, 0, 35)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = Library.CurrentTheme.TextColor
        Tab.TextSize = 12
        Tab.AutoButtonColor = false
        
        -- Tab Hover Effect
        Tab.MouseEnter:Connect(function()
            CreateTween(Tab, {
                BackgroundColor3 = Library.CurrentTheme.AccentColor
            }, 0.3):Play()
        end)
        
        Tab.MouseLeave:Connect(function()
            CreateTween(Tab, {
                BackgroundColor3 = Library.CurrentTheme.SecondaryColor
            }, 0.3):Play()
        end)
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = Tab
        
        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        ModuleList.Parent = TabContent
        ModuleList.SortOrder = Enum.SortOrder.LayoutOrder
        ModuleList.Padding = UDim.new(0, 5)
        
        Tab.MouseButton1Click:Connect(function()
            PlaySound(Library.Sounds.ClickSound)
            CreateRipple(Tab, Mouse.X, Mouse.Y)
            
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            TabContent.Visible = true
        end)
        
        local TabFunctions = {}
        
        function TabFunctions:CreateModule(moduleName, options)
            options = options or {}
            local Module = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            
            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
            Module.Size = UDim2.new(1, -10, 0, options.type == "slider" and 70 or 40)
            
            local ModuleCorner = Instance.new("UICorner")
            ModuleCorner.CornerRadius = UDim.new(0, 4)
            ModuleCorner.Parent = Module
            
            Title.Name = "Title"
            Title.Parent = Module
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(1, -20, 0, 30)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = moduleName
            Title.TextColor3 = Library.CurrentTheme.TextColor
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            if options.type == "slider" then
                local Slider = Instance.new("Frame")
                local SliderBar = Instance.new("Frame")
                local SliderButton = Instance.new("TextButton")
                local ValueLabel = Instance.new("TextLabel")
                
                Slider.Name = "Slider"
                Slider.Parent = Module
                Slider.BackgroundColor3 = Library.CurrentTheme.MainColor
                Slider.Position = UDim2.new(0, 10, 0, 35)
                Slider.Size = UDim2.new(1, -20, 0, 25)
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Parent = Slider
                
                SliderBar.Name = "Bar"
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = Library.CurrentTheme.AccentColor
                SliderBar.Size = UDim2.new((options.default or options.min or 0) / (options.max or 100), 0, 1, 0)
                
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 4)
                BarCorner.Parent = SliderBar
                
                SliderButton.Name = "Button"
                SliderButton.Parent = SliderBar
                SliderButton.AnchorPoint = Vector2.new(1, 0.5)
                SliderButton.Position = UDim2.new(1, 0, 0.5, 0)
                SliderButton.Size = UDim2.new(0, 20, 0, 20)
                SliderButton.BackgroundColor3 = Library.CurrentTheme.TextColor
                SliderButton.Text = ""
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(1, 0)
                ButtonCorner.Parent = SliderButton
                
                ValueLabel.Name = "Value"
                ValueLabel.Parent = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Size = UDim2.new(1, 0, 1, 0)
                ValueLabel.Font = Enum.Font.GothamSemibold
                ValueLabel.Text = tostring(options.default or options.min or 0)
                ValueLabel.TextColor3 = Library.CurrentTheme.TextColor
                ValueLabel.TextSize = 14
                
                -- Slider Functionality
                local dragging = false
                
                SliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                    PlaySound(Library.Sounds.SliderSound)
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local pos = math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
                        local value = math.floor(pos * (options.max or 100))
                        
                        CreateTween(SliderBar, {
                            Size = UDim2.new(pos, 0, 1, 0)
                        }, 0.1):Play()
                        
                        ValueLabel.Text = tostring(value)
                        
                        if options.callback then
                            options.callback(value)
                        end
                    end
                end)
            end
            
            return Module
        end
        
        return TabFunctions
    end
    
    -- Create watermark
    Library:CreateWatermark()
    
    return Window
end

return Library
