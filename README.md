```markdown
# Lucille UI Library
Modern ve kullanıcı dostu bir Roblox UI Library.

## İçindekiler
- [Kurulum](#kurulum)
- [Temel Kullanım](#temel-kullanım)
- [Özellikler](#özellikler)
- [Örnekler](#örnekler)
- [API Referansı](#api-referansı)
- [Temalar](#temalar)
- [SSS](#sss)

## Kurulum
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/user/lucille/main/library.lua"))()
```

## Temel Kullanım
```lua
-- UI oluşturma
local UI = Library.new("Lucille")

-- Tab ekleme
local CombatTab = UI:CreateTab("Combat")

-- Toggle ekleme
CombatTab:AddToggle("KillAura", function(state)
    print("KillAura:", state)
end)

-- Slider ekleme
CombatTab:AddSlider("Range", 1, 6, 3, function(value)
    print("Range:", value)
end)
```

## Özellikler
- 🎨 Modern ve şık tasarım
- 📱 Sürüklenebilir arayüz
- 🎯 Kolay kullanım
- ⚡ Yüksek performans
- 🛠️ Özelleştirilebilir temalar
- 📦 Modüler yapı

## Örnekler

### Combat Modülü
```lua
local CombatTab = UI:CreateTab("Combat")

-- KillAura
CombatTab:AddToggle("KillAura", function(enabled)
    if enabled then
        -- KillAura aktif
    else
        -- KillAura deaktif
    end
end)

CombatTab:AddSlider("Range", 1, 6, 3, function(value)
    -- Menzil değeri
end)
```

### Movement Modülü
```lua
local MovementTab = UI:CreateTab("Movement")

-- Speed
MovementTab:AddToggle("Speed", function(enabled)
    -- Speed aktif/deaktif
end)

MovementTab:AddSlider("Speed Value", 1, 10, 2, function(value)
    -- Hız değeri
end)
```

## API Referansı

### Library
| Metod | Açıklama | Parametreler |
|-------|-----------|-------------|
| `Library.new(title)` | Yeni UI oluşturur | `title`: string |
| `UI:CreateTab(name)` | Yeni tab oluşturur | `name`: string |
| `UI:SetTheme(theme)` | Tema ayarlar | `theme`: table |

### Tab
| Metod | Açıklama | Parametreler |
|-------|-----------|-------------|
| `Tab:AddToggle(name, callback)` | Toggle ekler | `name`: string, `callback`: function |
| `Tab:AddSlider(name, min, max, default, callback)` | Slider ekler | `name`: string, `min`: number, `max`: number, `default`: number, `callback`: function |

## Temalar
```lua
-- Varsayılan tema
local DefaultTheme = {
    Background = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    Primary = Color3.fromRGB(0, 255, 128),
    Secondary = Color3.fromRGB(40, 40, 40),
    Toggle = Color3.fromRGB(0, 255, 128),
    Slider = Color3.fromRGB(0, 255, 128)
}

-- Tema uygulama
UI:SetTheme(DefaultTheme)
```

## SSS

### UI nasıl başlatılır?
```lua
local UI = Library.new("GUI Başlığı")
```

### Yeni tab nasıl eklenir?
```lua
local Tab = UI:CreateTab("Tab Adı")
```

### Toggle butonu nasıl eklenir?
```lua
Tab:AddToggle("Toggle Adı", function(state) end)
```

### Slider nasıl eklenir?
```lua
Tab:AddSlider("Slider Adı", min, max, default, function(value) end)
```

## Kısayollar
| Tuş | İşlev |
|-----|--------|
| RightClick | Extra menüyü açar |
| LeftClick | Modülü aktif/deaktif yapar |
| Shift+Click | Hızlı mod değiştirme |
| Ctrl+Click | Varsayılan ayarlara döner |

## Performans İpuçları
1. Gereksiz döngülerden kaçının
2. Instance'ları yeniden kullanın
3. Event bağlantılarını temizleyin
4. Render adımlarını optimize edin
5. Bellek kullanımını kontrol edin

## Güvenlik Önlemleri
1. Anti-cheat bypass kontrolü
2. Hile tespiti koruması
3. Güvenli callback yönetimi
4. Olay filtreleme
5. Hata yönetimi

## Güncelleme Notları

### v1.0.0
- İlk sürüm
- Temel özellikler eklendi
- UI sistemi geliştirildi
- Modül sistemi eklendi

## Lisans
MIT License

## İletişim
- Discord: lucille
- GitHub: github.com/user/lucille

## Katkıda Bulunma
1. Fork yapın
2. Feature branch oluşturun
3. Değişikliklerinizi commit edin
4. Branch'inizi push edin
5. Pull request açın
```

Bu README:
1. Library'nin temel kullanımını açıklar
2. Detaylı örnekler sunar
3. API referansı içerir
4. SSS bölümü ile yaygın soruları yanıtlar
5. Performans ve güvenlik ipuçları verir
6. Güncelleme notları ve lisans bilgisi içerir
