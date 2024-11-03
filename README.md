--[[
    Lucille UI Library FAQ ve Kullanım Kılavuzu
    Version: 1.0.0
]]

--[[ FAQ (Sık Sorulan Sorular)

Q: Library nasıl başlatılır?
A: local UI = Library.new("GUI Başlığı")

Q: Yeni tab nasıl eklenir?
A: local Tab = UI:CreateTab("Tab Adı")

Q: Toggle butonu nasıl eklenir?
A: Tab:AddToggle("Toggle Adı", function(state) end)

Q: Slider nasıl eklenir?
A: Tab:AddSlider("Slider Adı", min, max, default, function(value) end)

Q: Özel tema nasıl uygulanır?
A: UI:SetTheme({
    Background = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    Primary = Color3.fromRGB(0, 255, 128),
    Secondary = Color3.fromRGB(40, 40, 40)
})
]]

--[[ ÖRNEK KULLANIMLAR ]]

-- Basit Kullanım Örneği:
local UI = Library.new("Lucille")
local MainTab = UI:CreateTab("Main")

MainTab:AddToggle("Toggle", function(state)
    print("Toggle:", state)
end)

-- Gelişmiş Kullanım Örneği:
local CombatTab = UI:CreateTab("Combat")

-- KillAura Modülü
CombatTab:AddToggle("KillAura", function(enabled)
    if enabled then
        -- KillAura aktif
    else
        -- KillAura deaktif
    end
end)

CombatTab:AddSlider("Range", 1, 6, 3, function(value)
    -- Menzil değeri ayarlandı
end)

-- Speed Modülü
local MovementTab = UI:CreateTab("Movement")
MovementTab:AddToggle("Speed", function(enabled)
    -- Speed aktif/deaktif
end)

MovementTab:AddSlider("Speed Value", 1, 10, 2, function(value)
    -- Hız değeri ayarlandı
end)

--[[ ÖZEL MODÜL OLUŞTURMA ]]

-- Örnek Modül:
local function CreateModule(tab, name, settings)
    local container = {
        enabled = false,
        settings = settings or {}
    }
    
    -- Ana toggle
    container.toggle = tab:AddToggle(name, function(state)
        container.enabled = state
        if container.enabled then
            -- Modül aktif
        else
            -- Modül deaktif
        end
    end)
    
    -- Ayarlar
    if settings.range then
        container.rangeSlider = tab:AddSlider("Range", 
            settings.range.min or 1,
            settings.range.max or 6,
            settings.range.default or 3,
            function(value)
                container.settings.range = value
            end
        )
    end
    
    return container
end

--[[ ÖRNEK MODÜLLER ]]

-- Combat Modülleri:
local CombatModules = {
    KillAura = {
        range = {min = 1, max = 6, default = 3},
        cps = {min = 1, max = 20, default = 10},
        mode = {"Single", "Multi"}
    },
    
    Reach = {
        range = {min = 3, max = 6, default = 3.5}
    },
    
    Velocity = {
        horizontal = {min = 0, max = 100, default = 0},
        vertical = {min = 0, max = 100, default = 0}
    }
}

-- Movement Modülleri:
local MovementModules = {
    Speed = {
        speed = {min = 1, max = 10, default = 2},
        mode = {"Normal", "CFrame", "TP"}
    },
    
    Flight = {
        speed = {min = 1, max = 5, default = 2},
        mode = {"Normal", "Glide"}
    }
}

--[[ KISA YOLLAR VE İPUÇLARI ]]

--[[
Kısayollar:
- RightClick: Extra menüyü açar
- LeftClick: Modülü aktif/deaktif yapar
- Shift+Click: Hızlı mod değiştirme
- Ctrl+Click: Varsayılan ayarlara döner

İpuçları:
1. Modülleri organize edin
2. Callback fonksiyonlarını ayrı tutun
3. Hata kontrolü ekleyin
4. Performansı optimize edin
5. Kullanıcı dostu arayüz tasarlayın
]]

--[[ HATA AYIKLAMA ]]

local Debug = {
    enabled = false,
    
    log = function(msg)
        if Debug.enabled then
            print("[Lucille Debug]:", msg)
        end
    end,
    
    error = function(msg)
        if Debug.enabled then
            warn("[Lucille Error]:", msg)
        end
    end
}

--[[ ÖRNEK TEMA ]]

local DefaultTheme = {
    Background = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    Primary = Color3.fromRGB(0, 255, 128),
    Secondary = Color3.fromRGB(40, 40, 40),
    Toggle = Color3.fromRGB(0, 255, 128),
    Slider = Color3.fromRGB(0, 255, 128)
}

--[[ PERFORMANS İPUÇLARI ]]

--[[
1. Gereksiz döngülerden kaçının
2. Instance'ları yeniden kullanın
3. Event bağlantılarını temizleyin
4. Render adımlarını optimize edin
5. Bellek kullanımını kontrol edin
]]

--[[ GÜVENLİK ÖNLEMLERİ ]]

--[[
1. Anti-cheat bypass kontrolü
2. Hile tespiti koruması
3. Güvenli callback yönetimi
4. Olay filtreleme
5. Hata yönetimi
]]

--[[ GÜNCELLEME NOTLARI ]]

--[[
v1.0.0
- İlk sürüm
- Temel özellikler eklendi
- UI sistemi geliştirildi
- Modül sistemi eklendi
]]
