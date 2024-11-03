-- Premium Modern UI Library
local Library = {
    Themes = {
        Default = {
            MainColor = Color3.fromRGB(25, 25, 35),
            SecondaryColor = Color3.fromRGB(35, 35, 45),
            AccentColor = Color3.fromRGB(65, 105, 225),
            TextColor = Color3.fromRGB(255, 255, 255)
        },
        Dark = {
            MainColor = Color3.fromRGB(15, 15, 20),
            SecondaryColor = Color3.fromRGB(20, 20, 25),
            AccentColor = Color3.fromRGB(120, 0, 255),
            TextColor = Color3.fromRGB(240, 240, 240)
        },
        Light = {
            MainColor = Color3.fromRGB(240, 240, 245),
            SecondaryColor = Color3.fromRGB(230, 230, 235),
            AccentColor = Color3.fromRGB(0, 120, 255),
            TextColor = Color3.fromRGB(40, 40, 40)
        }
    },
    CurrentTheme = nil,
    Sounds = {
        Click = "rbxassetid://6895079853",
        Hover = "rbxassetid://6895079733",
        Switch = "rbxassetid://6895079999"
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- Utility Functions
local function CreateParticles(parent)
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxassetid://7891549290"
    emitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 105, 225)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 255))
    })
    emitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 0)
    })
    emitter.Lifetime = NumberRange.new(1, 2)
    emitter.Rate = 5
    emitter.Speed = NumberRange.new(50, 100)
    emitter.Parent = parent
    return emitter
end

local function CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.6
    ripple.BorderSizePixel = 0
    ripple.Position = UDim2.new(0, position.X, 0, position.Y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple

    TweenService:Create(ripple, TweenInfo.new(0.5), {
        Size = UDim2.new(0, parent.AbsoluteSize.X * 1.5, 0, parent.AbsoluteSize.X * 1.5),
        BackgroundTransparency = 1
    }):Play()

    game.Debris:AddItem(ripple, 0.5)
end

local function PlaySound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    game.Debris:AddItem(sound, sound.TimeLength)
end

function Library:CreateWindow(title, theme)
    Library.CurrentTheme = Library.Themes[theme] or Library.Themes.Default
    
    -- Custom Cursor
    local cursor = Instance.new("ImageLabel")
    cursor.Image = "rbxassetid://7891550875"
    cursor.Size = UDim2.new(0, 24, 0, 24)
    cursor.BackgroundTransparency = 1
    cursor.Parent = CoreGui
    
    UserInputService.MouseIconEnabled = false
    RunService.RenderStepped:Connect(function()
        cursor.Position = UDim2.new(0, UserInputService:GetMouseLocation().X, 0, UserInputService:GetMouseLocation().Y)
    end)

    -- Main GUI Components
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    -- ... (GUI bileşenleri devam ediyor)

    -- 3D Transformations
    local function Apply3DEffect(frame)
        local rotation = 0
        RunService.RenderStepped:Connect(function(delta)
            rotation = rotation + delta * 90
            frame.Rotation = math.sin(math.rad(rotation)) * 2
        end)
    end

    Apply3DEffect(MainFrame)

    -- Window Functions
    local Window = {}

    function Window:CreateTab(name)
        -- Tab creation code
        local Tab = Instance.new("TextButton")
        -- ... (Tab kodları devam ediyor)

        return TabFunctions
    end

    -- Animate GUI opening with particles
    local particles = CreateParticles(MainFrame)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 600, 0, 400),
        BackgroundTransparency = 0
    }):Play()
    
    wait(0.5)
    particles:Destroy()

    return Window
end

return Library

-- Premium Modern UI Library - Part 1
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
        }
    },
    Settings = {
        Sounds = true,
        Particles = true,
        Ripples = true,
        CustomCursor = true
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Utility Functions
local function CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.6
    ripple.Position = UDim2.new(0, position.X - parent.AbsolutePosition.X, 0, position.Y - parent.AbsolutePosition.Y)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    ripple.Parent = parent
    
    local size = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2
    local tween = TweenService:Create(ripple, TweenInfo.new(0.5), {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1
    })
    
    tween:Play()
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

local function CreateParticles(parent)
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxassetid://7891549290"
    emitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Library.Themes.Default.AccentColor),
        ColorSequenceKeypoint.new(1, Library.Themes.Default.AccentColor:Lerp(Color3.new(1,1,1), 0.5))
    })
    emitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.2),
        NumberSequenceKeypoint.new(1, 0)
    })
    emitter.Lifetime = NumberRange.new(0.5, 1)
    emitter.Rate = 20
    emitter.Speed = NumberRange.new(20, 50)
    emitter.SpreadAngle = Vector2.new(-180, 180)
    emitter.Parent = parent
    
    return emitter
end

function Library:CreateWindow(title, theme)
    local selectedTheme = self.Themes[theme] or self.Themes.Default
    
    -- Custom Cursor
    if self.Settings.CustomCursor then
        local cursor = Instance.new("ImageLabel")
        cursor.Image = "rbxassetid://7891550875"
        cursor.Size = UDim2.new(0, 24, 0, 24)
        cursor.BackgroundTransparency = 1
        cursor.Parent = CoreGui
        
        UserInputService.MouseIconEnabled = false
        RunService.RenderStepped:Connect(function()
            cursor.Position = UDim2.new(0, UserInputService:GetMouseLocation().X, 0, UserInputService:GetMouseLocation().Y)
        end)
    end
    
    -- Main GUI Components
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Shadow = Instance.new("ImageLabel")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("ScrollingFrame")
    local ContentContainer = Instance.new("Frame")
    
    -- GUI Setup
    ScreenGui.Name = "PremiumUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = selectedTheme.MainColor
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.ClipsDescendants = true
    
    -- Shadow Effect
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Image = "rbxassetid://7912134082"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ZIndex = 0
    
    -- Continue with other components...
    -- (To be continued in Part 2)
    -- Premium Modern UI Library - Part 2 (Continuation)

    -- TopBar Setup
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = selectedTheme.SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = selectedTheme.TextColor
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Make window draggable
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            if Library.Settings.Particles then
                local particles = CreateParticles(MainFrame)
                wait(0.5)
                particles:Destroy()
            end
        end
    end)
    
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Tab System
    local Window = {}
    
    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        
        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = selectedTheme.SecondaryColor
        Tab.Size = UDim2.new(1, -10, 0, 35)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = selectedTheme.TextColor
        Tab.TextSize = 12
        Tab.AutoButtonColor = false
        
        -- Tab Hover Effect
        Tab.MouseEnter:Connect(function()
            TweenService:Create(Tab, TweenInfo.new(0.3), {
                BackgroundColor3 = selectedTheme.AccentColor
            }):Play()
            
            if Library.Settings.Particles then
                local particles = CreateParticles(Tab)
                wait(0.3)
                particles:Destroy()
            end
        end)
        
        Tab.MouseLeave:Connect(function()
            TweenService:Create(Tab, TweenInfo.new(0.3), {
                BackgroundColor3 = selectedTheme.SecondaryColor
            }):Play()
        end)
        
        -- Tab Click Effect
        Tab.MouseButton1Click:Connect(function()
            if Library.Settings.Ripples then
                CreateRipple(Tab, UserInputService:GetMouseLocation())
            end
        end)
        
        local TabFunctions = {}
        
        function TabFunctions:CreateModule(moduleName, options)
            local Module = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local Content = Instance.new("Frame")
            
            -- Module setup
            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = selectedTheme.SecondaryColor
            Module.Size = UDim2.new(1, -20, 0, 60)
            
            Title.Name = "Title"
            Title.Parent = Module
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(1, -20, 0, 30)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = moduleName
            Title.TextColor3 = selectedTheme.TextColor
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Module types (Toggle, Slider, etc.)
            if options.type == "toggle" then
                local Toggle = Instance.new("TextButton")
                -- Toggle implementation
            elseif options.type == "slider" then
                local Slider = Instance.new("Frame")
                -- Slider implementation
            end
            
            return Module
        end
        
        return TabFunctions
    end
    
    -- Animate window opening
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 600, 0, 400),
        BackgroundTransparency = 0
    }):Play()
    
    if Library.Settings.Particles then
        local particles = CreateParticles(MainFrame)
        wait(0.5)
        particles:Destroy()
    end
    
    return Window
end

return Library
