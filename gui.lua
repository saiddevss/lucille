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
        }
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

function Library:CreateWindow(title, theme)
    local selectedTheme = self.Themes[theme] or self.Themes.Default
    
    -- Main GUI Components
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("ScrollingFrame")
    local ContentContainer = Instance.new("Frame")
    
    -- GUI Setup
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = selectedTheme.MainColor
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.ClipsDescendants = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = MainFrame
    
    -- Shadow Effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.Parent = MainFrame

    
        -- TopBar Setup
        TopBar.Name = "TopBar"
        TopBar.Parent = MainFrame
        TopBar.BackgroundColor3 = selectedTheme.SecondaryColor
        TopBar.Size = UDim2.new(1, 0, 0, 30)
        
        local topBarCorner = Instance.new("UICorner")
        topBarCorner.CornerRadius = UDim.new(0, 6)
        topBarCorner.Parent = TopBar
        
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
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

            -- Tab Container Setup
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = selectedTheme.SecondaryColor
    TabContainer.Position = UDim2.new(0, 5, 0, 35)
    TabContainer.Size = UDim2.new(0, 140, 1, -40)
    TabContainer.ScrollBarThickness = 2
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local tabContainerCorner = Instance.new("UICorner")
    tabContainerCorner.CornerRadius = UDim.new(0, 6)
    tabContainerCorner.Parent = TabContainer
    
    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.Parent = TabContainer
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Padding = UDim.new(0, 5)
    
    -- Content Container Setup
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = selectedTheme.SecondaryColor
    ContentContainer.Position = UDim2.new(0, 150, 0, 35)
    ContentContainer.Size = UDim2.new(1, -155, 1, -40)
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 6)
    contentCorner.Parent = ContentContainer
    
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
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 4)
        tabCorner.Parent = Tab
        
        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        
        local moduleList = Instance.new("UIListLayout")
        moduleList.Parent = TabContent
        moduleList.SortOrder = Enum.SortOrder.LayoutOrder
        moduleList.Padding = UDim.new(0, 5)
        
        -- Tab Selection Logic
        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            TabContent.Visible = true
            
            -- Ripple Effect
            CreateRipple(Tab, UserInputService:GetMouseLocation())
        end)
        
        local TabFunctions = {}
        
        function TabFunctions:CreateModule(moduleName, options)
            local Module = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            
            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = selectedTheme.SecondaryColor
            Module.Size = UDim2.new(1, -10, 0, 60)
            
            local moduleCorner = Instance.new("UICorner")
            moduleCorner.CornerRadius = UDim.new(0, 4)
            moduleCorner.Parent = Module
            
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
            
            if options and options.type == "toggle" then
                -- Toggle Module Implementation
                local Toggle = Instance.new("TextButton")
                Toggle.Name = "Toggle"
                Toggle.Parent = Module
                Toggle.Position = UDim2.new(1, -60, 0, 5)
                Toggle.Size = UDim2.new(0, 50, 0, 20)
                Toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                Toggle.Text = "OFF"
                Toggle.TextColor3 = selectedTheme.TextColor
                Toggle.Font = Enum.Font.GothamBold
                Toggle.TextSize = 12
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 4)
                toggleCorner.Parent = Toggle
                
                local enabled = false
                Toggle.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    Toggle.Text = enabled and "ON" or "OFF"
                    Toggle.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
                    
                    if options.callback then
                        options.callback(enabled)
                    end
                end)
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
    
    return Window
end

return Library
