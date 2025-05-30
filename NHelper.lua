script_name("N Helper")
script_author("zenitrise")

---------- Ïåðìåííûå äëÿ òåêñòà -----------

local tag = "[N Helper] "
local tagcolor = 0x20f271
local textcolor = "{DCDCDC}"
local warncolor = "{9c9c9c}"

local paydaytext = ''
---------- Àâòî-Îáíîâëåíèå ----------

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
----------- Ïîäãðóçêà áèáëèîòåê è äåðèêòîðèé ---------

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
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "Font Awesome 5 " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(font_path) then
    downloadUrlToFile(font_url, font_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíû øðèôòû äëÿ áèáëèîòåêè " .. warncolor .. "Font Awesome 5 " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(encoding_path) then
    downloadUrlToFile(encoding_url, encoding_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "Encoding " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(vkeys_path) then
    downloadUrlToFile(vkeys_url, vkeys_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "VKeys " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(imgui_path) then
    downloadUrlToFile(imgui_url, imgui_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "ImGui " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(imguiadd_path) then
    downloadUrlToFile(imguiadd_url, imguiadd_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "ImGui Addons " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if not doesFileExist(rkeys_path) then
    downloadUrlToFile(rkeys_url, rkeys_path)
    sampAddChatMessage(tag .. textcolor .. "Ó âàñ íå çàãðóæåíà áèáëèîòåêà " .. warncolor .. "RKeys " .. textcolor .. "Íà÷èíàþ çàãðóçêó..", tagcolor)
    download_lib = true
end

if download_lib then
    thisScript():reload()
end

--------------------
---------- Áèáëèîòåêè ----------

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

---------- Ïîäãðóçêà, íàñòðîéêà .ini ----------

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



---------- Ïåðåìåííûå, ìàññèâû ----------

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
local token = imgui.ImBuffer(mainIni.tg.token, 512) -- òîêåí áîòà
local chat_id = imgui.ImBuffer(tostring(mainIni.tg.id), 512)
local updateid -- ID ïîñëåäíåãî ñîîáùåíèÿ äëÿ òîãî ÷òîáû íå áûëî ôëóäà
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

    ---------- Àâòî-Îáíîâëåíèå ----------

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.update.vers) > script_vers then
                sampAddChatMessage(tag .. textcolor .. "Îáíàðóæåíî îáíîâëåíèå! Ñòàðàÿ âåðñèÿ: " .. warncolor .. script_vers_text .. textcolor .. " Íîâàÿ âåðñèÿ: " .. warncolor .. updateIni.update.vers_text, tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Íà÷èíàþ óñòàíîâêó îáíîâëåíèÿ " .. warncolor .. updateIni.update.vers_text .. textcolor .. "..", tagcolor)
                update_status = true
            elseif tonumber(updateIni.update.vers) == script_vers then
                sampAddChatMessage(tag .. textcolor .. "Ñêðèïò óñïåøíî çàãðóæåí, îáíîâëåíèé íå îáíàðóæåíî!", tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Àâòîð ñêðèïòà: " .. warncolor .. "Zenitrise" .. textcolor .. ".", tagcolor)
                sampAddChatMessage(tag .. textcolor .. "Àêòèâàöèÿ ñêðèïòà: " .. warncolor .. "/nhelp " .. textcolor, tagcolor)
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
        -- Ïîèñê ëàâîê

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
                            renderFontDrawText(font, 'Ñâîáîäíà', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
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
            renderFontDrawText(font, 'Ñâîáîäíî ëàâîê: '..lavki, PosX, PosY + 80, 0xFFFFFFFF, 0x90000000)
        end
    



        --- ñóíäóêè
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

	                if text:find('^%w+_%w+ .+ òîâàð$') and dist <= rlavka_radius.v then
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

        ----- Èçìåíåíèå âðåìåíè
        if timechange_toggle.v then
            setTime()
            setWeather()
        end

        ---------- Àâòî-Îáíîâëåíèå ----------

        if update_status then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage(tag .. textcolor .. "Ñêðèïò óñïåøíî îáíîâëåí!", tagcolor)
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

    imgui.Begin(u8"Íàñòðîéêè Telegram", tg_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)

    imgui.PushItemWidth(340)
    if imgui.InputText("Bot Token", token) then
        savecfg()
    end

    imgui.PushItemWidth(80)
    if imgui.InputText("User ID", chat_id) then
        savecfg()
    end
    if imgui.Button(u8"Ïðîâåðèòü##66") then
        sampAddChatMessage(tag .. textcolor .. "Îòïðàâëÿþ óâåäîìëåíèå â " .. warncolor .. "Telegram" .. textcolor .. "..", tagcolor)
        sendTelegramNotification(tag .. "ß æèâîé!")
    end
    imgui.Separator()
    imgui.Text(u8"Óâåäîìëåíèÿ:")
    imgui.Separator()

    if imadd.ToggleButton("##66", tg_perevod) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Ïåðåâîäû")

    if imadd.ToggleButton("##62", tg_box) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Ïðèçû èç ñóíäóêîâ")

    if imadd.ToggleButton("##63", tg_cr) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Ïîêóïêà/Ïðîäàæà íà ÖÐ")

    if imadd.ToggleButton("##64", tg_disconnect) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Îòêëþ÷åíèå îò ñåðâåðà")
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

    imgui.Begin(u8"Íàñòðîéêè rlavk`è", rlavka_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.BeginChild('##38282', imgui.ImVec2(205, 35), false)

    imgui.PushItemWidth(70)
    if imgui.SliderInt(u8'Ðàäèóñ îòîáðàæåíèÿ', rlavka_radius, 5, 50) then
        savecfg()
    end

    imgui.EndChild()
    imgui.End()
end

function box_settings()
    imgui.SetNextWindowSize(imgui.ImVec2(320, 245), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

    imgui.Begin(u8"Íàñòðîéêè Àâòî-Îòêðûòèÿ ñóíäóêîâ", box_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    imgui.BeginChild('##41', imgui.ImVec2(305, 210), false)

    if imadd.ToggleButton("##42", box_roulette) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Ñóíäóê ðóëåòêè")

    if imadd.ToggleButton("##43", box_platina) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Ïëàòèíîâûé ñóíäóê")

    if imadd.ToggleButton("##44", box_donate) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Äîíàòíûé ñóíäóê")

    if imadd.ToggleButton("##45", box_elonmusk) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Òàéíèê Èëîíà Ìàñêà")

    if imadd.ToggleButton("##46", box_lossantos) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Òàéíèê Ëîñ-Ñàíòîñà")

    if imadd.ToggleButton("##452123", box_vicecity) then
        savecfg()
    end
    imgui.SameLine()
    imgui.Text(u8"Òàéíèê Vice-City")
    imgui.Separator()

    imgui.PushItemWidth(100)
    if imgui.InputInt(u8"Ìèíèìàëüíàÿ çàäåðæêà##47", box_open_delay_min) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Ðàíäîìíàÿ àäåðæêà ìåæäó îòêðûòèåì èíâåíòàðÿ\nâ ìèíóòàõ") 
    if imgui.InputInt(u8"Ìàêñèìàëüíàÿ çàäåðæêà##48", box_open_delay_max) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Ðàíäîìíàÿ àäåðæêà ìåæäó îòêðûòèåì èíâåíòàðÿ\nâ ìèíóòàõ")
    if imgui.InputInt(u8"Çàäåðæêà ìåæäó äåéñòâèÿìè##49", box_do_delay  ) then
        savecfg()
    end
    imgui.SameLine()
    imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Çàäåðæêà ìåæäó äåéñòâèÿìè (îòêðûòü ñóíäóê, íàæàòü êíîïêó\nçàêðûòü èíâåíòàðü), â ñåêóíäàõ")

    imgui.EndChild()
    imgui.End()
end

function lavka_settings()
        imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Íàñòðîéêà Àâòî-Ëàâêè", lavka_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##11', imgui.ImVec2(285, 365), false)

        imgui.PushItemWidth(150)
        if imgui.InputText(u8'Íàçâàíèå ëàâêè', lavka_name) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Íàçâàíèå äîëæíî áûòü îò 3 äî 20 ñèìâîëîâ âêëþ÷èòåëüíî.")
        if imgui.Button(u8'Ïðîâåðèòü íàçâàíèå##12') then
            local textvalue = #lavka_name.v
            if textvalue < 3 or textvalue > 20 then
                sampAddChatMessage(tag .. textcolor .. "Íàçâàíèå äîëæíî áûòü îò 3 äî 20 ñèìâîëîâ âêëþ÷èòåëüíî.", tagcolor)
                lavka_name.v = "N Helper"
            else
                sampAddChatMessage(tag .. textcolor .. "Âñå âåðíî!", tagcolor)
            end
        end
        imgui.Separator()

        imgui.PushItemWidth(100)
        if imgui.Combo(u8'Âûáîð öâåòà##13', lavka_color, colors, #colors) then
            savecfg()
        end
        imgui.Separator()

        imgui.Text(u8'1 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.31, 0.31, 1), lavka_name.v)

        imgui.Text(u8'2 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.31, 0.75, 1), lavka_name.v)

        imgui.Text(u8'3 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.71, 0.31, 0.91, 1), lavka_name.v)

        imgui.Text(u8'4 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.4, 0.31, 0.91, 1), lavka_name.v)

        imgui.Text(u8'5 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.62, 0.91, 1), lavka_name.v)

        imgui.Text(u8'6 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.84, 0.91, 1), lavka_name.v)

        imgui.Text(u8'7 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.91, 0.64, 1), lavka_name.v)

        imgui.Text(u8'8 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.31, 0.91, 0.38, 1), lavka_name.v)

        imgui.Text(u8'9 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.62, 0.91, 0.31, 1), lavka_name.v)

        imgui.Text(u8'10 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.82, 0.91, 0.31, 1), lavka_name.v)

        imgui.Text(u8'11 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.74, 0.31, 1), lavka_name.v)

        imgui.Text(u8'12 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.91, 0.52, 0.31, 1), lavka_name.v)

        imgui.Text(u8'13 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.65, 0.19, 0.19, 1), lavka_name.v)

        imgui.Text(u8'14 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.19, 0.25, 0.65, 1), lavka_name.v)

        imgui.Text(u8'15 öâåò:') 
        imgui.SameLine()
        imgui.TextColored(imgui.ImVec4(0.19, 0.65, 0.25, 1), lavka_name.v)

        imgui.Text(u8'16 öâåò:') 
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

----- Íàñòðîéêè ÿøèêîâ
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

------------- Àâòîâûáîð ñïàâíà -----------
    if addspawn_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(230, 110), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Íàñòðîéêè âûáîðà ñïàâíà", addspawn_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##18', imgui.ImVec2(215, 75), false)

        imgui.PushItemWidth(70)
        if imgui.InputInt(u8'Íîìåð ñïàâíà', addspawn_id) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Íîìåð ìåñòà, ãäå âàì íóæíî çàñïàâíèòüñÿ.\nÍà ïðèìåð, åñëè íóæíî âûáðàòü: [1] Âîêçàë\nòî âûáèðàéòå öèôðó 1")
        imgui.Separator()
        if imadd.ToggleButton('##19', addspawn_waittoggle) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8"Çàäåðæêà ïåðåä âûáîðîì")
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Çàäåðæêà â ñåêóíäàõ ïåðåä òåì, êàê\nîòïðàâèòü îòâåò íà äèàëîã")
        imgui.PushItemWidth(50)
        if imgui.InputInt('', addspawn_wait, 0, 0) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8'ñåêóíä')


        imgui.EndChild()
        imgui.End()
    end



---------- Èçìåíåíèå âðåìåíè è ïîãîäû --------------
    if timechange_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(210, 110), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Íàñòðîéêè âðåìåíè è ïîãîäû", timechange_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##15', imgui.ImVec2(195, 75), false)

        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'×àñû', timechange_hours, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'Ìèíóòû', timechange_minutes, 0, 59) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.PushItemWidth(100)
        if imgui.SliderInt(u8'Ïîãîäà', timechange_weather, 0, 45) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"0 - 7 = íåñêîëüêî âàðèàíòîâ ÷èñòîãî ñèíåãî íåáà\n08 = ãðîçà\n09 = ãóñòîé òóìàí è ïàñìóðíî\n10 = ÿñíîå íåáî\n11 = äèêîå ïåêëî\n12 - 15 = ñìóãëàÿ è íåïðèÿòíàÿ ïîãîäà\n16 = òóñêëàÿ è äîæäëèâàÿ\n17 - 18 = æàðà\n19 = ïåñ÷àíàÿ áóðÿ\n20 = òóìàííàÿ ïîãîäà\n21 = íî÷ü ñ ïóðïóðíûì íåáîì\n22 = íî÷ü ñ çåëåíîâàòûì íåáîì\n23 â 26 = èçìåíåíèÿ áëåäíîãî àïåëüñèíà\n27 â 29 = èçìåíåíèÿ ñâåæèé ñèíèå\n30 â 32 = èçìåíåíèÿ òåìíîãî, íåÿñíîãî, ÷èðêà\n33 = âå÷åð â êîðè÷íåâàòûõ îòòåíêàõ\n34 = ïîãîäà ñ ñèíèìè/ïóðïóðíûìè îòòåíêàìè\n35 = òóñêëàÿ è óíûëàÿ ïîãîäà â êîðè÷íåâûõ òîíàõ\n36 â 38 = ÿðêàÿ è òóìàííàÿ ïîãîäà â òîíàõ àïåëüñèíà\n39 = î÷åíü ÿðêàÿ ïîãîäà\n40 â 42 = íåÿñíàÿ ïîãîäà â ïóðïóðíûõ/ñèíèõ öâåòàõ\n43 = ò¸ìíûå è åäêèå îáëàêà\n44 = ÷¸ðíî-áåëîå íåáî\n45 = ïóðïóðíîå íåáî")



        imgui.EndChild()
        imgui.End()
    end



---------- Íàñòðîéêè Àâòîðåêîííåêòà ----------
    if autoreconnect_settings_window_state.v then
        imgui.SetNextWindowSize(imgui.ImVec2(290, 135), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8"Íàñòðîéêè Àâòî-Ðåêîííåêòà", autoreconnect_settings_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##4', imgui.ImVec2(275, 100), false)

        imgui.PushItemWidth(100)
        if imgui.InputInt(u8"Ìèíèìàëüíàÿ çàäåðæêà", autoreconnect_min) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Óêàçûâàåòñÿ â ñåêóíäàõ")

        imgui.PushItemWidth(100)
        if imgui.InputInt(u8"Ìàêñèìàëüíàÿ çàäåðæêà", autoreconnect_max) then
            savecfg()
        end
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Óêàçûâàåòñÿ â ñåêóíäàõ")
        imgui.Separator()

        if imadd.ToggleButton('##5', autoreconnect_dont_reconnect) then
            savecfg()
        end
        imgui.SameLine()
        imgui.Text(u8'Íå ïåðåïîäêëþ÷àòüñÿ')
        imgui.SameLine()
        imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Àâòîìàòè÷åñêîå ïåðåïîäêëþ÷åíèå íå áóäåò\nïðîèñõîäèòü â âûáðàííûé ïðîìåæóòîê âðåìåíè")

        imgui.Text(u8"Îò")
        imgui.SameLine()
        imgui.PushItemWidth(50)
        if imgui.SliderInt('##6', autoreconnect_dont_reconnect_hour_first, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.Text(u8"Äî")
        imgui.SameLine()
        imgui.PushItemWidth(50)
        if imgui.SliderInt('##7', autoreconnect_dont_reconnect_hour_second, 0, 23) then
            savecfg()
        end
        imgui.PopItemWidth()
        imgui.SameLine()
        imgui.Text(u8"÷àñîâ.")
        imgui.EndChild()
        imgui.End()
    end


---------- Íàñòðîéêè Ëàâêè ----------
    if lavka_settings_window_state.v then
        lavka_settings()
    end


---------- Îñíîâíîå îêíî ----------
    if main_window_state.v then
        renderDrawBox(0, 0, rx, ry, 0x50030303)

        imgui.SetNextWindowSize(imgui.ImVec2(375, 275), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(rx / 2, ry / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin("N Helper", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##1', imgui.ImVec2(100, 240), false)

        imgui.SetCursorPos(imgui.ImVec2(30, 10))
        imgui.Text(u8"Ìåíþ")
        imgui.SetCursorPosY(30)
        imgui.Separator()

        imgui.SetCursorPos(imgui.ImVec2(5, 40))
        if imgui.Button(fa.ICON_FA_ALIGN_JUSTIFY .. u8' Ìîäû##20', imgui.ImVec2(90, 20)) then
            selected_window = 1
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 70))
        if imgui.Button(fa.ICON_FA_KEYBOARD .. u8' Áèíäû##21', imgui.ImVec2(90, 20)) then
            selected_window = 2
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 100))
        if imgui.Button(fa.ICON_FA_KEYBOARD .. u8' Êîìàíäû##56', imgui.ImVec2(90, 20)) then
            selected_window = 3
        end

        imgui.SetCursorPos(imgui.ImVec2(5, 130))
        if imgui.Button(fa.ICON_FA_ALIGN_JUSTIFY .. u8' AFK##73', imgui.ImVec2(90, 20)) then
            selected_window = 4
        end

        imgui.SetCursorPos(imgui.ImVec2(10, 195))
        imgui.Separator()
        imgui.Text(u8"Àâòîð: Zenitrise")
        imgui.Text(u8"Âåðñèÿ: " .. script_vers_text)

        imgui.SetCursorPos(imgui.ImVec2(75, 215))
        if imgui.Button(fa.ICON_FA_SYNC_ALT , imgui.ImVec2(23, 20)) then
            showCursor(false)
            thisScript():reload()
        end

        imgui.EndChild()

        imgui.SameLine()

        ---------- Ìîäèôèêàöèè ----------
        if selected_window == 1 then
            imgui.BeginChild('##2', imgui.ImVec2(255, 240), false) --------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!

            if imadd.ToggleButton("##8", lavka_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Àâòî-Ëàâêà")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Àâòîìàòè÷åñêè âûáèðàåò öâåò è íàçâàíèå ëàâêè")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##10") then
                lavka_settings_window_state.v = not lavka_settings_window_state.v
            end

            if imadd.ToggleButton("##14", timechange_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Èçìåíåíèå âðåìåíè è ïîãîäû")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##15") then
                timechange_settings_window_state.v = not timechange_settings_window_state.v
            end

            if imadd.ToggleButton("##2281337", rlavka_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Ðàäèóñ ëàâîê")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##2281733") then
                rlavka_settings_window_state.v = not rlavka_settings_window_state.v 
            end

            if imadd.ToggleButton('##7326', active_lavka) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8'Ïîèñê ëàâîê')
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
            imgui.Text(u8"Àêòèâàöèÿ ñêðèïòà íà êëàâèøó")
            if imgui.HotKey("##23", main_window, _, 100) then
                rkeys.changeHotKey(bind_main_window, main_window.v)
                savecfg()
            end

            imgui.EndChild()
        elseif selected_window == 3 then
            imgui.BeginChild('##57', imgui.ImVec2(255, 240), false)
        
            imgui.Text("/vcon")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Ïîäêëþ÷åíèå ê âûáðàííîìó ñåðâåðó")

            imgui.EndChild()
        elseif selected_window == 4 then
            imgui.BeginChild('##74', imgui.ImVec2(255, 240), false)

            if imadd.ToggleButton("##3", autoreconnect_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Àâòî-Ðåêîííåêò")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Àâòîìàòè÷åñêè ïåðåïîäêëþ÷àåò âàñ ê ñåðâåðó, åñëè\nâû áûëè îò íåãî îòêëþ÷åíû. Ìîæíî âûáðàòü ðàíäîìíóþ çàäåðæêó.")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##9 Íàñòðîéêè") then 
                autoreconnect_settings_window_state.v = not autoreconnect_settings_window_state.v
            end 

            if imadd.ToggleButton("##22312", anti_stock) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Àíòè-Äèàëîã ñ àêöèÿìè")
            
            if imadd.ToggleButton("##39", box_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Àâòî-Îòêðûòèå ñóíäóêîâ")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##40") then
                box_settings_window_state.v = not box_settings_window_state.v
                savecfg()
            end

            if imadd.ToggleButton("##16", addspawn_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Àâòî âûáîð ñïàâíà")
            imgui.SameLine()
            imgui.TextQuestion(fa.ICON_FA_QUESTION_CIRCLE, u8"Àâòîìàòè÷åñêèé âûáîð ñïàâíà, åñëè âû\nèãðàåòå ñ ADD-VIP")
            imgui.SameLine()
            if imgui.Button(fa.ICON_FA_COGS .. "##17") then
                addspawn_settings_window_state.v = not addspawn_settings_window_state.v
                savecfg()
            end
            
            if imadd.ToggleButton("##59", tg_toggle) then
                savecfg()
            end
            imgui.SameLine()
            imgui.Text(u8"Óâåäîìëåíèÿ â Telegram")
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
-- Äëÿ áèíäà
function main_window_activate()
    if hotkey_toggle.v then
        main_window_state.v = not main_window_state.v
        imgui.Process = main_window_state.v
        alpha()
    end
end
-- Èçìåíåíèå âðåìåíè
function setTime()
    setTimeOfDay(timechange_hours.v, timechange_minutes.v)
end

-- Èçìåíåíèå ïîãîäû
function setWeather()
    local weather = tonumber(timechange_weather.v)
    forceWeatherNow(weather)
end

-- Îñíîâíàÿ êîìàíäà
function nhelp_cmd()
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
    alpha()
end

function sampev.onServerMessage(color, text)
    if tg_toggle.v and tg_box.v then
        if text:match("Âû èñïîëüçîâàëè") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_cr.v then
        if text:find("Âû êóïèëè") and color == -65281 then
            sendTelegramNotification(tag .. text)
        elseif text:find("êóïèë ó âàñ") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_perevod.v then
        if text:match("^Âàì ïîñòóïèë ïåðåâîä íà âàø ñ÷åò â ðàçìåðå $(%d+) îò æèòåëÿ (.-).%d+.") and color == -65281 then
            sendTelegramNotification(tag .. text)
        end
    end

    if tg_toggle.v and tg_payday.v then
        if text == '__________________________________________________________________________' and color == 1941201407 then
            paydaytext = paydaytext..'\n'..text
            sendTelegramNotification('Ïðîøåë ïåéäåé! Âîò ñòàòèñòèêà çà ïåéäåé! \n' ..paydaytext)
            paydaytext = ''
            return {color, text}
        end
        
        if paydaytext ~= '' then
            paydaytext = paydaytext..'\n'..text
            return {color, text}
        end
        
        if text == '______________________________Áàíêîâñêèé ÷åê______________________________' and color == 1941201407 then
            paydaytext = paydaytext..'\n'..text
        end
    end
end




----- Àâòî ëàâêà è àâòîñïàâí
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
        if title:find("Àêöèè íà") then
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
                    sampAddChatMessage(tag .. textcolor .. "Âûáèðàþ " .. warncolor .. addspawn_id.v .. textcolor .. " ïóíêò.", tagcolor)
                    sampSendDialogResponse(25527, 1, a, _)
                    sampCloseCurrentDialogWithButton(0)
                end)
            elseif not addspawn_waittoggle.v then 
                local a = addspawn_id.v-1
                sampSendDialogResponse(25527, 1, a, _)
                sampAddChatMessage(tag .. textcolor .. "Âûáèðàþ " .. warncolor .. addspawn_id.v .. textcolor .. " ïóíêò.", tagcolor)
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
                for line in text:gmatch("[^\n]+") do -- ðàçáèâàåì ÷òîáû èñêàòü ïî ñòðîêàì
                    table.insert(stats, line)
                end
                wait(0)
                sampCloseCurrentDialogWithButton(0)
           end
        end
    end)
end

function sampev.onSetObjectMaterialText(id, data)
    
    if data.text:find('Íîìåð %d+%. {......}Ñâîáîäíàÿ!') then
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


------ Ñîõðàíåíèå
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
        sendTelegramNotification("Âû áûëè îòêëþ÷åíû îò ñåðâåðà!")
    end
    
    if (id == 32 or id == 37) and autoreconnect_toggle.v then
        lua_thread.create(function()
            local ip, port = sampGetCurrentServerAddress()
            math.randomseed(os.clock())
            local a = math.random(autoreconnect_min.v, autoreconnect_max.v)
            sampAddChatMessage(tag .. textcolor .. 'Çàäåðæêà íà ïîäêëþ÷åíèå: '.. warncolor .. a .. textcolor .. ' ñåêóíä.', tagcolor)
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
                sampAddChatMessage(tag .. textcolor .. "Íåëüçÿ â ýòî âðåìÿ!", tagcolor)
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

function sendTelegramNotification(msg) -- ôóíêöèÿ äëÿ îòïðàâêè ñîîáùåíèÿ þçåðó
    msg = msg:gsub('{......}', '') --òóò òèïî óáèðàåì öâåò
    msg = encodeUrl(msg) -- íó òóò ìû çàêîäèðóåì ñòðîêó
    async_http_request('https://api.telegram.org/bot' .. token.v .. '/sendMessage?chat_id=' .. chat_id.v .. '&text='..msg,'', function(result) end) -- à òóò óæå îòïðàâêà
end

function get_telegram_updates() -- ôóíêöèÿ ïîëó÷åíèÿ ñîîáùåíèé îò þçåðà
    while not updateid do wait(1) end -- æäåì ïîêà íå óçíàåì ïîñëåäíèé ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..token.v ..'/getUpdates?chat_id='..chat_id.v ..'&offset=-1' -- ñîçäàåì ññûëêó
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function processing_telegram_messages(result) -- ôóíêöèÿ ïðîâåðÎ÷êè òîãî ÷òî îòïðàâèë ÷åë
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
                            -- è òóò åñëè ÷åë îòïðàâèë òåêñò ìû ñâåðÿåì
                            local text = u8:decode(message_from_user) .. ' ' --äîáàâëÿåì â êîíåö ïðîáåë äàáû íå ïðîèçîøëè òåõ. øîêîëàäêè ñ êîìàíäàìè(òèïî ÷òîá !q íå ñ÷èòàëîñü êàê !qq)
                            if text:match("^/help") then
                                local arr = {
                                    'Ñïèñîê êîìàíä:',
                                    "",
                                    '/rec  -->  Ïåðåïîäêëþ÷èòüñÿ ê ñåðâåðó',
                                    "",
                                    "/help  -->  Ïîìîùü ïî êîìàíäàì",
                                    "",
                                    "/off  -->  Âûêëþ÷èòü êîìïüþòåð",
                                    "",
                                    "/stats  -->  Ñòàòèñòèêà ñî /stats",
                                    "",
                                    "/reload  -->  Ïåðåçàãðóçèòü ñêðèïò",
                                    "",
                                    "/unload  -->  Îòêëþ÷èòü ñêðèïò"
                                }
                                sendTelegramNotification(table.concat(arr, "\n"))
                            elseif text:match("^/rec") then
                                sendTelegramNotification(tag .. "Ïåðåïîäêëþ÷åíèå ê ñåðâåðó..")
                                lua_thread.create(function()
                                    sampSetGamestate(5)
                                    delay = 0
                                    local ip, port = sampGetCurrentServerAddress()
                                    sampAddChatMessage(tag .. textcolor .. 'Çàäåðæêà: '.. warncolor .. delay .. textcolor ..' ñåê.', tagcolor)
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
                                sendTelegramNotification(tag .. "Âû ñåðüåçíî õîäèòå âûêëþ÷èòü êîìïüþòåð? Åñëè äà, òî ââåäèòå: /shutdown_my_pc\nÅñëè âû ïåðåäóìàëè, òî ââåäèòå ëþáóþ êîìàíäó.")
                            elseif text:match("^/shutdown_my_pc") then
                                if really == 1 then
                                    sendTelegramNotification(tag .. 'Âûêëþ÷àþ êîìïüþòåð ÷åðåç 5 ñåêóíä..')
                                    wait(5000)
                                    os.execute('shutdown -s -t 0')
                                else 
                                    sendTelegramNotification(tag .. 'Íåèçâåñòíàÿ êîìàíäà! Ââåäèòå /help')
                                end

                            elseif text:match("^/unload") then
                                sendTelegramNotification(tag .. "Ñêðèïò áûë óñïåøíî âûãðóæåí!")
                                thisScript():unload()
                            elseif text:match("^/reload") then
                                sendTelegramNotification(tag .. "Ñêðèïò áûë óñïåøíî ïåðåçàãðóæåí!")
                                thisScript():reload()
                            else -- åñëè æå íå íàéäåòñÿ íè îäíà èç êîìàíä âûøå, âûâåäåì ñîîáùåíèå
                                really = 0
                                sendTelegramNotification(tag .. 'Íåèçâåñòíàÿ êîìàíäà! Ââåäèòå /help')
                            end
                        end
                    end
                end
            end
        end
    end
end

function getLastUpdate() -- òóò ìû ïîëó÷àåì ïîñëåäíèé ID ñîîáùåíèÿ, åñëè æå ó âàñ â êîäå áóäåò íàñòðîéêà òîêåíà è chat_id, âûçîâèòå ýòó ôóíêöèþ äëÿ òîãî ÷òîá ïîëó÷èòü ïîñëåäíåå ñîîáùåíèå
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
                    updateid = 1 -- òóò çàäàäèì çíà÷åíèå 1, åñëè òàáëèöà áóäåò ïóñòàÿ
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

-- Àëüôà
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

-- Òåìà
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
