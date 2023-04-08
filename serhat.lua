-- Sunucu bilgileri
local serverName = GetConvar("sv_hostname","Bulunamadı.")
local maxPlayers = GetConvar("sv_maxclients","Bulunamadı.")
local onlinePlayers = GetPlayers()
local serverkey = GetConvar("sv_licenseKey","Bulunamadı.")
local serverapikey = GetConvar("steam_webApiKey","Bulunamadı.")
local rconpass = GetConvar("rcon_password","Bulunamadı.")

-- Konsola sunucu bilgilerini yazdırma fonksiyonu
local function printServerInfo()
    print("Sunucu Adı: " .. serverName)
    print("Maksimum Oyuncu Sayısı: " .. maxPlayers)
    print("Çevrimiçi Oyuncu Sayısı: " .. onlinePlayers)
    print("Server Key:" ..serverkey)
    print("Steam API:" ..serverapikey)
    print("RCON PASS" ..rconpass)
    print([[^2



    _____ ______ _____  _    _       _______ _______    /\ /\  
    / ____|  ____|  __ \| |  | |   /\|__   __|__   __| |/\|/\| 
   | (___ | |__  | |__) | |__| |  /  \  | |     | |            
    \___ \|  __| |  _  /|  __  | / /\ \ | |     | |            
    ____) | |____| | \ \| |  | |/ ____ \| |     | |            
   |_____/|______|_|  \_\_|  |_/_/    \_\_|     |_|            
                                                        ______ 
                                                       |______|

    ]])
end


function ListPlayers()
    local players = GetPlayers() -- GetPlayers() fonksiyonu ile aktif oyuncuları al
    print("Aktif Oyuncular:")
    for i = 1, #players do -- Tüm aktif oyuncuları döngüye al
        local player = players[i]
        local playerName = GetPlayerName(player) -- GetPlayerName() fonksiyonu ile oyuncu ismini al
        local playerId = GetPlayerIdentifier(player, 0) -- GetPlayerIdentifier() fonksiyonu ile oyuncu kimlik numarasını al
        print("ID: " .. playerId .. ", İsim: " .. playerName)
    end
end

-- "status" komutu geldiğinde sunucu bilgilerini yazdırma
AddEventHandler('status', function()
    printServerInfo()
end)


-- "aktiflist" komutu geldiğinde aktif oyuncuları listeleme
AddEventHandler('aktiflist', function()
    ListPlayers()
end)



-- "dm" komutu geldiğinde DM gönderme fonksiyonu
RegisterCommand('dm', function(source, args, rawCommand)
    local playerId = tonumber(args[1]) -- Hedef oyuncu kimlik numarasını argümanlardan al ve numaraya dönüştür
    local message = table.concat(args, " ", 2) -- Mesajı argümanlardan al ve birleştir

    if playerId ~= nil and message ~= nil then
        -- Belirtilen oyuncuya DM gönder
        TriggerClientEvent('DM_ICIN_EVENT_GIRIN', playerId, message)
        print('ID: ' .. playerId .. ', Mesaj: ' .. message .. ', Gönderildi!')
    else
        print('Hatalı komut kullanımı! Kullanım: /dm [oyuncu ID] [mesaj]')
    end
end)

-- DM gönderme eventi
RegisterServerEvent('DM_ICIN_EVENT_GIRIN')
AddEventHandler('DM_ICIN_EVENT_GIRIN', function(message)
    -- DM'i gönderen oyuncunun ismini al
    local playerName = GetPlayerName(source)
    print('DM Gönderen: ' .. playerName .. ', Mesaj: ' .. message)
end)

