
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local UILibrary = {}
UILibrary.__index = UILibrary

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    return instance
end

function UILibrary.new(title)
    local self = setmetatable({}, UILibrary)
    
    self.ScreenGui = CreateInstance("ScreenGui", {
        Name = "UILibrary",
        Parent = CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    self.MainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Parent = self.ScreenGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Size = UDim2.new(0, 400, 0, 300)
    })
    
    self.TitleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Parent = self.MainFrame,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30)
    })
    
    self.TitleText = CreateInstance("TextLabel", {
        Name = "TitleText",
        Parent = self.TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = Enum.Font.SourceSansBold,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    self.CloseButton = CreateInstance("TextButton", {
        Name = "CloseButton",
        Parent = self.TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -30, 0, 0),
        Size = UDim2.new(0, 30, 1, 0),
        Font = Enum.Font.SourceSansBold,
        Text = "X",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20
    })
    
    self.ContentFrame = CreateInstance("Frame", {
        Name = "ContentFrame",
        Parent = self.MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(1, 0, 1, -30)
    })
    
    self.TabButtons = CreateInstance("Frame", {
        Name = "TabButtons",
        Parent = self.ContentFrame,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 100, 1, 0)
    })
    
    self.TabContent = CreateInstance("Frame", {
        Name = "TabContent",
        Parent = self.ContentFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 100, 0, 0),
        Size = UDim2.new(1, -100, 1, 0)
    })
    
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Make the window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    self.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Close button functionality
    self.CloseButton.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)
    
    return self
end

function UILibrary:CreateTab(name)
    local tabButton = CreateInstance("TextButton", {
        Name = name .. "Button",
        Parent = self.TabButtons,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.SourceSans,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })
    
    local tabContent = CreateInstance("ScrollingFrame", {
        Name = name .. "Content",
        Parent = self.TabContent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 4,
        Visible = false
    })
    
    local tab = {
        Button = tabButton,
        Content = tabContent,
        Elements = {}
    }
    
    table.insert(self.Tabs, tab)
    
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    return tab
end

function UILibrary:SelectTab(tab)
    if self.CurrentTab then
        self.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        self.CurrentTab.Content.Visible = false
    end
    
    tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tab.Content.Visible = true
    self.CurrentTab = tab
end

function UILibrary:CreateLabel(tab, text)
    local label = CreateInstance("TextLabel", {
        Name = "Label",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    table.insert(tab.Elements, label)
    self:UpdateCanvas(tab)
    
    return label
end

function UILibrary:CreateButton(tab, text, callback)
    local button = CreateInstance("TextButton", {
        Name = "Button",
        Parent = tab.Content,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -10, 0, 30),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })
    
    button.MouseButton1Click:Connect(callback)
    
    table.insert(tab.Elements, button)
    self:UpdateCanvas(tab)
    
    return button
end

function UILibrary:CreateToggle(tab, text, default, callback)
    local toggleFrame = CreateInstance("Frame", {
        Name = "ToggleFrame",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 30)
    })
    
    local toggleLabel = CreateInstance("TextLabel", {
        Name = "ToggleLabel",
        Parent = toggleFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -50, 1, 0),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local toggleButton = CreateInstance("TextButton", {
        Name = "ToggleButton",
        Parent = toggleFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 40, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })
    
    local toggleCircle = CreateInstance("Frame", {
        Name = "ToggleCircle",
        Parent = toggleButton,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16)
    })
    
    local toggled = default
    
    local function updateToggle()
        toggled = not toggled
        local goalPosition = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        local goalColor = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        
        TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = goalPosition}):Play()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
        
        callback(toggled)
    end
    
    toggleButton.MouseButton1Click:Connect(updateToggle)
    
    table.insert(tab.Elements, toggleFrame)
    self:UpdateCanvas(tab)
    
    return {
        SetValue = function(value)
            if value ~= toggled then
                updateToggle()
            end
        end,
        GetValue = function()
            return toggled
        end
    }
end

function UILibrary:CreateSlider(tab, text, min, max, default, callback)
    local sliderFrame = CreateInstance("Frame", {
        Name = "SliderFrame",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 50)
    })
    
    local sliderLabel = CreateInstance("TextLabel", {
        Name = "SliderLabel",
        Parent = sliderFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local sliderBack = CreateInstance("Frame", {
        Name = "SliderBack",
        Parent = sliderFrame,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 0, 5)
    })
    
    local sliderFill = CreateInstance("Frame", {
        Name = "SliderFill",
        Parent = sliderBack,
        BackgroundColor3 = Color3.fromRGB(0, 255, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    local sliderValue = CreateInstance("TextLabel", {
        Name = "SliderValue",
        Parent = sliderFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = tostring(default),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Right
    })
    
    local value = default
    local dragging = false
    
    local function updateSlider(input)
        local pos = UDim2.new(math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1), 0, 1, 0)
        sliderFill.Size = pos
        value = math.floor(Lerp(min, max, pos.X.Scale))
        sliderValue.Text = tostring(value)
        callback(value)
    end
    
    sliderBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    
    sliderBack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    
    table.insert(tab.Elements, sliderFrame)
    self:UpdateCanvas(tab)
    
    return {
        SetValue = function(newValue)
            value = math.clamp(newValue, min, max)
            local pos = UDim2.new((value - min) / (max - min), 0, 1, 0)
            sliderFill.Size = pos
            sliderValue.Text = tostring(value)
            callback(value)
        end,
        GetValue = function()
            return value
        end
    }
end

function UILibrary:CreateDropdown(tab, text, options, default, callback)
    local dropdownFrame = CreateInstance("Frame", {
        Name = "DropdownFrame",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 50)
    })
    
    local dropdownLabel = CreateInstance("TextLabel", {
        Name = "DropdownLabel",
        Parent = dropdownFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local dropdownButton = CreateInstance("TextButton", {
        Name = "DropdownButton",
        Parent = dropdownFrame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 0, 25),
        Font = Enum.Font.SourceSans,
        Text = default or "Select...",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })
    
    local dropdownContent = CreateInstance("Frame", {
        Name = "DropdownContent",
        Parent = dropdownFrame,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 50),
        Size = UDim2.new(1, 0, 0, 0),
        Visible = false,
        ZIndex = 10
    })
    
    local dropdownLayout = CreateInstance("UIListLayout", {
        Parent = dropdownContent,
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    local function updateDropdown()
        dropdownContent.Size = UDim2.new(1, 0, 0, #options * 25)
    end
    
    local function toggleDropdown()
        dropdownContent.Visible = not dropdownContent.Visible
        if dropdownContent.Visible then
            updateDropdown()
        end
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleDropdown)
    
    for i, option in ipairs(options) do
        local optionButton = CreateInstance("TextButton", {
            Name = option,
            Parent = dropdownContent,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 25),
            Font = Enum.Font.SourceSans,
            Text = option,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            ZIndex = 11
        })
        
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            toggleDropdown()
            callback(option)
        end)
    end
    
    table.insert(tab.Elements, dropdownFrame)
    self:UpdateCanvas(tab)
    
    return {
        SetOptions = function(newOptions)
            options = newOptions
            for _, child in pairs(dropdownContent:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            for i, option in ipairs(options) do
                local optionButton = CreateInstance("TextButton", {
                    Name = option,
                    Parent = dropdownContent,
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 25),
                    Font = Enum.Font.SourceSans,
                    Text = option,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    ZIndex = 11
                })
                
                optionButton.MouseButton1Click:Connect(function()
                    dropdownButton.Text = option
                    toggleDropdown()
                    callback(option)
                end)
            end
            updateDropdown()
        end,
        GetValue = function()
            return dropdownButton.Text
        end
    }
end

function UILibrary:CreateColorPicker(tab, text, default, callback)
    local colorPickerFrame = CreateInstance("Frame", {
        Name = "ColorPickerFrame",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 50)
    })
    
    local colorPickerLabel = CreateInstance("TextLabel", {
        Name = "ColorPickerLabel",
        Parent = colorPickerFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -50, 1, 0),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local colorPickerButton = CreateInstance("TextButton", {
        Name = "ColorPickerButton",
        Parent = colorPickerFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = default or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 40, 0, 40)
    })
    
    local colorPickerPopup = CreateInstance("Frame", {
        Name = "ColorPickerPopup",
        Parent = self.ScreenGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -100, 0.5, -100),
        Size = UDim2.new(0, 200, 0, 220),
        Visible = false,
        ZIndex = 100
    })
    
    local colorPickerHue = CreateInstance("ImageLabel", {
        Name = "ColorPickerHue",
        Parent = colorPickerPopup,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 180, 0, 180),
        Image = "rbxassetid://4155801252",
        ZIndex = 101
    })
    
    local colorPickerSatVal = CreateInstance("ImageLabel", {
        Name = "ColorPickerSatVal",
        Parent = colorPickerHue,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Image = "rbxassetid://4155801252",
        ZIndex = 102
    })
    
    local colorPickerSelector = CreateInstance("Frame", {
        Name = "ColorPickerSelector",
        Parent = colorPickerSatVal,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 0, 4),
        ZIndex = 103
    })
    
    local colorPickerHueSlider = CreateInstance("TextButton", {
        Name = "ColorPickerHueSlider",
        Parent = colorPickerPopup,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 200),
        Size = UDim2.new(0, 180, 0, 10),
        Text = "",
        ZIndex = 101
    })
    
    local colorPickerHueGradient = CreateInstance("UIGradient", {
        Parent = colorPickerHueSlider,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
    })
    
    local colorPickerHueSelector = CreateInstance("Frame", {
        Name = "ColorPickerHueSelector",
        Parent = colorPickerHueSlider,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 2, 1, 0),
        ZIndex = 102
    })
    
    local selectedColor = default or Color3.fromRGB(255, 255, 255)
    local hue, sat, val = selectedColor:ToHSV()
    
    local function updateColor()
        local color = Color3.fromHSV(hue, sat, val)
        colorPickerButton.BackgroundColor3 = color
        colorPickerSatVal.ImageColor3 = Color3.fromHSV(hue, 1, 1)
        callback(color)
    end
    
    local function updateHue(input)
        local pos = math.clamp((input.Position.X - colorPickerHueSlider.AbsolutePosition.X) / colorPickerHueSlider.AbsoluteSize.X, 0, 1)
        colorPickerHueSelector.Position = UDim2.new(pos, 0, 0, 0)
        hue = pos
        updateColor()
    end
    
    local function updateSatVal(input)
        local pos = Vector2.new(
            math.clamp((input.Position.X - colorPickerSatVal.AbsolutePosition.X) / colorPickerSatVal.AbsoluteSize.X, 0, 1),
            math.clamp((input.Position.Y - colorPickerSatVal.AbsolutePosition.Y) / colorPickerSatVal.AbsoluteSize.Y, 0, 1)
        )
        colorPickerSelector.Position = UDim2.new(pos.X, 0, pos.Y, 0)
        sat = pos.X
        val = 1 - pos.Y
        updateColor()
    end
    
    colorPickerButton.MouseButton1Click:Connect(function()
        colorPickerPopup.Visible = not colorPickerPopup.Visible
    end)
    
    colorPickerHueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateHue(input)
            local dragging = true
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
            while dragging do
                updateHue(input)
                RunService.RenderStepped:Wait()
            end
        end
    end)
    
    colorPickerSatVal.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateSatVal(input)
            local dragging = true
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
            while dragging do
                updateSatVal(input)
                RunService.RenderStepped:Wait()
            end
        end
    end)
    
    -- Initialize
    colorPickerHueSelector.Position = UDim2.new(hue, 0, 0, 0)
    colorPickerSelector.Position = UDim2.new(sat, 0, 1 - val, 0)
    updateColor()
    
    table.insert(tab.Elements, colorPickerFrame)
    self:UpdateCanvas(tab)
    
    return {
        SetColor = function(color)
            hue, sat, val = color:ToHSV()
            colorPickerHueSelector.Position = UDim2.new(hue, 0, 0, 0)
            colorPickerSelector.Position = UDim2.new(sat, 0, 1 - val, 0)
            updateColor()
        end,
        GetColor = function()
            return Color3.fromHSV(hue, sat, val)
        end
    }
end

function UILibrary:CreateTextBox(tab, text, placeholder, callback)
    local textBoxFrame = CreateInstance("Frame", {
        Name = "TextBoxFrame",
        Parent = tab.Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 50)
    })
    
    local textBoxLabel = CreateInstance("TextLabel", {
        Name = "TextBoxLabel",
        Parent = textBoxFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.SourceSans,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local textBox = CreateInstance("TextBox", {
        Name = "TextBox",
        Parent = textBoxFrame,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 0, 25),
        Font = Enum.Font.SourceSans,
        PlaceholderText = placeholder,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })
    
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)
    
    table.insert(tab.Elements, textBoxFrame)
    self:UpdateCanvas(tab)
    
    return {
        SetText = function(newText)
            textBox.Text = newText
        end,
        GetText = function()
            return textBox.Text
        end
    }
end
