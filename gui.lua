-- Modern Dropdown GUI for Roblox
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Dropdown Class
local Dropdown = {}
Dropdown.__index = Dropdown

-- Constants
local DROPDOWN_SETTINGS = {
    BACKGROUND_COLOR = Color3.fromRGB(45, 45, 45),
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    HOVER_COLOR = Color3.fromRGB(60, 60, 60),
    SELECTED_COLOR = Color3.fromRGB(70, 70, 70),
    CORNER_RADIUS = UDim.new(0, 8),
    FONT = Enum.Font.GothamSemibold,
    TEXT_SIZE = 14,
    PADDING = UDim.new(0, 10),
    ANIMATION_TIME = 0.3,
    MAX_VISIBLE_ITEMS = 6
}

function Dropdown.new(parent, options)
    local self = setmetatable({}, Dropdown)
    
    -- Properties
    self.options = options or {}
    self.selectedOption = nil
    self.isOpen = false
    self.items = {}
    
    -- Create main frame
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "DropdownFrame"
    self.mainFrame.Size = UDim2.new(0, 200, 0, 40)
    self.mainFrame.BackgroundColor3 = DROPDOWN_SETTINGS.BACKGROUND_COLOR
    self.mainFrame.Parent = parent
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = DROPDOWN_SETTINGS.CORNER_RADIUS
    corner.Parent = self.mainFrame
    
    -- Selected text
    self.selectedText = Instance.new("TextLabel")
    self.selectedText.Name = "SelectedText"
    self.selectedText.Size = UDim2.new(1, -40, 1, 0)
    self.selectedText.Position = UDim2.new(0, 10, 0, 0)
    self.selectedText.BackgroundTransparency = 1
    self.selectedText.Text = "Select an option..."
    self.selectedText.TextColor3 = DROPDOWN_SETTINGS.TEXT_COLOR
    self.selectedText.TextSize = DROPDOWN_SETTINGS.TEXT_SIZE
    self.selectedText.Font = DROPDOWN_SETTINGS.FONT
    self.selectedText.TextXAlignment = Enum.TextXAlignment.Left
    self.selectedText.Parent = self.mainFrame
    
    -- Arrow icon
    self.arrow = Instance.new("ImageLabel")
    self.arrow.Name = "Arrow"
    self.arrow.Size = UDim2.new(0, 20, 0, 20)
    self.arrow.Position = UDim2.new(1, -30, 0.5, -10)
    self.arrow.BackgroundTransparency = 1
    self.arrow.Image = "rbxassetid://6034818372"
    self.arrow.Parent = self.mainFrame
    
    -- Options container
    self.optionsFrame = Instance.new("Frame")
    self.optionsFrame.Name = "OptionsFrame"
    self.optionsFrame.Size = UDim2.new(1, 0, 0, 0)
    self.optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    self.optionsFrame.BackgroundColor3 = DROPDOWN_SETTINGS.BACKGROUND_COLOR
    self.optionsFrame.ClipsDescendants = true
    self.optionsFrame.Visible = false
    self.optionsFrame.Parent = self.mainFrame
    
    -- Corner radius for options
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = DROPDOWN_SETTINGS.CORNER_RADIUS
    optionsCorner.Parent = self.optionsFrame
    
    -- Options list
    self.optionsList = Instance.new("UIListLayout")
    self.optionsList.Name = "OptionsList"
    self.optionsList.Padding = UDim.new(0, 2)
    self.optionsList.Parent = self.optionsFrame
    
    -- Initialize
    self:SetOptions(self.options)
    self:ConnectEvents()
    
    return self
end

function Dropdown:SetOptions(options)
    -- Clear existing options
    for _, item in pairs(self.items) do
        item:Destroy()
    end
    self.items = {}
    
    -- Add new options
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. i
        optionButton.Size = UDim2.new(1, 0, 0, 35)
        optionButton.BackgroundColor3 = DROPDOWN_SETTINGS.BACKGROUND_COLOR
        optionButton.Text = option
        optionButton.TextColor3 = DROPDOWN_SETTINGS.TEXT_COLOR
        optionButton.TextSize = DROPDOWN_SETTINGS.TEXT_SIZE
        optionButton.Font = DROPDOWN_SETTINGS.FONT
        optionButton.Parent = self.optionsFrame
        
        -- Hover effect
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, 
                TweenInfo.new(0.2), 
                {BackgroundColor3 = DROPDOWN_SETTINGS.HOVER_COLOR}
            ):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, 
                TweenInfo.new(0.2), 
                {BackgroundColor3 = DROPDOWN_SETTINGS.BACKGROUND_COLOR}
            ):Play()
        end)
        
        -- Click handler
        optionButton.MouseButton1Click:Connect(function()
            self:SelectOption(option)
        end)
        
        table.insert(self.items, optionButton)
    end
    
    -- Update options frame size
    local totalHeight = #options * 35 + (#options - 1) * 2
    self.maxHeight = math.min(totalHeight, DROPDOWN_SETTINGS.MAX_VISIBLE_ITEMS * 37)
end

function Dropdown:SelectOption(option)
    self.selectedOption = option
    self.selectedText.Text = option
    self:Toggle(false)
    
    -- Fire change event if exists
    if self.onChange then
        self.onChange(option)
    end
end

function Dropdown:Toggle(force)
    self.isOpen = force ~= nil and force or not self.isOpen
    
    -- Animation
    local targetSize = self.isOpen and UDim2.new(1, 0, 0, self.maxHeight) or UDim2.new(1, 0, 0, 0)
    local targetRotation = self.isOpen and 180 or 0
    
    self.optionsFrame.Visible = true
    
    TweenService:Create(self.optionsFrame,
        TweenInfo.new(DROPDOWN_SETTINGS.ANIMATION_TIME, Enum.EasingStyle.Quad),
        {Size = targetSize}
    ):Play()
    
    TweenService:Create(self.arrow,
        TweenInfo.new(DROPDOWN_SETTINGS.ANIMATION_TIME, Enum.EasingStyle.Quad),
        {Rotation = targetRotation}
    ):Play()
    
    if not self.isOpen then
        wait(DROPDOWN_SETTINGS.ANIMATION_TIME)
        self.optionsFrame.Visible = false
    end
end

function Dropdown:ConnectEvents()
    -- Toggle dropdown on click
    self.mainFrame.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    -- Close dropdown when clicking outside
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePosition = UserInputService:GetMouseLocation()
            local objects = game:GetService("Players").LocalPlayer:GetGuiObjectsAtPosition(mousePosition.X, mousePosition.Y)
            
            local isClickingDropdown = false
            for _, object in ipairs(objects) do
                if object:IsDescendantOf(self.mainFrame) then
                    isClickingDropdown = true
                    break
                end
            end
            
            if not isClickingDropdown and self.isOpen then
                self:Toggle(false)
            end
        end
    end)
end

function Dropdown:SetOnChange(callback)
    self.onChange = callback
end

-- Usage example:
--[[
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

local options = {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"}
local dropdown = Dropdown.new(Frame, options)

dropdown:SetOnChange(function(selectedOption)
    print("Selected:", selectedOption)
end)
]]--

return Dropdown
