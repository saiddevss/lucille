--[[ VAPE UI Library FAQ ve Örnekler

# Temel Kullanım:
local UI = Library.new("VAPE V4")
local Tab = UI:CreateTab("TabName")
local Button = Tab:AddButton("ButtonName", true)

# Özellikler:
- Tab sistemi
- Extra özellikler menüsü
- Slider
- Mode değiştirme
- Toggle butonlar
- Modern tasarım
- Sürüklenebilir pencereler

# Örnek Kullanımlar:
]]

-- Combat Tab Örneği
local UI = Library.new("VAPE V4")
local CombatTab = UI:CreateTab("Combat")

-- KillAura Örneği
CombatTab:AddButton("KillAura", true, {
    enabled = false,
    range = 3.5,
    modes = {"Single", "Multi", "Switch"},
    currentMode = "Single",
    settings = {
        delay = 0.1,
        targetAmount = 1
    }
})

-- AutoClicker Örneği
CombatTab:AddButton("AutoClicker", true, {
    enabled = false,
    cps = {
        min = 12,
        max = 16
    },
    modes = {"Normal", "RightClick", "Both"},
    currentMode = "Normal"
})

-- Reach Örneği
CombatTab:AddButton("Reach", true, {
    enabled = false,
    range = 3.5,
    modes = {"Normal", "Vertical", "Both"},
    visualize = false
})

-- Movement Tab Örneği
local MovementTab = UI:CreateTab("Movement")

-- Speed Örneği
MovementTab:AddButton("Speed", true, {
    enabled = false,
    speed = 1.5,
    modes = {"Normal", "CFrame", "TP"},
    bypass = true,
    jump = false
})

-- Flight Örneği
MovementTab:AddButton("Flight", true, {
    enabled = false,
    speed = 1,
    modes = {"Normal", "Glide", "Dynamic"},
    verticalSpeed = 1,
    bypass = true
})

-- Render Tab Örneği
local RenderTab = UI:CreateTab("Render")

-- ESP Örneği
RenderTab:AddButton("ESP", true, {
    enabled = false,
    settings = {
        boxes = true,
        tracers = false,
        names = true,
        health = true,
        distance = true
    },
    colors = {
        enemy = Color3.fromRGB(255, 0, 0),
        team = Color3.fromRGB(0, 255, 0)
    }
})

-- World Tab Örneği
local WorldTab = UI:CreateTab("World")

-- ChestStealer Örneği
WorldTab:AddButton("ChestStealer", true, {
    enabled = false,
    delay = 0.1,
    range = 4,
    autoClose = true,
    filter = {
        weapons = true,
        armor = true,
        blocks = false
    }
})

--[[ Örnek Kullanım Senaryoları:

1. KillAura Ayarları:
local killAura = CombatTab:AddButton("KillAura", true)
killAura:
