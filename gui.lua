-- Modern UI Library with All Features
-- Version 2.0

local Library = {
    Themes = {
        Default = {
            MainColor = Color3.fromRGB(25, 25, 35),
            SecondaryColor = Color3.fromRGB(35, 35, 45),
            AccentColor = Color3.fromRGB(65, 105, 225),
            TextColor = Color3.fromRGB(255, 255, 255),
            OutlineColor = Color3.fromRGB(50, 50, 60)
        },
        Dark = {
            MainColor = Color3.fromRGB(15, 15, 20),
            SecondaryColor = Color3.fromRGB(20, 20, 25),
            AccentColor = Color3.fromRGB(120, 0, 255),
            TextColor = Color3.fromRGB(240, 240, 240),
            OutlineColor = Color3.fromRGB(30, 30, 35)
        },
        Light = {
            MainColor = Color3.fromRGB(240, 240, 245),
            SecondaryColor = Color3.fromRGB(230, 230, 235),
            AccentColor = Color3.fromRGB(0, 120, 255),
            TextColor = Color3.fromRGB(30, 30, 30),
            OutlineColor = Color3.fromRGB(200, 200, 205)
        }
    },
    CurrentTheme = nil,
    Flags = {},
    Windows = {},
    Settings = {
        ConfigFolder = "ModernUI",
        ConfigExtension = ".cfg",
        DefaultKeybind = Enum.KeyCode.RightShift
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Constants
local TWEEN_SPEED = 0.2
local CORNER_RADIUS = UDim.new(0, 6)
local LOCAL_PLAYER = Players.LocalPlayer

-- Utility Functions
local function CreateTween(instance, properties, duration)
    return TweenService:Create(instance, TweenInfo.new(duration or TWEEN_SPEED), properties)
end

local function SaveConfig(name)
    if not isfolder(Library.Settings.ConfigFolder) then
        makefolder(Library.Settings.ConfigFolder)
    end
    
    local config = {}
    for flag, value in pairs(Library.Flags) do
        config[flag] = value
    end
    
    writefile(Library.Settings.ConfigFolder .. "/" .. name .. Library.Settings.ConfigExtension, 
        HttpService:JSONEncode(config))
end

local function LoadConfig(name)
    if isfile(Library.Settings.ConfigFolder .. "/" .. name .. Library.Settings.ConfigExtension) then
        local config = HttpService:JSONDecode(readfile(
            Library.Settings.ConfigFolder .. "/" .. name .. Library.Settings.ConfigExtension))
        
        for flag, value in pairs(config) do
            if Library.Flags[flag] ~= nil then
                Library.Flags[flag] = value
            end
        end
    end
end

local function AddTooltip(instance, text)
    local Tooltip = Instance.new("Frame")
    Tooltip.Name = "Tooltip"
    Tooltip.Parent = instance
    Tooltip.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
    Tooltip.BorderSizePixel = 0
    Tooltip.Position = UDim2.new(1, 5, 0, 0)
    Tooltip.Size = UDim2.new(0, 200, 0, 30)
    Tooltip.Visible = false
    Tooltip.ZIndex = 100
    
    local TooltipText = Instance.new("TextLabel")
    TooltipText.Parent = Tooltip
    TooltipText.BackgroundTransparency = 1
    TooltipText.Size = UDim2.new(1, 0, 1, 0)
    TooltipText.Font = Enum.Font.Gotham
    TooltipText.Text = text
    TooltipText.TextColor3 = Library.CurrentTheme.TextColor
    TooltipText.TextSize = 14
    
    instance.MouseEnter:Connect(function()
        Tooltip.Visible = true
    end)
    
    instance.MouseLeave:Connect(function()
        Tooltip.Visible = false
    end)
end

local function CreateContextMenu(instance, options)
    local ContextMenu = Instance.new("Frame")
    ContextMenu.Name = "ContextMenu"
    ContextMenu.Parent = instance
    ContextMenu.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
    ContextMenu.BorderSizePixel = 0
    ContextMenu.Position = UDim2.new(0, 0, 1, 5)
    ContextMenu.Size = UDim2.new(0, 150, 0, #options * 30)
    ContextMenu.Visible = false
    ContextMenu.ZIndex = 100
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ContextMenu
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    for i, option in ipairs(options) do
        local Button = Instance.new("TextButton")
        Button.Parent = ContextMenu
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Font = Enum.Font.Gotham
        Button.Text = option.Text
        Button.TextColor3 = Library.CurrentTheme.TextColor
        Button.TextSize = 14
        
        Button.MouseButton1Click:Connect(function()
            option.Callback()
            ContextMenu.Visible = false
        end)
    end
    
    instance.MouseButton2Click:Connect(function()
        ContextMenu.Visible = not ContextMenu.Visible
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            ContextMenu.Visible = false
        end
    end)
end

function Library:CreateWindow(title, theme)
    self.CurrentTheme = self.Themes[theme] or self.Themes.Default
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create Main Window
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = self.CurrentTheme.MainColor
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    
    -- Add Window Components
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = self.CurrentTheme.SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = self.CurrentTheme.TextColor
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Add Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = self.CurrentTheme.TextColor
    MinimizeButton.TextSize = 20
    
    -- Add Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = self.CurrentTheme.TextColor
    CloseButton.TextSize = 20
    
    -- Add Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = self.CurrentTheme.SecondaryColor
    TabContainer.Position = UDim2.new(0, 10, 0, 40)
    TabContainer.Size = UDim2.new(0, 120, 1, -50)
    
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    
    -- Add Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 140, 0, 40)
    ContentContainer.Size = UDim2.new(1, -150, 1, -50)
    
    -- Add Search Bar
    local SearchBar = Instance.new("TextBox")
    SearchBar.Name = "SearchBar"
    SearchBar.Parent = Main
    SearchBar.BackgroundColor3 = self.CurrentTheme.SecondaryColor
    SearchBar.Position = UDim2.new(0, 140, 0, 40)
    SearchBar.Size = UDim2.new(1, -150, 0, 30)
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.PlaceholderText = "Search..."
    SearchBar.Text = ""
    SearchBar.TextColor3 = self.CurrentTheme.TextColor
    SearchBar.TextSize = 14
    
    -- Window Functions
    local Window = {}
    
    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = self.CurrentTheme.MainColor
        Tab.Size = UDim2.new(1, 0, 0, 30)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = self.CurrentTheme.TextColor
        Tab.TextSize = 14
        
        local Content = Instance.new("ScrollingFrame")
        Content.Name = name .. "Content"
        Content.Parent = ContentContainer
        Content.BackgroundTransparency = 1
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.ScrollBarThickness = 2
        Content.Visible = false
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = Content
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 5)
        
        -- Tab Functions
        local TabFunctions = {}
        
        function TabFunctions:CreateToggle(name, default, callback)
            local Toggle = Instance.new("Frame")
            Toggle.Name = name
            Toggle.Parent = Content
            Toggle.BackgroundColor3 = self.CurrentTheme.SecondaryColor
            Toggle.Size = UDim2.new(1, 0, 0, 30)
            
            -- Add toggle components here
            
            return Toggle
        end
        
        function TabFunctions:CreateSlider(name, min, max, default, callback)
            local Slider = Instance.new("Frame")
            Slider.Name = name
            Slider.Parent = Content
            Slider.BackgroundColor3 = self.CurrentTheme.SecondaryColor
            Slider.Size = UDim2.new(1, 0, 0, 50)
            
            -- Add slider components here
            
            return Slider
        end
        
        function TabFunctions:CreateDropdown(name, options, callback)
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = name
            Dropdown.Parent = Content
            Dropdown.BackgroundColor3 = self.CurrentTheme.SecondaryColor
            Dropdown.Size = UDim2.new(1, 0, 0, 30)
            
            -- Add dropdown components here
            
            return Dropdown
        end
        
        -- Add more tab functions as needed
        
        return TabFunctions
    end
    
    -- Add window event handlers
    MinimizeButton.MouseButton1Click:Connect(function()
        Main.Size = Main.Size == UDim2.new(0, 500, 0, 30) 
            and UDim2.new(0, 500, 0, 350) 
            or UDim2.new(0, 500, 0, 30)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Add keybind handler
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Library.Settings.DefaultKeybind then
            Main.Visible = not Main.Visible
        end
    end)
    
    -- Add search functionality
    SearchBar.Changed:Connect(function()
        local searchText = SearchBar.Text:lower()
        for _, tab in pairs(ContentContainer:GetChildren()) do
            if tab:IsA("ScrollingFrame") then
                for _, item in pairs(tab:GetChildren()) do
                    if item:IsA("Frame") then
                        item.Visible = item.Name:lower():find(searchText) ~= nil
                    end
                end
            end
        end
    end)
    
    -- Add dragging functionality
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
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
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    table.insert(self.Windows, Window)
    return Window
end

return Library
