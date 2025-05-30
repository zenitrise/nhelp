script_name("N Helper")
script_author("zenitrise")

---------- Перменные для текста -----------

local tag = "[N Helper] "
local tagcolor = 0x20f271
local textcolor = "{DCDCDC}"
local warncolor = "{9c9c9c}"

local paydaytext = ''
---------- Авто-Обновление ----------

local script_vers = 47
local script_vers_text = "3.9"
local dlstatus = require("moonloader").download_status
local update_status = false
local download_lib = false

local update_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/NHelper.lua"
local script_path = thisScript().path

local fa5_url ="https://raw.githubusercontent.com/zenitrise/nhelp/main/fAwesome5.lua"
local fa5_path = "moonloader/lib/fAwesome5.lua"

local font_url = "https://github.com/zenitrise/nhelp/blob/main/fa-solid-900.ttf"
local font_path = "moonloader/resource/fonts/fa-solid-900.ttf"

local encoding_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/encoding.lua"
local encoding_path = "moonloader/lib/encoding.lua"

local imgui_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/imgui.lua"
local imgui_path =  "moonloader/lib/imgui.lua"

local imguiadd_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/imgui_addons.lua"
local imguiadd_path =  "moonloader/lib/imgui_addons.lua"

local rkeys_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/rkeys.lua"
local rkeys_path = "moonloader/lib/rkeys.lua"

local vkeys_url = "https://raw.githubusercontent.com/zenitrise/nhelp/main/vkeys.lua"
local vkeys_path = "moonloader/lib/vkeys.lua"
----------- Подгрузка библиотек и дерикторий ---------

if not doesDirectoryExist("moonloader/lib") then
    createDirectory("moonloader/lib")
end

if not doesDirectoryExist("moonloader/resource") then
    createDirectory("moonloader/resource")
end

if not doesDirectoryExist("moonloader/resource/fonts") then
    createDirectory("moonloader/resource/fonts")
end

if not doesFileExist(fa5_path) then
    downloadUrlToFile(fa5_url, fa5_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "Font Awesome 5 " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(font_path) then
    downloadUrlToFile(font_url, font_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружены шрифты для библиотеки " .. warncolor .. "Font Awesome 5 " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(encoding_path) then
    downloadUrlToFile(encoding_url, encoding_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "Encoding " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(vkeys_path) then
    downloadUrlToFile(vkeys_url, vkeys_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "VKeys " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(imgui_path) then
    downloadUrlToFile(imgui_url, imgui_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "ImGui " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(imguiadd_path) then
    downloadUrlToFile(imguiadd_url, imguiadd_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "ImGui Addons " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if not doesFileExist(rkeys_path) then
    downloadUrlToFile(rkeys_url, rkeys_path)
    sampAddChatMessage(tag .. textcolor .. "У вас не загружена библиотека " .. warncolor .. "RKeys " .. textcolor .. "Начинаю загрузку..", tagcolor)
    download_lib = true
end

if download_lib then
    thisScript():reload()
end

--------------------
---------- Библиотеки ----------

require "lib.moonloader"

local vkeys = require "vkeys"
local rkeys = require "rkeys"
local effil = require("effil")
local inicfg = require "inicfg"
local imadd = require 'imgui_addons'
local imgui = require "imgui"
imgui.HotKey = require("imgui_addons").HotKey
local encoding = require "encoding"
local sampev = require "samp.events"
local fa = require 'fAwesome5'

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

encoding.default = "CP1251"
u8 = encoding.UTF8

imgui.HotKey = require("imgui_addons").HotKey

---------- Подгрузка, настройка .ini ----------

local directIni = "NHelper.ini"
local mainIni = inicfg.load({
    tg = {
        id = "User ID",
        token = "Bot Token",
        toggle = false,
        box = false,
        cr = false,
        disconnect = false,
        payday = false,
        perevod = false
    },
    box = {
        toggle = false,
        roulette = false,
        platina = false,
        donate = false,
        elonmusk = false,
        lossantos = false,
        vicecity = false,
        open_delay_min = 65,
        open_delay_max = 75,
        do_delay = 1
    },
    hotkey = {
        main_window = "[18,82]",
        toggle = true
    },
    autoreconnect = {
        toggle = false,
        min = 600,
        max = 1200,
        dont_reconnect = false,
        dont_reconnect_hour_first = 5,
        dont_reconnect_hour_second = 10
    },
    lavka = {
        toggle = false,
        name = "N Helper",
        color = 7,
    },
    timechange = {
        toggle = false,
        hours = 20,
        minutes = 30,
        weather = 37
    },
    addspawn = {
        toggle = false,
        waittoggle = false,
        id = 1,
        wait = 5
    },
    rlavka = {
        toggle = false,
        radius = 10
    },
    lavk = {
        toggle = false,
    },
    stock = {
        toggle = false,
    },
}, "NHelper")

if not doesFileExist("NHelper.ini") then
    inicfg.save(mainIni, "NHelper.ini")
end



---------- Переменные, массивы ----------

rx, ry = getScreenResolution()
local falpha = 0.01
local colors = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"}

--- hotkey

local main_window = {
    v = decodeJson(mainIni.hotkey.main_window)
}

---
local selected_window = 1

local tg_toggle = imgui.ImBool(mainIni.tg.toggle)
local token = imgui.ImBuffer(mainIni.tg.token, 512) -- токен бота
local chat_id = imgui.ImBuffer(tostring(mainIni.tg.id), 512)
local updateid -- ID последнего сообщения для того чтобы не было флуда
local tg_box = imgui.ImBool(mainIni.tg.box)
local tg_cr = imgui.ImBool(mainIni.tg.cr)
local tg_perevod = imgui.ImBool(mainIni.tg.perevod)
local tg_disconnect = imgui.ImBool(mainIni.tg.disconnect)
local tg_payday = imgui.ImBool(mainIni.tg.payday)
local tgpd = {"========== Pay Day ==========", " "}

local rlavka_toggle = imgui.ImBool(mainIni.rlavka.toggle)
local rlavka_radius = imgui.ImInt(mainIni.rlavka.radius)

local box_roulette_tid
local box_platina_tid
local box_donate_tid
local box_elonmusk_tid
local box_lossantos_tid
local box_vc_tid
local box_toggle = imgui.ImBool(mainIni.box.toggle)
local box_roulette = imgui.ImBool(mainIni.box.roulette)
local box_platina = imgui.ImBool(mainIni.box.platina)
local box_donate = imgui.ImBool(mainIni.box.donate)
local box_elonmusk = imgui.ImBool(mainIni.box.elonmusk)
local box_lossantos = imgui.ImBool(mainIni.box.lossantos)
local box_vicecity = imgui.ImBool(mainIni.box.vicecity)
local box_open_delay_min = imgui.ImInt(mainIni.box.open_delay_min)
local box_open_delay_max = imgui.ImInt(mainIni.box.open_delay_max)
local box_do_delay = imgui.ImInt(mainIni.box.do_delay)
local work = false

local hotkey_toggle = imgui.ImBool(mainIni.hotkey.toggle)

local main_window_state = imgui.ImBool(false)
local autoreconnect_settings_window_state = imgui.ImBool(false)
local lavka_settings_window_state = imgui.ImBool(false)
local timechange_settings_window_state = imgui.ImBool(false)
local addspawn_settings_window_state = imgui.ImBool(false)
local box_settings_window_state = imgui.ImBool(false)
local con_window_state = imgui.ImBool(false)
local tg_settings_window_state = imgui.ImBool(false)
local rlavka_settings_window_state = imgui.ImBool(false)

local addspawn_toggle = imgui.ImBool(mainIni.addspawn.toggle)
local addspawn_id = imgui.ImInt(mainIni.addspawn.id)
local addspawn_wait = imgui.ImInt(mainIni.addspawn.wait)
local addspawn_waittoggle = imgui.ImBool(mainIni.addspawn.waittoggle)

local timechange_hours = imgui.ImInt(mainIni.timechange.hours)
local timechange_minutes = imgui.ImInt(mainIni.timechange.minutes)
local timechange_weather = imgui.ImInt(mainIni.timechange.weather)
local timechange_toggle = imgui.ImBool(mainIni.timechange.toggle)

local lavka_color = imgui.ImInt(mainIni.lavka.color)
local lavka_name = imgui.ImBuffer(mainIni.lavka.name, 256)
local lavka_toggle = imgui.ImBool(mainIni.lavka.toggle)

local active_lavka = imgui.ImBool(mainIni.lavk.toggle)
local anti_stock = imgui.ImBool(mainIni.stock.toggle)

local autoreconnect_toggle = imgui.ImBool(mainIni.autoreconnect.toggle)
local autoreconnect_min = imgui.ImInt(mainIni.autoreconnect.min)
local autoreconnect_max = imgui.ImInt(mainIni.autoreconnect.max)
local autoreconnect_dont_reconnect = imgui.ImBool(mainIni.autoreconnect.dont_reconnect)
local autoreconnect_dont_reconnect_hour_first = imgui.ImInt(mainIni.autoreconnect.dont_reconnect_hour_first)
local autoreconnect_dont_reconnect_hour_second = imgui.ImInt(mainIni.autoreconnect.dont_reconnect_hour_second)

local lavki = {}

-------

local stata = false
local stats = {
}
local really = 0

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    ---------- Авто-Обновление ----------

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.update.vers) > script_vers then
                sampAddChatMessage(tag .. textcolor .. "Обнаружено обновление! Старая версия: " .. warncolor .. script_vers_text .. textcolor .. " Новая версия: " .. warncolor .. updateIni.update.vers_text, tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Начинаю установку обновления " .. warncolor .. updateIni.update.vers_text .. textcolor .. "..", tagcolor)
                update_status = true
            elseif tonumber(updateIni.update.vers) == script_vers then
                sampAddChatMessage(tag .. textcolor .. "Скрипт успешно загружен, обновлений не обнаружено!", tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Автор скрипта: " .. warncolor .. "Zenitrise" .. textcolor .. ".", tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Активация скрипта: " .. warncolor .. "/nhelp " .. textcolor, tagcolor)
            end
            os.remove(update_path)
        end
    end)
    
    ----------

    bind_main_window = rkeys.registerHotKey(main_window.v, true, main_window_activate)

    getLastUpdate()
    lua_thread.create(get_telegram_updates)

    sampRegisterChatCommand("nhelp", nhelp_cmd)
    sampRegisterChatCommand("open", box_open_now)
    sampRegisterChatCommand("kickme",function()
    -- sampRegisterChatCommand('vcon', vcon_cmd)
            
        setCharCoordinates(PLAYER_PED, 500, 500, 500)
    
    end)

    imgui.Process = false
    theme()
    while true do 
        wait(0)
        -- Поиск лавок

        if active_lavka.v then
            local lavki = 0
            for id = 0, 2304 do
                if sampIs3dTextDefined(id) then
                    local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(id)
                    if (math.floor(posZ) == 17 or math.floor(posZ) == 1820) and text == '' then
                        lavki = lavki + 1
                        if isPointOnScreen(posX, posY, posZ, nil) then
                            local pX, pY = convert3DCoordsToScreen(getCharCoordinates(PLAYER_PED))
                            local lX, lY = convert3DCoordsToScreen(posX, posY, posZ)
                            renderFontDrawText(font, 'Свободна', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
                            renderDrawLine(pX, pY, lX, lY, 1, 0xFF52FF4D)
                            renderDrawPolygon(pX, pY, 10, 10, 10, 0, 0xFFFFFFFF)
                            renderDrawPolygon(lX, lY, 10, 10, 10, 0, 0xFFFFFFFF)
                        end
                    end
                end
            end
            local input = sampGetInputInfoPtr()
            local input = getStructElement(input, 0x8, 4)
            local PosX = getStructElement(input, 0x8, 4)
            local PosY = getStructElement(input, 0xC, 4)
            renderFontDrawText(font, 'Свободно лавок: '..lavki, PosX, PosY + 80, 0xFFFFFFFF, 0x90000000)
        end
    



        --- сундуки
        if box_toggle.v and not work then
            work = true
            box_open()
        end


        if rlavka_toggle.v then
            MYPOS = {getCharCoordinates(PLAYER_PED)}
            for IDTEXT = 0, 2048 do
	            if sampIs3dTextDefined(IDTEXT) then
	                local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
					local dist = getDistanceBetweenCoords3d(MYPOS[1], MYPOS[2], MYPOS[3], posX, posY, posZ)
					--sampAddChatMessage(dist, -1)
					--local X, Y = convert3DCoordsToScreen(posX, posY, posZ)
					--renderFontDrawText(font, dist, X, Y, 0xFFFFFFFF)

	                if text:find('^%w+_%w+ .+ товар$') and dist <= rlavka_radius.v then
	                    local nick = text:match('^(%S+)')
	                    local id = -1
	                    for i = 1,1000 do
	                        if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == nick then
	                            id = i
	                            goto s
	                        end
	                    end
	                    ::s::
	                   -- drawCircleIn3d(posX, posY, MYPOS[3]-1.3, 5, 360, 3,("0x%x%06X"):format(200,bit.band(sampGetPlayerColor(id), 0xFFFFFF)))
                        radiusRend = rlavka_radius.v
                        local step = math.floor(360 / (360 or 36))
                        local sX_old, sY_old
                        for angle = 0, 360, step do
                            local lX = 5 * math.cos(math.rad(angle)) + posX
                            local lY = 5 * math.sin(math.rad(angle)) + posY
                            local lZ = MYPOS[3]-1.3
                            local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
                            if sZ > 1 then
                                if sX_old and sY_old then
                                    renderDrawLine(sX, sY, sX_old, sY_old, 3, ("0x%x%06X"):format(200,bit.band(sampGetPlayerColor(id), 0xFFFFFF)))
                                end
                                sX_old, sY_old = sX, sY
                            end
                        end
	                end
	            end
	        end
        end

        ----- Изменение времени
        if timechange_toggle.v then
            setTime()
            setWeather()
        end

        ---------- Авто-Обновление ----------

        if update_status then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage(tag .. textcolor .. "Скрипт успешно обновлен!", tagcolor)
                    thisScript():reload()
                end
            end)
            break
        end
    end
end

function tg_settings()
    imgui.SetNextWindowSize(imgui.ImVec2(435, 200), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

    imgui.Begin(u8"Настройки Telegram", tg_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)

    imgui.PushItemWidth(340)
    if imgui.InputText("Bot Token", token) then
        savecfg()
    end

    imgui.PushItemWidth(80)
    if imgui.InputText("User ID", chat_id) then
        savecfg()
    end
    if imgui.Button(u8"Проверить##66") then
        sampAddChatMessage(tag .. textcolor .. "Отправляю уведомление в " .. warncolor .. "Telegram" .. textcolor .. "..", tagcolor)
        sendTelegramNotification(tag .. "Я живой!")
    end
    imgui.Separator()
    imgui.Text(u8"Уведомления:")
    imgui.Separator()

    if imadd.ToggleButton("##66", tg_perevod) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Переводы")

    if imadd.ToggleButton("##62", tg_box) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Призы из сундуков")

    if imadd.ToggleButton("##63", tg_cr) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Покупка/Продажа на ЦР")

    if imadd.ToggleButton("##64", tg_disconnect) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Отключение от сервера")
    if imadd.ToggleButton("##65", tg_payday) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Pay Day")


    imgui.End()
end

function rlavka_settings()
    imgui.SetNextWindowSize(imgui.ImVec2(220, 70), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

    imgui.Begin(u8"Настройки rlavk`и", rlavka_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.BeginChild('##38282', imgui.ImVec2(205, 35), false)

    imgui.PushItemWidth(70)
    if imgui.SliderInt(u8'Радиус отображения', rlavka_radius, 5, 50) then
        savecfg()
    end

    imgui.EndChild()
    imgui.End()
end

function box_settings()
    imgui.SetNextWindowSize(imgui.ImVec2(320, 245), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

    imgui.Begin(u8"Настройки Авто-Открытия сундуков", box_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.BeginChild('##41', imgui.ImVec2(305, 210), false)

    if imadd.ToggleButton("##42", box_roulette) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Сундук рулетки")

    if imadd.ToggleButton("##43", box_platina) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Платиновый сундук")

    if imadd.ToggleButton("##44", box_donate) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Донатный сундук")

    if imadd.ToggleButton("##45", box_elonmusk) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Тайник Илона Маска")

    if imadd.ToggleButton("##46", box_lossantos) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Тайник Лос-Сантоса")

    if imadd.ToggleButton("##452123", box_vicecity) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Тайник Vice-City")
    imgui.Separator()

    imgui.PushItemWidth(100)
    if imgui.InputInt(u8"Минимальная задержка##47", box_open_delay_min) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Рандомная адержка между открытием инвентаря\nв минутах") 
    if imgui.InputInt(u8"Максимальная задержка##48", box_open_delay_max) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Рандомная адержка между открытием инвентаря\nв минутах")
    if imgui.InputInt(u8"Задержка между действиями##49", box_do_delay  ) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Задержка между действиями (открыть сундук, нажать кнопку\nзакрыть инвентарь), в секундах")

    imgui.EndChild()
    imgui.End()
end

function lavka_settings()
        imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Настройка Авто-Лавки", lavka_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##11', imgui.ImVec2(285, 365), false)

        imgui.PushItemWidth(150)
        if imgui.InputText(u8'Название лавки', lavka_name) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Название должно быть от 3 до 20 символов включительно.")
        if imgui.Button(u8'Проверить название##12') then
            local textvalue = #lavka_name.v
            if textvalue < 3 or textvalue > 20 then
                sampAddChatMessage(tag .. textcolor .. "Название должно быть от 3 до 20 символов включительно.", tagcolor)
                lavka_name.v = "N Helper"
            else
                sampAddChatMessage(tag .. textcolor .. "Все верно!", tagcolor)
            end
        end
        imgui.Separator()

        imgui.PushItemWidth(100)
        if imgui.Combo(u8'Выбор цвета##13', lavka_color, colors, #colors) then
            savecfg()
        end
        imgui.Separator()

        imgui.Text(u8'1 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.31, 0.31, 1), lavka_name.v)

        imgui.Text(u8'2 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.31, 0.75, 1), lavka_name.v)

        imgui.Text(u8'3 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.71, 0.31, 0.91, 1), lavka_name.v)

        imgui.Text(u8'4 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.4, 0.31, 0.91, 1), lavka_name.v)

        imgui.Text(u8'5 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.62, 0.91, 1), lavka_name.v)

        imgui.Text(u8'6 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.84, 0.91, 1), lavka_name.v)

        imgui.Text(u8'7 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.91, 0.64, 1), lavka_name.v)

        imgui.Text(u8'8 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.91, 0.38, 1), lavka_name.v)

        imgui.Text(u8'9 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.62, 0.91, 0.31, 1), lavka_name.v)

        imgui.Text(u8'10 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.82, 0.91, 0.31, 1), lavka_name.v)

        imgui.Text(u8'11 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.74, 0.31, 1), lavka_name.v)

        imgui.Text(u8'12 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.52, 0.31, 1), lavka_name.v)

        imgui.Text(u8'13 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.65, 0.19, 0.19, 1), lavka_name.v)

        imgui.Text(u8'14 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.19, 0.25, 0.65, 1), lavka_name.v)

        imgui.Text(u8'15 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.19, 0.65, 0.25, 1), lavka_name.v)

        imgui.Text(u8'16 цвет:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(1, 1, 1, 1), lavka_name.v)


        imgui.EndChild()
        imgui.End()
end

function imgui.OnDrawFrame()

    if not main_window_state.v and not con_window_state.v and not box_settings_window_state.v and not rlavka_settings_window_state.v and not lavka_settings_window_state.v and not addspawn_settings_window_state.v and not timechange_settings_window_state.v and not autoreconnect_settings_window_state.v then
        imgui.Process = false
    end

    if con_window_state.v then
       con()
    end

    if tg_settings_window_state.v then
        tg_settings()
    end

    if rlavka_settings_window_state.v then
        rlavka_settings()
    end

----- Настройки яшиков
    if box_settings_window_state.v then
        box_settings()
    end

    if not main_window_state.v then
        --con_window_state.v = false
        tg_settings_window_state.v = false
        box_settings_window_state.v = false
        lavka_settings_window_state.v = false
        rlavka_settings_window_state.v = false
        addspawn_settings_window_state.v = false
        timechange_settings_window_state.v = false
        autoreconnect_settings_window_state.v = false
    end

------------- Автовыбор спавна -----------
    if addspawn_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(230, 110), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Настройки выбора спавна", addspawn_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##18', imgui.ImVec2(215, 75), false)

        imgui.PushItemWidth(70)
        if imgui.InputInt(u8'Номер спавна', addspawn_id) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Номер места, где вам нужно заспавниться.\nНа пример, если нужно выбрать: [1] Вокзал\nто выбирайте цифру 1")
        imgui.Separator()
        if imadd.ToggleButton('##19', addspawn_waittoggle) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8"Задержка перед выбором")
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Задержка в секундах перед тем, как\nотправить ответ на диалог")
        imgui.PushItemWidth(50)
        if imgui.InputInt('', addspawn_wait, 0, 0) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8'секунд')


        imgui.EndChild()
        imgui.End()
    end



---------- Изменение времени и погоды --------------
    if timechange_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(210, 110), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Настройки времени и погоды", timechange_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##15', imgui.ImVec2(195, 75), false)

        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'Часы', timechange_hours, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'Минуты', timechange_minutes, 0, 59) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'Погода', timechange_weather, 0, 45) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"0 - 7 = несколько вариантов чистого синего неба\n08 = гроза\n09 = густой туман и пасмурно\n10 = ясное небо\n11 = дикое пекло\n12 - 15 = смуглая и неприятная погода\n16 = тусклая и дождливая\n17 - 18 = жара\n19 = песчаная буря\n20 = туманная погода\n21 = ночь с пурпурным небом\n22 = ночь с зеленоватым небом\n23 в 26 = изменения бледного апельсина\n27 в 29 = изменения свежий синие\n30 в 32 = изменения темного, неясного, чирка\n33 = вечер в коричневатых оттенках\n34 = погода с синими/пурпурными оттенками\n35 = тусклая и унылая погода в коричневых тонах\n36 в 38 = яркая и туманная погода в тонах апельсина\n39 = очень яркая погода\n40 в 42 = неясная погода в пурпурных/синих цветах\n43 = тёмные и едкие облака\n44 = чёрно-белое небо\n45 = пурпурное небо")



        imgui.EndChild()
        imgui.End()
    end



---------- Настройки Автореконнекта ----------
    if autoreconnect_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(290, 135), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Настройки Авто-Реконнекта", autoreconnect_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##4', imgui.ImVec2(275, 100), false)

        imgui.PushItemWidth(100)
        if imgui.InputInt(u8"Минимальная задержка", autoreconnect_min) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Указывается в секундах")

        imgui.PushItemWidth(100)
        if imgui.InputInt(u8"Максимальная задержка", autoreconnect_max) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Указывается в секундах")
        imgui.Separator()

        if imadd.ToggleButton('##5', autoreconnect_dont_reconnect) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8'Не переподключаться')
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Автоматическое переподключение не будет\nпроисходить в выбранный промежуток времени")

        imgui.Text(u8"От")
        imgui.SameLine()
        imgui.PushItemWidth(50)
        if imgui.SliderInt('##6', autoreconnect_dont_reconnect_hour_first, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.Text(u8"До")
        imgui.SameLine()
        imgui.PushItemWidth(50)
        if imgui.SliderInt('##7', autoreconnect_dont_reconnect_hour_second, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.Text(u8"часов.")
        imgui.EndChild()
        imgui.End()
    end


---------- Настройки Лавки ----------
    if lavka_settings_window_state.v then
        lavka_settings()
    end


---------- Основное окно ----------
    if main_window_state.v then
        renderDrawBox(0, 0, rx, ry, 0x50030303)

        imgui.SetNextWindowSize(imgui.ImVec2(375, 275), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin("N Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##1', imgui.ImVec2(100, 240), false)

        imgui.SetCursorPos(imgui.ImVec2(30, 10))
        imgui.Text(u8"Меню")
        imgui.SetCursorPosY(30)
        imgui.Separator()

        imgui.SetCursorPos(imgui.ImVec2(5, 40))
        if imgui.Button(fa.ICON_FA_ALIGN_JUSTIFY .. u8' Моды##20', imgui.ImVec2(90, 20)) then
            selected_window = 1
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 70))
        if imgui.Button(fa.ICON_FA_KEYBOARD .. u8' Бинды##21', imgui.ImVec2(90, 20)) then
            selected_window = 2
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 100))
        if imgui.Button(fa.ICON_FA_KEYBOARD .. u8' Команды##56', imgui.ImVec2(90, 20)) then
            selected_window = 3
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 130))
        if imgui.Button(fa.ICON_FA_ALIGN_JUSTIFY .. u8' AFK##73', imgui.ImVec2(90, 20)) then
            selected_window = 4
        end

        imgui.SetCursorPos(imgui.ImVec2(10, 195))
        imgui.Separator()
        imgui.Text(u8"Автор: Zenitrise")
        imgui.Text(u8"Версия: " .. script_vers_text)

        imgui.SetCursorPos(imgui.ImVec2(75, 215))
        if imgui.Button(fa.ICON_FA_SYNC_ALT , imgui.ImVec2(23, 20)) then
            showCursor(false)
            thisScript():reload()
        end

        imgui.EndChild()

        imgui.SameLine()

        ---------- Модификации ----------
        if selected_window == 1 then
            imgui.BeginChild('##2', imgui.ImVec2(255, 240), false) --------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!

            if imadd.ToggleButton("##8", lavka_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Авто-Лавка")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Автоматически выбирает цвет и название лавки")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##10") then
                lavka_settings_window_state.v = not lavka_settings_window_state.v
            end

            if imadd.ToggleButton("##14", timechange_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Изменение времени и погоды")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##15") then
                timechange_settings_window_state.v = not timechange_settings_window_state.v
            end

            if imadd.ToggleButton("##2281337", rlavka_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Радиус лавок")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##2281733") then
                rlavka_settings_window_state.v = not rlavka_settings_window_state.v 
            end

            if imadd.ToggleButton('##7326', active_lavka) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8'Поиск лавок')
            -----------
            -----------
            -------------
            -------------
            ------------


            imgui.EndChild()
        elseif selected_window == 2 then
            imgui.BeginChild('##22', imgui.ImVec2(255, 240), false)

            if imadd.ToggleButton("##24", hotkey_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Активация скрипта на клавишу")
            if imgui.HotKey("##23", main_window, _, 100) then
                rkeys.changeHotKey(bind_main_window, main_window.v)
                savecfg()
            end

            imgui.EndChild()
        elseif selected_window == 3 then
            imgui.BeginChild('##57', imgui.ImVec2(255, 240), false)
        
            imgui.Text("/vcon")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Подключение к выбранному серверу")

            imgui.EndChild()
        elseif selected_window == 4 then
            imgui.BeginChild('##74', imgui.ImVec2(255, 240), false)

            if imadd.ToggleButton("##3", autoreconnect_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Авто-Реконнект")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Автоматически переподключает вас к серверу, если\nвы были от него отключены. Можно выбрать рандомную задержку.")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##9 Настройки") then 
                autoreconnect_settings_window_state.v = not autoreconnect_settings_window_state.v
            end 

            if imadd.ToggleButton("##22312", anti_stock) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Анти-Диалог с акциями")
            
            if imadd.ToggleButton("##39", box_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Авто-Открытие сундуков")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##40") then
                box_settings_window_state.v = not box_settings_window_state.v
                savecfg()
            end

            if imadd.ToggleButton("##16", addspawn_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Авто выбор спавна")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Автоматический выбор спавна, если вы\nиграете с ADD-VIP")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##17") then
                addspawn_settings_window_state.v = not addspawn_settings_window_state.v
                savecfg()
            end
            
            if imadd.ToggleButton("##59", tg_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Уведомления в Telegram")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##60") then
                tg_settings_window_state.v = not tg_settings_window_state.v
                savecfg()
            end
            imgui.EndChild()
        end

        imgui.End()
    end
end
-- Для бинда
function main_window_activate()
    if hotkey_toggle.v then
        main_window_state.v = not main_window_state.v
        imgui.Process = main_window_state.v
        alpha()
    end
end
-- Изменение времени
function setTime()
    setTimeOfDay(timechange_hours.v, timechange_minutes.v)
end

-- Изменение погоды
function setWeather()
    local weather = tonumber(timechange_weather.v)
    forceWeatherNow(weather)
end

-- Основная команда
function nhelp_cmd()
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
    alpha()
end

function sampev.onServerMessage(color, text)
    if tg_toggle.v and tg_box.v then
        if text:match("Вы использовали") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_cr.v then
        if text:find("Вы купили") and color == -65281 then
            sendTelegramNotification(tag .. text)
        elseif text:find("купил у вас") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_perevod.v then
        if text:match("^Вам поступил перевод на ваш счет в размере $(%d+) от жителя (.-).%d+.") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_payday.v then
        if text == '__________________________________________________________________________' and color == 1941201407 then
            paydaytext = paydaytext..'\n'..text
            sendTelegramNotification('Прошел пейдей! Вот статистика за пейдей! \n' ..paydaytext)
            paydaytext = ''
            return {color, text}
        end
        
        if paydaytext ~= '' then
            paydaytext = paydaytext..'\n'..text
            return {color, text}
        end
        
        if text == '______________________________Банковский чек______________________________' and color == 1941201407 then
            paydaytext = paydaytext..'\n'..text
        end
    end
end




----- Авто лавка и автоспавн
function sampev.onShowDialog(id, style, title, b1, b2, text)
    if lavka_toggle.v then
        lua_thread.create(function()
            if id == 3021 then
                sampSendDialogResponse(3021, 1, 0)
            end
            wait (100)
            if id == 3020 then
                sampSendDialogResponse(3020, 1, _, lavka_name.v)
            end
            wait (100)
            if id == 3030 then
                sampSendDialogResponse(3030, 1, lavka_color.v)
            end
        end)
    end

    if anti_stock.v then
        if title:find("Акции на") then
            return false
        end
    end

    if id == 25527 then
        if addspawn_toggle.v then
            if addspawn_waittoggle.v then
                lua_thread.create(function()
                    local a = addspawn_id.v-1
                    time = addspawn_wait.v * 1000
                    wait(time)
                    sampAddChatMessage(tag .. textcolor .. "Выбираю " .. warncolor .. addspawn_id.v .. textcolor .. " пункт.", tagcolor)
                    sampSendDialogResponse(25527, 1, a, _)
                    sampCloseCurrentDialogWithButton(0)
                end)
            elseif not addspawn_waittoggle.v then 
                local a = addspawn_id.v-1
                sampSendDialogResponse(25527, 1, a, _)
                sampAddChatMessage(tag .. textcolor .. "Выбираю " .. warncolor .. addspawn_id.v .. textcolor .. " пункт.", tagcolor)
            end
        end
    end 

    lua_thread.create(function()
        if id == 235 then
            if stata then
                stats = {
                    "/stats",
                    "",
                    "=========================================",
                    ""
                }
                stata = false
                for line in text:gmatch("[^\n]+") do -- разбиваем чтобы искать по строкам
                    table.insert(stats, line)
                end
                wait(0)
                sampCloseCurrentDialogWithButton(0)
           end
        end
    end)
end

function sampev.onSetObjectMaterialText(id, data)
    
    if data.text:find('Номер %d+%. {......}Свободная!') then
        local object = sampGetObjectHandleBySampId(id) 
        table.insert(lavki, object)
    else
        local ob = sampGetObjectHandleBySampId(id)
        for i = 1, #lavki do
            if ob == lavki[i] then
                table.remove(lavki, i)
            end
        end
    end
end

function sampev.onDestroyObject(id)
    for k = 1, #lavki do
        local ob = sampGetObjectHandleBySampId(id)
        if ob == lavki[k] then
            table.remove(lavki, k)
        end
    end
end


------ Сохранение
function savecfg()
    cfg_part_1()
    cfg_part_2()

    inicfg.save(mainIni, directIni)

end

function cfg_part_1()
    mainIni.hotkey.main_window = encodeJson(main_window.v)
    mainIni.hotkey.toggle = hotkey_toggle.v

    mainIni.tg.toggle = tg_toggle.v
    mainIni.tg.token = token.v
    mainIni.tg.id = chat_id.v
    mainIni.tg.box = tg_box.v
    mainIni.tg.cr = tg_cr.v
    mainIni.tg.disconnect = tg_disconnect.v
    mainIni.tg.perevod = tg_perevod.v
    mainIni.tg.payday = tg_payday.v

    mainIni.box.toggle = box_toggle.v
    mainIni.box.roulette = box_roulette.v
    mainIni.box.platina = box_platina.v
    mainIni.box.donate = box_donate.v
    mainIni.box.elonmusk = box_elonmusk.v
    mainIni.box.lossantos = box_lossantos.v
    mainIni.box.vicecity = box_vicecity.v
    mainIni.box.do_delay = box_do_delay.v
    mainIni.box.open_delay_min = box_open_delay_min.v
    mainIni.box.open_delay_max = box_open_delay_max.v

end

function cfg_part_2()
    mainIni.addspawn.toggle = addspawn_toggle.v
    mainIni.addspawn.waittoggle = addspawn_waittoggle.v
    mainIni.addspawn.id = addspawn_id.v
    mainIni.addspawn.wait = addspawn_wait.v

    mainIni.timechange.hours = timechange_hours.v
    mainIni.timechange.minutes = timechange_minutes.v
    mainIni.timechange.weather = timechange_weather.v
    mainIni.timechange.toggle = timechange_toggle.v

    mainIni.lavka.toggle = lavka_toggle.v
    mainIni.lavka.name = lavka_name.v
    mainIni.lavka.color = lavka_color.v

    mainIni.autoreconnect.toggle = autoreconnect_toggle.v
    mainIni.autoreconnect.min = autoreconnect_min.v
    mainIni.autoreconnect.max = autoreconnect_max.v
    mainIni.autoreconnect.dont_reconnect = autoreconnect_dont_reconnect.v
    mainIni.autoreconnect.dont_reconnect_hour_first = autoreconnect_dont_reconnect_hour_first.v
    mainIni.autoreconnect.dont_reconnect_hour_second = autoreconnect_dont_reconnect_hour_second.v

    mainIni.lavk.toggle = active_lavka.v
    mainIni.stock.toggle = anti_stock.v

    mainIni.rlavka.toggle = rlavka_toggle.v
    mainIni.rlavka.radius = rlavka_radius.v
end

function onReceivePacket(id)
    if (id == 32 or id == 37) and tg_disconnect.v then 
        sendTelegramNotification("Вы были отключены от сервера!")
    end
    
    if (id == 32 or id == 37) and autoreconnect_toggle.v then
        lua_thread.create(function()
            local ip, port = sampGetCurrentServerAddress()
            math.randomseed(os.clock())
            local a = math.random(autoreconnect_min.v, autoreconnect_max.v)
            sampAddChatMessage(tag .. textcolor .. 'Задержка на подключение: '.. warncolor .. a .. textcolor .. ' секунд.', tagcolor)
            wait(a * 1000)

            local canreconnecthr = true
            local hrs = tonumber(os.date("%H"))
            if autoreconnect_dont_reconnect.v then
                if hrs >= autoreconnect_dont_reconnect_hour_first.v and hrs <= autoreconnect_dont_reconnect_hour_second.v then
                    canreconnecthr = false
                end
            end

            if (id == 32 or id == 37) and canreconnecthr then
                ip,port = sampGetCurrentServerAddress()
                sampConnectToServer(ip, port)
            else
                sampAddChatMessage(tag .. textcolor .. "Нельзя в это время!", tagcolor)
            end
        end)
    end
end

function onWindowMessage(msg, wparam, lparam)
    if msg == 0x100 or msg == 0x101 then
        if wparam == VK_ESCAPE and main_window_state.v and not isPauseMenuActive() then
            consumeWindowMessage(true, false)
            if msg == 0x101 then dialogenable = false end
            main_window_state = imgui.ImBool(false)
        end
    end
end
--------------------------- T E L E G R A M ----------------------


function threadHandle(runner, url, args, resolve, reject)
    local t = runner(url, args)
    local r = t:get(0)
    while not r do
        r = t:get(0)
        wait(0)
    end
    local status = t:status()
    if status == 'completed' then
        local ok, result = r[1], r[2]
        if ok then resolve(result) else reject(result) end
    elseif err then
        reject(err)
    elseif status == 'canceled' then
        reject(status)
    end
    t:cancel(0)
end

function requestRunner()
    return effil.thread(function(u, a)
        local https = require 'ssl.https'
        local ok, result = pcall(https.request, u, a)
        if ok then
            return {true, result}
        else
            return {false, result}
        end
    end)
end

function async_http_request(url, args, resolve, reject)
    local runner = requestRunner()
    if not reject then reject = function() end end
    lua_thread.create(function()
        threadHandle(runner, url, args, resolve, reject)
    end)
end

function encodeUrl(str)
    str = str:gsub(' ', '%+')
    str = str:gsub('\n', '%%0A')
    return u8:encode(str, 'CP1251')
end

function sendTelegramNotification(msg) -- функция для отправки сообщения юзеру
    msg = msg:gsub('{......}', '') --тут типо убираем цвет
    msg = encodeUrl(msg) -- ну тут мы закодируем строку
    async_http_request('https://api.telegram.org/bot' .. token.v .. '/sendMessage?chat_id=' .. chat_id.v .. '&text='..msg,'', function(result) end) -- а тут уже отправка
end

function get_telegram_updates() -- функция получения сообщений от юзера
    while not updateid do wait(1) end -- ждем пока не узнаем последний ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..token.v ..'/getUpdates?chat_id='..chat_id.v ..'&offset=-1' -- создаем ссылку
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function processing_telegram_messages(result) -- функция проверОчки того что отправил чел
    if result then
        local proc_table = decodeJson(result)
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
                        if message_from_user then
                            -- и тут если чел отправил текст мы сверяем
                            local text = u8:decode(message_from_user) .. ' ' --добавляем в конец пробел дабы не произошли тех. шоколадки с командами(типо чтоб !q не считалось как !qq)
                            if text:match("^/help") then
                                local arr = {
                                    'Список команд:',
                                    "",
                                    '/rec  -->  Переподключиться к серверу',
                                    "",
                                    "/help  -->  Помощь по командам",
                                    "",
                                    "/off  -->  Выключить компьютер",
                                    "",
                                    "/stats  -->  Статистика со /stats",
                                    "",
                                    "/reload  -->  Перезагрузить скрипт",
                                    "",
                                    "/unload  -->  Отключить скрипт"
                                }
                                sendTelegramNotification(table.concat(arr, "\n"))
                            elseif text:match("^/rec") then
                                sendTelegramNotification(tag .. "Переподключение к серверу..")
                                lua_thread.create(function()
                                    sampSetGamestate(5)
                                    delay = 0
                                    local ip, port = sampGetCurrentServerAddress()
                                    sampAddChatMessage(tag .. textcolor .. 'Задержка: '.. warncolor .. delay .. textcolor ..' сек.', tagcolor)
                                    wait(delay * 1000)
                                    sampConnectToServer(ip, port)
                                end)
                            elseif text:match("^/stats") then
                                stata = true
                                sampSendChat("/stats")
                                wait(100)
                                table.insert(stats, "")
                                table.insert(stats, "=========================================")
                                wait(100)
                                sendTelegramNotification(table.concat(stats, "\n"))
                            elseif text:match("^/off") then
                                really = 1
                                sendTelegramNotification(tag .. "Вы серьезно ходите выключить компьютер? Если да, то введите: /shutdown_my_pc\nЕсли вы передумали, то введите любую команду.")
                            elseif text:match("^/shutdown_my_pc") then
                                if really == 1 then
                                    sendTelegramNotification(tag .. 'Выключаю компьютер через 5 секунд..')
                                    wait(5000)
                                    os.execute('shutdown -s -t 0')
                                else 
                                    sendTelegramNotification(tag .. 'Неизвестная команда! Введите /help')
                                end

                            elseif text:match("^/unload") then
                                sendTelegramNotification(tag .. "Скрипт был успешно выгружен!")
                                thisScript():unload()
                            elseif text:match("^/reload") then
                                sendTelegramNotification(tag .. "Скрипт был успешно перезагружен!")
                                thisScript():reload()
                            else -- если же не найдется ни одна из команд выше, выведем сообщение
                                really = 0
                                sendTelegramNotification(tag .. 'Неизвестная команда! Введите /help')
                            end
                        end
                    end
                end
            end
        end
    end
end

function getLastUpdate() -- тут мы получаем последний ID сообщения, если же у вас в коде будет настройка токена и chat_id, вызовите эту функцию для того чтоб получить последнее сообщение
    async_http_request('https://api.telegram.org/bot'..token.v ..'/getUpdates?chat_id='..chat_id.v ..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1 -- тут зададим значение 1, если таблица будет пустая
                end
            end
        end
    end)
end


------------------------------------------------------------------


function box_open_now()
    lua_thread.create(function()
        math.randomseed(os.time())
        local do_delay = box_do_delay.v * 1000
        sampCloseCurrentDialogWithButton(0)
        sampSendClickTextdraw(65535)
        if box_toggle.v then
            sampSendChat("/stats")
            wait(do_delay)
            sampCloseCurrentDialogWithButton(0)
            wait(do_delay)
            sampSendClickTextdraw(65535)
            wait(do_delay)
            sampSendChat("/invent")
            wait(do_delay)
    
    
            if box_donate.v then
                sampSendClickTextdraw(box_donate_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end
    
            if box_elonmusk.v then
                sampSendClickTextdraw(box_elonmusk_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end
    
            if box_lossantos.v then
                sampSendClickTextdraw(box_lossantos_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end
    
            if box_platina.v then
                sampSendClickTextdraw(box_platina_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end
    
            if box_roulette.v then
                sampSendClickTextdraw(box_roulette_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end

            if box_vicecity.v then
                sampSendClickTextdraw(box_vc_tid)
                wait(do_delay)
                sampSendClickTextdraw(2302)
                wait(do_delay)
            end
            sampSendClickTextdraw(65535)
            work = false
        else 
            work = false
        end
    end)
end


function box_open()
    lua_thread.create(function()
        math.randomseed(os.time())
        local open_delay = math.random(box_open_delay_min.v, box_open_delay_max.v) * 1000 * 60
        local do_delay = box_do_delay.v * 1000

        wait(open_delay)

        box_open_now()
    end)
end

function sampev.onSetPlayerDrunk(drunkLevel)
    return {1}
end

function sampev.onShowTextDraw(id, data)
    if data.modelId == 19918 then
        box_roulette_tid = id 
    elseif data.modelId == 19613 then
        box_donate_tid = id
    elseif data.modelId == 1353 then
        box_platina_tid = id
    elseif data.modelId == 1733 then
        box_elonmusk_tid = id
    elseif data.modelId == 2887 then
        box_lossantos_tid = id
    elseif data.modelId == 1333 then
        box_vc_tid = id
    end    
end

-- Альфа
function alpha()
    lua_thread.create(function()
        if falpha > 0 then
            falpha = 0
        end
        while falpha >= 0 and falpha <= 1 do
            falpha = falpha + 0.02
            wait(10)
            theme()
        end
        theme()
    end)
end

-- Тема
function theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.Alpha = falpha
    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 5
    style.ChildWindowRounding = 4
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
    colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
    colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
    colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
    colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
    colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
    colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
    colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
    colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.00, 0.90, 0.50, 1.00)
    colors[clr.CloseButtonHovered]     = ImVec4(0.00, 0.88, 0.42, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.17, 0.17, 0.17, 0.48)
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end
