script_name("AdminHelper")
script_version("1.0") 
script_author("Anthony_Martini")

local inicfg = require 'inicfg'
local tag = '[AdminHelper]{FFFFFF} ' 
local sampev = require 'lib.samp.events'
local key = require 'vkeys'
local id = "-1"
local respavn = false
local unload = false
local hpall = false
local check = true
local recon = false
local samp = require 'samp.events'
local ffi = require 'ffi'
local memory = require 'memory'
local infa = {["articletrailer2"]=articletrailer2, ["450"]=articletrailer2, ["tram"]=tram, ["449"]=tram, ["pizzaboy"]=pizzaboy, ["448"]=pizzaboy, ["seasparrow"]=seasparrow, ["447"]= seasparrow, ["squallo"]=squallo, ["446"]=squallo, ["admiral"]=admiral, ["445"]=admiral, ["monster"]= monster, ["444"]= monster, ["packer"]=packer, ["443"]=packer, ["romero"]=romero, ["442"]=romero, ["rcbandit"]=rcbandit, ["441"]=rcbandit, ["rumpo"]=rumpo, ["440"]=rumpo, ["stallion"]=stallion, ["439"]= stallion, ["cabbie"]=cabbie, ["438"]=cabbie, ["coach"]=coach, ["437"]=coach, ["previon"]=previon, ["436"]=previon, ["articletrailer"]=articletrailer, ["435"]=articletrailer, ["hotknife"]=hotknife, ["434"]=hotknife, ["barracks"]=barracks, ["433"]=barracks, ["rhino"]= rhino, ["432"]=rhino, ["bus"]=bus, ["431"]=bus, ["enforcer"]=enforcer, ["427"]=enforcer, ["securicar"]=securicar, ["428"]=securicar, ["banshee"]=banshee, ["429"]=banshee, ["predator"]=predator, ["430"]= predator, ["premier"]=premier, ["426"]=premier,["hunter"]=hunter, ["425"]=hunter, ["bfinjection"]=bfinjection, ["424"]=bfinjection, ["mrwhoopee"]=mrwhoopee, ["423"]=mrwhoopee, ["bobcat"]=bobcat, ["422"]=bobcat, ["washington"]=washington, ["421"]=washington, ["taxi"]=taxi, ["420"]=taxi, ["esperanto"]=esperanto, ["419"]=esperanto, ["moonbeam"]=moonbeam, ["418"]=moonbeam, ["leviathan"]=leviathan, ["417"]=leviathan, ["ambulance"]=ambulance, ["416"]=ambulance, ["cheetah"]=cheetah, ["415"]=cheetah, ["mule"]=mule, ["414"]=mule, ["pony"]=pony, ["413"]=pony, ["voodoo"]=voodoo, ["412"]=voodoo, ["infernus"]=infernus, ["411"]=infernus, ["manana"]=manana, ["410"]= manana, ["stretch"]=stretch, ["409"]=stretch, ["trashmaster"]=trashmaster, ["408"]=trashmaster, ["firetruck"]=firetruck, ["407"]=firetruck, ["dumper"]=dumper, ["406"]=dumper, ["sentinel"]=sentinel, ["405"]=sentinel, ["perenniel"]=perenniel, ["404"]=perenniel, ["linerunner"]=linerunner, ["403"]=linerunner, ["buffalo"]=buffalo, ["402"]=buffalo, ["bravura"]=bravura, ["401"]=bravura, ["landstalker"]=landstalker, ["400"]= landstalker, ["tampa"]=tampa, ["549"]=tampa, ["picador"]=picador, ["600"]=picador, ["oceanic"]=oceanic, ["467"]=oceanic, ["nebula"]=nebula, ["516"]=nebula, ["sultan"]=sultan, ["560"]=sultan, ["glendale"]=glendale, ["466"]=glendale, ["clover"]=clover, ["542"]=clover, ["greenwood"]=greenwood, ["592"]=greenwood, ["majestic"]=majestic, ["517"]=majestic}
local scrptnum = 1
local PlayersNickname = {}
local name = "djsdjsjr12hfwhfwjeg248482424242jjtjhtj232uwry132eqe"

ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]

if not doesDirectoryExist("moonloader\\ah") then 
	createDirectory("moonloader\\ah") 
end

if not doesFileExist("moonloader\\ah\\config.ini") then 
 	check = false
	local f = io.open('moonloader\\ah\\config.ini', 'a') 
	f:write("[settings]\ncolor1=0\ncolor2=0\ngg=Приятной игры и хорошего настроения на Advance RP Silver =]\nprm=Обычный промокод - arp_s7 ; Гетто-промокод - arps_ghetto\nnet=Ник формата 'Имя_Фамилия' меняется через 'Донат' (9 руб).\njb=Оформите жалобу на forum.advance-rp.ru(С видео)\najb=Если вы не согласны с наказанием, пишите жалобу на форум.\nrp=Узнайте Role-Play путем, приятной игры :]\noftp=Пожалуйста не оффтопьте (При повторе может наказываться затычкой)\nnapom=true\nkillid=true\nacolor=0x00CED1\nanscolor=0xDAA520") 
	f:close()
end

function main() 
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	if sampGetCurrentServerAddress() == '5.254.104.131' then server = 1 server_name = 'Red'
    elseif sampGetCurrentServerAddress() == '5.254.104.132' then server = 2 server_name = 'Green'
    elseif sampGetCurrentServerAddress() == '5.254.104.133' then server = 3 server_name = 'Yellow'
    elseif sampGetCurrentServerAddress() == '5.254.104.134' then server = 4 server_name = 'Orange'
    elseif sampGetCurrentServerAddress() == '5.254.104.135' then server = 5 server_name = 'Blue'
    elseif sampGetCurrentServerAddress() == '5.254.104.136' then server = 6 server_name = 'White'
    elseif sampGetCurrentServerAddress() == '5.254.104.137' then server = 7 server_name = 'Silver'
    elseif sampGetCurrentServerAddress() == '5.254.104.138' then server = 8 server_name = 'Purple'
    elseif sampGetCurrentServerAddress() == '5.254.104.139' then server = 9 server_name = 'Chocolate'
	else sampAddChatMessage(tag.. "Данный скрипт предназначен для использования исключительно на серверах Advance RP", 0xFFA500) unload = true thisScript():unload() end
	if unload == false then sampAddChatMessage(tag .. "" .. thisScript().name .. " успешно загружен. ID версии: " .. scrptnum .. ". Разработчик скрипта: {4682B4}Anthony_Martini", 0xFFA500)  sampAddChatMessage(tag .. "Помощь по скрипту: {FFA500}/hhelp{ffffff}. Приятного пользования {ff6666}:3", 0xFFA500) if check == false then sampAddChatMessage(tag.. "{ff0000}Внимание! {ffffff}Установите нужные Вам настройки, используя {FFDAB9}/aset", 0xFFA500) end end
	downloadUrlToFile("https://github.com/tsurik/jadahadjddw/raw/master/version.txt", "moonloader\\ah\\version.txt")
	sampRegisterChatCommand("prm", promokod)
	sampRegisterChatCommand("net", net)
	sampRegisterChatCommand("jb", jaloba)
	sampRegisterChatCommand("ajb", ajaloba)
	sampRegisterChatCommand("rp", rrp)
	sampRegisterChatCommand("hhelp", admhelp)
	sampRegisterChatCommand("re", arecon)
	sampRegisterChatCommand("reoff", areconoff)
	sampRegisterChatCommand("pn", punish)
	sampRegisterChatCommand("gg", goodgame)
	sampRegisterChatCommand("oftp", offtop)
	sampRegisterChatCommand("tt", ttime)
	sampRegisterChatCommand("cinf", cinformation)
	sampRegisterChatCommand("slap", slap)
	sampRegisterChatCommand("v", veci)
	sampRegisterChatCommand("spoff", spoff)
	sampRegisterChatCommand("vcol", vcolor)
	sampRegisterChatCommand("aset", asettings)
	sampRegisterChatCommand("test", test)
	sampRegisterChatCommand("qah", quit)
	sampRegisterChatCommand("ahupdate", update)
	thread = lua_thread.create_suspended(thread_function)
	ini = inicfg.load(nil, "moonloader\\ah\\config.ini")
	while true do
		wait(0)
		if isKeyDown(18) and isKeyJustPressed(50) then
			sampAddChatMessage(tag.. "Велосипед был выдан", 0xFFA500)
			sampSendChat("/vec 510 " ..ini.settings.color1.. " " ..ini.settings.color2)
		end
		if isKeyDown(18) and isKeyJustPressed(51) then
			if respavn == false then
				sampAddChatMessage(tag.. "Нажмите комбинацию еще раз для подтверждения действия ({FFDAB9}Alt + 3{ffffff})", 0xFFA500)
				respavn = true
			else
				sampSendChat("/respv -1")
				respavn = false
			end
		end
		if isKeyDown(18) and isKeyJustPressed(48) then
			if hpall == false then
				sampAddChatMessage(tag.. "Нажмите комбинацию еще раз для подтверждения действия ({FFDAB9}Alt + 0{ffffff})", 0xFFA500)
				hpall = true
			else
				sampSendChat("/hpall 100")
				hpall = false
			end
		end
		if ini.settings.killid == true then
			kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
		else
			kill = false
		end
		if ini.settings.napom == true then
			if os.date("%M",os.time()) == "59" and os.date("%S",os.time()) == "00" then
				sampAddChatMessage(tag.. "{ff0000}Внимание! {ffffff}Payday будет через {FFDAB9}1 минуту{ffffff}. Не выходите в AFK =]", 0xFFA500)
				wait(1000)
			end 
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(0)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampShowDialog(10, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/gg", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.gg, "Редакт.", "Назад", 1)
				end
				if listMain == 1 then
					sampShowDialog(11, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/prm", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.prm, "Редакт.", "Назад", 1)
				end
				if listMain == 2 then
					sampShowDialog(12, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/net", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.net, "Редакт.", "Назад", 1)
				end
				if listMain == 3 then
					sampShowDialog(13, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/jb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.jb, "Редакт.", "Назад", 1)
				end
				if listMain == 4 then
					sampShowDialog(14, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/ajb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.ajb, "Редакт.", "Назад", 1)
				end
				if listMain == 5 then
					sampShowDialog(15, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/rp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.rp, "Редакт.", "Назад", 1)
				end
				if listMain == 6 then
					sampShowDialog(16, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/oftp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.oftp, "Редакт.", "Назад", 1)
				end
				if listMain == 7 then
					sampShowDialog(20, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/a", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.acolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет] {ffffff}или {FFA500}off {ffffff}для вылюечения функции {ff0000}[!]", "Редакт.", "Назад", 1)
				end
				if listMain == 8 then
					sampShowDialog(21, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/ans", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.anscolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет]{ffffff} или {FFA500}off {ffffff}для выключения функции {ff0000}[!]", "Редакт.", "Назад", 1)
				end
				if listMain == 9 then
					if ini.settings.napom == true then ini.settings.napom = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "Напоминания о зарплате {ff0000}выключены", 0xFFA500) asettings() 
					elseif ini.settings.napom == false then ini.settings.napom = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "Напоминания о зарплате {00ff00}включены", 0xFFA500) asettings() end
				end
				if listMain == 10 then
					if ini.settings.killid == true then ini.settings.killid = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "ID в kill-листе {ff0000}выключены", 0xFFA500) asettings() 
					elseif ini.settings.killid == false then ini.settings.killid = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "ID в kill-листе {00ff00}включены", 0xFFA500) asettings() end
				end
				if listMain == 11 then
					sampShowDialog(17, "{FFA500}" ..tag.. "Подтверждение действия", "{ffffff}Вы действительно хотите вернуть стандартные значения?", "Да", "Назад", 0)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(17)
		if resultMain == true then
			if buttonMain == 1 then
				stznach()
				sampAddChatMessage(tag.. "Стандартные значения заданы", 0xFFA500)
				inicfg.save(ini, "moonloader\\ah\\config.ini")
				asettings()
			else
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputgg = sampHasDialogRespond(10)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputgg == 0 then
					sampShowDialog(10, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/gg", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.gg, "Редакт.", "Назад", 1)
				else
					if #inputgg < 10 then
						sampShowDialog(10, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/gg", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.gg, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.gg = inputgg
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputprm = sampHasDialogRespond(11)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputprm == 0 then
					sampShowDialog(11, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/prm", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.prm, "Редакт.", "Назад", 1)
				else
					if #inputprm < 10 then
						sampShowDialog(11, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/prm", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.prm, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.prm = inputprm
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputnet = sampHasDialogRespond(12)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputnet == 0 then
					sampShowDialog(12, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/net", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.net, "Редакт.", "Назад", 1)
				else
					if #inputnet < 10 then
						sampShowDialog(12, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/net", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.net, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.net = inputnet
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputjb = sampHasDialogRespond(13)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputjb == 0 then
					sampShowDialog(13, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/jb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.jb, "Редакт.", "Назад", 1)
				else
					if #inputjb < 10 then
						sampShowDialog(13, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/jb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.jb, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.jb = inputjb
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputajb = sampHasDialogRespond(14)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputajb == 0 then
					sampShowDialog(14, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/ajb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.ajb, "Редакт.", "Назад", 1)
				else
					if #inputajb < 10 then
						sampShowDialog(14, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/ajb", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.ajb, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.ajb = inputajb
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputrp = sampHasDialogRespond(15)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputrp == 0 then
					sampShowDialog(15, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/rp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.rp, "Редакт.", "Назад", 1)
				else
					if #inputrp < 10 then
						sampShowDialog(15, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/rp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.rp, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.rp = inputrp
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputoftp = sampHasDialogRespond(16)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputoftp == 0 then
					sampShowDialog(16, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/oftp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.oftp, "Редакт.", "Назад", 1)
				else
					if #inputoftp < 10 then
						sampShowDialog(16, "{FFA500}" ..tag.. "Редактирование команды {FFA500}/oftp", "{FFA500}Текущий текст: {ffffff}" ..ini.settings.oftp, "Редакт.", "Назад", 1)
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
					else
						ini.settings.oftp = inputoftp
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputacolor = sampHasDialogRespond(20)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputacolor == 0 then
					sampShowDialog(20, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/a", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.acolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет] {ffffff}или {FFA500}off {ffffff}для вылюечения функции {ff0000}[!]", "Редакт.", "Назад", 1)
				else
					if inputacolor == "off" then
						ini.settings.acolor = inputacolor
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					else
						if #inputacolor < 8 then
							sampShowDialog(20, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/a", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.acolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет] {ffffff}или {FFA500}off {ffffff}для вылюечения функции {ff0000}[!]", "Редакт.", "Назад", 1)
							sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
						else
							ini.settings.acolor = inputacolor
							inicfg.save(ini, "moonloader\\ah\\config.ini")
							sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
							asettings()
						end
					end
				end
			else 
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputanscolor = sampHasDialogRespond(21)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputanscolor == 0 then
					sampShowDialog(21, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/ans", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.anscolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет]{ffffff} или {FFA500}off {ffffff}для выключения функции {ff0000}[!]", "Редакт.", "Назад", 1)
				else
					if inputanscolor == "off" then
						ini.settings.anscolor = inputanscolor
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
						asettings()
					else
						if #inputanscolor < 8 then
							sampShowDialog(21, "{FFA500}" ..tag.. "Изменение цвета {FFA500}/ans", "{FFA500}Текущий цвет: {ffffff}" ..ini.settings.anscolor.. "\n{ff0000}[!] {ffffff}Используйте {FFA500}0x[html цвет]{ffffff} или {FFA500}off {ffffff}для выключения функции {ff0000}[!]", "Редакт.", "Назад", 1)
							sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Слишком малельное количество символов", 0xFFA500)
						else
							ini.settings.anscolor = inputanscolor
							inicfg.save(ini, "moonloader\\ah\\config.ini")
							sampAddChatMessage(tag.. "Сохранение данных прошло успешно", 0xFFA500)
							asettings()
						end
					end
				end
			else 
				asettings()
			end
		end
	end
end

function asettings()
	if ini.settings.napom == true then vnapom = "{00FF00}Включено"
	elseif ini.settings.napom == false then vnapom = "{ff0000}Выключено" end
	if ini.settings.killid == true then vkillid = "{00ff00}Включено"
	elseif ini.settings.killid == false then vkillid = "{ff0000}Выключено" end
	if ini.settings.acolor == "off" then vacolor = "{ff0000}Выключено"
	else vacolor = ini.settings.acolor end
	if ini.settings.anscolor == "off" then vanscolor = "{ff0000}Выключено"
	else vanscolor = ini.settings.anscolor end
	sampShowDialog(0, "{FFA500}" ..tag.. "Настройки скрипта", "{FFA500}Команда\t{ffffff}Текущее значение\n{FFA500}/gg\t{ffffff}" ..ini.settings.gg.. "\n{FFA500}/prm\t{ffffff}" ..ini.settings.prm.. "\n{FFA500}/net\t{ffffff}" ..ini.settings.net.. "\n{FFA500}/jb\t{ffffff}" ..ini.settings.jb.."\n{FFA500}/ajb\t{ffffff}" ..ini.settings.ajb.. "\n{FFA500}/rp\t{ffffff}" ..ini.settings.rp.. "\n{FFA500}/oftp\t{ffffff}" ..ini.settings.oftp.. "\n{FFA500}Цвет /a\t{ffffff}" ..vacolor.. "\n{FFA500}Цвет /ans\t{ffffff}" ..vanscolor.. "\n{FFA500}Напоминание о ЗП \t" ..vnapom.. "\n{FFA500}ID в kill-листе\t" ..vkillid.. "\n{008000}Вернуть стандартные значения", "Ок", "Отмена", 5)
end

function test()
	sampAddChatMessage("Server Number: " ..server.. " | Server Name: " ..server_name.. " | ServerIP: " ..sampGetCurrentServerAddress(), -1)
end

function admhelp(arg)
	sampShowDialog(10000, "{FFA500}" .. tag.. "Помощь по скрипту", "{FFA500}/aset - {ffffff}настройки скрипта\n{FFA500}/re - {ffffff}начать слежку по жалобе\n{FFA500}/pn - {ffffff}''игрок получил наказание''\n{FFA500}/reoff - {ffffff}''нарушений не обнаружено'' (/reoff -1 для обнуления)\n{FFA500}/gg - {ffffff}пожелать приятной игры\n{FFA500}/tt - {ffffff}сообщить точное время\n{FFA500}/slap - {ffffff}пнуть игрока\n{FFA500}/cinf - {ffffff}информация о транспорте\n{FFA500}/spoff - {ffffff}выйти со слежки (помогает при баге панели)\n{FFA500}/v - {ffffff}сокращение /vec\n{FFA500}/vcol - {ffffff}изменить цвет ТС в /v\n{FFA500}/net - {ffffff}отказать в смене ника\n{FFA500}/rp - {ffffff}'Узнайте РП путем'\n{FFA500}/prm - {ffffff}сказать промокод\n{FFA500}/jb - {ffffff}'пишите жалобу на форум'\n{FFA500}/ajb - {ffffff}'не согласны с наказанием - пишите жб на адм'\n{FFA500}/oftp - {ffffff}просьба не оффтопить\n{FFA500}Alt+2 - {ffffff}выдать велосипед\n{FFA500}Alt+3 - {ffffff}респавн авто в зоне видимости\n{FFA500}Alt+0 - {ffffff}выдать здоровье в радиусе (для МП)", "ОК")
end

function spoff()
	sampAddChatMessage(tag.. "Вы вышли из режима слежения", 0xFFA500)
	sampSendMenuSelectRow(0)
end

function veci(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /v [id транспорта]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /v [id транспорта]", 0xFFA500)
		else
			if arg < 400 or arg > 611 then
				sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}ID транспорта находится в пределе от 400 до 611", 0xFFA500)
			else
				sampSendChat("/vec " ..arg.. " " ..ini.settings.color1.. " " ..ini.settings.color2)
				sampAddChatMessage(tag.. "Транспорт создан: ID " ..arg, 0xFFA500)
			end
		end
	end
end

function ttime(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /tt [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /tt [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /tt [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..os.date("%d.%m.%Y").. " " ..os.date("%X",os.time()))
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function quit()
	sampAddChatMessage(tag.. "Работа скрипта была завершена", 0xFFA500)
	thisScript():unload()
end

function cinformation(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /cinf [id/название авто (с маленькой)]", 0xFFA500)
	else
		checkcar()
		inform = infa[arg]
		if inform ~= nil then
			sampAddChatMessage(tag.. "" ..inform, 0xFFA500)
		else
			sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Данных об этом транспорте не обнаружено", 0xFFA500)
		end
	end
end

function vcolor(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /vcol [id цвета 1] [id цвета 2]", 0xFFA500)
	else
		color1, color2 = string.match(arg, "(.+) (.+)")
		color1 = tonumber(color1)
		if type(color1) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /vcol [id цвета 1] [id цвета 2]", 0xFFA500)
		else
			color2 = tonumber(color2)
			if type(color2) ~= "number" then
				sampAddChatMessage(tag.. "Используйте /vcol Используйте /vcol [id цвета 1] [id цвета 2]", 0xFFA500)
			else
				if color1 < 0 or color1 > 255 then
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Диапазон ID цветов от 0 до 255", 0xFFA500)
				else
					if color2 < 0 or color2 > 255 then
						sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Диапазон ID цветов от 0 до 255", 0xFFA500)
					else
						ini.settings.color1 = color1
						ini.settings.color2 = color2
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "ID цветов сохранено: " ..color1.. ", " ..color2, 0xFFA500)
					end
				end
			end
		end
	end
end

function offtop(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /oftp [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /oftp [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /oftp [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.oftp)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function goodgame(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /gg [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /gg [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /gg [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.gg)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function arecon(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /re [id игрока] [id нарушителя]", 0xFFA500)
	else
		id, idd = string.match(arg, "(.+) (.+)")
		id = tonumber(id)
		if type(id) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /re [id игрока] [id нарушителя]", 0xFFA500)
		else
			if id < 0 or id > 999 then
				sampAddChatMessage(tag.. "Используйте /re [id игрока] [id нарушителя]", 0xFFA500)
			else
				idd = tonumber(idd)
				if type(idd) ~= "number" then
					sampAddChatMessage(tag.. "Используйте /re [id игрока] [id нарушителя]", 0xFFA500)
				else
					if idd < 0 or idd > 999 then
						sampAddChatMessage(tag.. "Используйте /re [id игрока] [id нарушителя]", 0xFFA500)
					else
						if sampIsPlayerConnected(id) then
							if sampIsPlayerConnected(idd) then
								name = sampGetPlayerNickname(idd)
								sampAddChatMessage(tag.. "Для завершения наблюдения используйте {ff0000}/reoff{ffffff}. Если игрок получит наказание {ff0000}/pn", 0xFFA500)
								sampSendChat("/ans " ..id.. " Начал наблюдение за указанным Вами игроком: " ..name.. ".")
								sampSendChat("/sp " ..idd)
								sampSendChat("/sp " ..idd)
								recon = true
							else
								sampSendChat("/ans " ..id.. " Данный игрок вышел из игры и в данный момент оффлайн") 
							end
						else
							sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с данным ID нет на сервере", 0xFFA500)
						end
					end
				end
			end
		end
	end
end

function punish(arg)
	if #arg == 0 then
		if recon then
			sampSendChat("/ans " ..id.. " Игрок " ..name.. " получил наказание. Приятной игры =]")
			recon = false
		else
			sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Вы не начинали слежку за игроком. Можете использовать {FFDAB9}/pn [id]", 0xFFA500)
		end
	end
	arg = tonumber(arg)
	if type(arg) == "number" then
		sampSendChat("/ans " ..arg.. " Игрок получил соответствующее наказание. Приятной игры =]")
	end
end
	
function areconoff(arg)
	if #arg == 0 then
		if recon then
			sampSendChat("/ans " ..id.. " Нарушений от " ..name.. " не обнаружено")
			sampSendMenuSelectRow(0)
			recon = false
		else
			sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Вы не начинали слежку за игроком. Можете использовать {FFDAB9}/reoff [id]", 0xFFA500)
		end
	end
	if arg == "-1" then
		sampAddChatMessage(tag.. "Данные о слежке обнулены", 0xFFA500)
		recon = false
	else
		arg = tonumber(arg)
		if type(arg) == "number" then
			sampSendChat("/ans " ..arg.. " Нарушений от игрока не обнаружено. Пишите жалобу на форум.")
		end
	end
end

function rrp(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /rp [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /rp [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /rp [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.rp)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function ajaloba(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /ajb [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /ajb [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /ajb [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.ajb)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function promokod(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /prm [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /prm [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /prm [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.prm)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function sampev.onServerMessage(color, text)
--	print(text.. " | " ..color)
	if string.find(color, "-11521793", 1, true) and string.find(text, name, 1, true) and recon == true then
		sampAddChatMessage(text, 0xDC143C)
		sampSendChat("/ans " ..id.. " Игрок " ..name.. " получил наказание. Приятной игры =]")
		recon = false
		return false
	end
	if string.find(color, "-1717986817", 1, true) and string.find(text, name, 1, true) and string.find(text, "тюрьму", 1, true) and recon == true then
		sampAddChatMessage(text, 0xDC143C)
		sampSendChat("/ans " ..id.. " Игрок " ..name.. " получил наказание. Приятной игры =]")
		recon = false
		return false
	end
	if ini.settings.anscolor ~= "off" then
		if string.find(color, "-6732289", 1, true) then
			for i = 0, 999 do
				if sampIsPlayerConnected(i) and PlayersNickname[i] then
					if string.find(text, " "..PlayersNickname[i]) and not string.find(text, " "..PlayersNickname[i].."%[%d+%]") then
					  PlayerName = string.match(text, PlayersNickname[i])
					  if PlayerName then
						PlayerID = sampGetPlayerID(PlayerName)
						if PlayerID then
							text = string.gsub(text, " "..PlayerName, " "..PlayerName.."["..PlayerID.."]")
						end
					  end
					end
				end
			end
			sampAddChatMessage(text, ini.settings.anscolor)
			return false
		end
	end
	if ini.settings.acolor ~= "off" then
		if string.find(color, "-1714683649", 1, true) then
			for i = 0, 999 do
				if sampIsPlayerConnected(i) and PlayersNickname[i] then
					if string.find(text, " "..PlayersNickname[i]) and not string.find(text, " "..PlayersNickname[i].."%[%d+%]") then
					  PlayerName = string.match(text, PlayersNickname[i])
					  if PlayerName then
						PlayerID = sampGetPlayerID(PlayerName)
						if PlayerID then
							text = string.gsub(text, " "..PlayerName, " "..PlayerName.."["..PlayerID.."]")
						end
					  end
					end
				end
			end
			sampAddChatMessage(text, ini.settings.acolor)
			return false
		end
	end
end

function net(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /net [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /net [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /net [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.net)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function slap(arg)
if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /slap [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /slap [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /slap [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					slapid = arg
					thread:run("slaper")
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end
	
	
function jaloba(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "Используйте /jb [id]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "Используйте /jb [id]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "Используйте /jb [id]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ini.settings.jb)
				else
					sampAddChatMessage(tag.. "{ff0000}Ошибка. {ffffff}Игрока с таким ID нет на сервере", 0xFFA500)
				end
			end
		end
	end
end

function samp.onPlayerDeathNotification(killerId, killedId, reason)
	local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)

	local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
	local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
	lua_thread.create(function()
		wait(0)
		if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
		if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
	end)
end

function thread_function(option)
	if option == "slaper" then
		sampSendChat("/sp " ..slapid)
		wait(50)
		sampSendMenuSelectRow(2)
		sampSendMenuSelectRow(0)
	end
end

function update()
	obnov = io.open("moonloader\\ah\\version.txt", "r+")
	obnovv = obnov:read()
	obnovv = tonumber(obnovv)
	if obnovv > scrptnum then
		local dlstatus = require('moonloader').download_status
		downloadUrlToFile("https://github.com/tsurik/jadahadjddw/raw/master/AdminHelper.lua", thisScript().path, function(id, status)
			if status == dlstatus.STATUSENDDOWNLOADDATA then
				thisScript():reload()
			end
		end)
		sampAddChatMessage(tag.. "Скрипт успешно обновлен до версии {FFDAB9}" ..obnovv.. "{FFFFFF}! Рекомендуем проверить настройки {FFDAB9}/aset {ffffff}и исправить при необходимости", 0xFFA500)
		stznach()
		return
	else
		sampAddChatMessage(tag.. "Обновлений не обнаружено. Данная версия является актуальной", 0xFFA500)
	end
	obnov:close()
end

function stznach()
	ini.settings.gg = "Приятной игры и хорошего настроения на Advance RP Silver =]"
	ini.settings.prm = "Обычный промокод - arp_s7 ; Гетто-промокод - arps_ghetto"
	ini.settings.net = "Ник формата 'Имя_Фамилия' меняется через 'Донат' (9 руб)."
	ini.settings.jb = "Оформите жалобу на forum.advance-rp.ru (с видео)"
	ini.settings.ajb = "Если вы не согласны с наказанием, пишите жалобу на форум."
	ini.settings.rp = "Узнайте Role-Play путем, приятной игры :]"
	ini.settings.oftp = "Пожалуйста не оффтопьте (При повторе может наказываться затычкой)"
	ini.settings.acolor = "0x00CED1"
	ini.settings.anscolor = "0xDAA520"
	ini.settings.napom = true
	ini.settings.killid = true
end

function checkcar()
	sultan = "ID: {ff0000}560 {ffffff}| Model: {ff0000}Sultan {ffffff}| Price: {ff0000}590.000$ {ffffff}| Max speed: {ff0000}94 km/h"
	glendale = "ID: {ff0000}466 {ffffff}| Model: {ff0000}Glendale {ffffff}| Price: {ff0000}24.000$ {ffffff}| Max speed: {ff0000}82 km/h"
	clover = "ID: {ff0000}542 {ffffff}| Model: {ff0000}Clover {ffffff}| Price: {ff0000}15.000$ {ffffff}| Max speed: {ff0000}91 km/h"
	greenwood = "ID: {ff0000}592 {ffffff}| Model: {ff0000}Greenwood {ffffff}| Price: {ff0000}35.000$ {ffffff}| Max speed: {ff0000}78 km/h"
	majestic = "ID: {ff0000}517 {ffffff}| Model: {ff0000}Majestic {ffffff}| Price: {ff0000}23.000$ {ffffff}| Max speed: {ff0000}87 km/h"
	nebula = "ID: {ff0000}516 {ffffff}| Model: {ff0000}Nebula {ffffff}| Price: {ff0000}43.000$ {ffffff}| Max speed: {ff0000}87 km/h"
	oceanic = "ID: {ff0000}467 {ffffff}| Model: {ff0000}Oceanic {ffffff}| Price: {ff0000}31.500$ {ffffff}| Max speed: {ff0000}78 km/h"
	picador = "ID: {ff0000}600 {ffffff}| Model: {ff0000}Picador {ffffff}| Price: {ff0000}19.200$ {ffffff}| Max speed: {ff0000}84 km/h"
	tampa = "ID: {ff0000}549 {ffffff}| Model: {ff0000}Tampa {ffffff}| Price: {ff0000}20.100$ {ffffff}| Max speed: {ff0000}84 km/h"
	landstalker = "ID: {ff0000}400 {ffffff}| Model: {ff0000}Landstalker {ffffff}| Price: {ff0000}165.000$ {ffffff}| Max speed: {ff0000}88 km/h"
	bravura = "ID: {ff0000}401 {ffffff}| Model: {ff0000}Bravura {ffffff}| Price: {ff0000}64.000$ {ffffff}| Max speed: {ff0000}82 km/h"
	buffalo = "ID: {ff0000}402 {ffffff}| Model: {ff0000}Buffalo {ffffff}| Price: {ff0000}850.000$ {ffffff}| Max speed: {ff0000}103 km/h"
	linerunner = "ID: {ff0000}403 {ffffff}| Model: {ff0000}Linerunner {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}61 km/h"
	perenniel = "ID: {ff0000}404 {ffffff}| Model: {ff0000}Perenniel {ffffff}| Price: {ff0000}19.500$ {ffffff}| Max speed: {ff0000}74 km/h"
	sentinel = "ID: {ff0000}405 {ffffff}| Model: {ff0000}Sentinel {ffffff}| Price: {ff0000}102.000$ {ffffff}| Max speed: {ff0000}91 km/h"
	dumper = "ID: {ff0000}406 {ffffff}| Model: {ff0000}Dumper {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}61 km/h"
	firetruck = "ID: {ff0000}407 {ffffff}| Model: {ff0000}Firetruck {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}82 km/h"
	trashmaster = "ID: {ff0000}408 {ffffff}| Model: {ff0000}Trashmaster {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}55 km/h"
	stretch = "ID: {ff0000}409 {ffffff}| Model: {ff0000}Stretch {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}88 km/h"
	manana = "ID: {ff0000}410 {ffffff}| Model: {ff0000}Manana {ffffff}| Price: {ff0000}12.000$ {ffffff}| Max speed: {ff0000}72 km/h"
	infernus = "ID: {ff0000}411 {ffffff}| Model: {ff0000}Infernus {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}123 km/h"
	voodoo = "ID: {ff0000}412 {ffffff}| Model: {ff0000}Voodoo {ffffff}| Price: {ff0000}240.000$ {ffffff}| Max speed: {ff0000}93 km/h"
	pony = "ID: {ff0000}413 {ffffff}| Model: {ff0000}Pony {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}61 km/h"
	mule = "ID: {ff0000}414 {ffffff}| Model: {ff0000}Mule {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}59 km/h"
	cheetah = "ID: {ff0000}415 {ffffff}| Model: {ff0000}Cheetah {ffffff}| Price: {ff0000}1.800.000$ {ffffff}| Max speed: {ff0000}107 km/h"
	ambulance = "ID: {ff0000}416 {ffffff}| Model: {ff0000}Ambulance {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}85 km/h"
	leviathan = "ID: {ff0000}417 {ffffff}| Model: {ff0000}Leviathan {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	moonbeam = "ID: {ff0000}418 {ffffff}| Model: {ff0000}Moonbeam {ffffff}| Price: {ff0000}145.000$ {ffffff}| Max speed: {ff0000}64 km/h"
	esperanto = "ID: {ff0000}419 {ffffff}| Model: {ff0000}Esperanto {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}83 km/h"
	taxi = "ID: {ff0000}420 {ffffff}| Model: {ff0000}Taxi {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}96 km/h"
	washington = "ID: {ff0000}421 {ffffff}| Model: {ff0000}Washington {ffffff}| Price: {ff0000}124.000$ {ffffff}| Max speed: {ff0000}85 km/h"
	bobcat = "ID: {ff0000}422 {ffffff}| Model: {ff0000}Bobcat {ffffff}| Price: {ff0000}23.700$ {ffffff}| Max speed: {ff0000}78 km/h"
	mrwhoopee = "ID: {ff0000}423 {ffffff}| Model: {ff0000}Mr Whoopee {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}55 km/h"
	bfinjection = "ID: {ff0000}424 {ffffff}| Model: {ff0000}BF Injection {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}75 km/h"
	hunter = "ID: {ff0000}425 {ffffff}| Model: {ff0000}Hunter {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	premier = "ID: {ff0000}426 {ffffff}| Model: {ff0000}Premier {ffffff}| Price: {ff0000}130.000$ {ffffff}| Max speed: {ff0000}96 km/h"
	enforcer = "ID: {ff0000}427 {ffffff}| Model: {ff0000}Enforcer {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}92 km/h"
	securicar = "ID: {ff0000}428 {ffffff}| Model: {ff0000}Securicar {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}87 km/h"
	banshee = "ID: {ff0000}429 {ffffff}| Model: {ff0000}Banshee {ffffff}| Price: {ff0000}730.000$ {ffffff}| Max speed: {ff0000}112 km/h"
	predator = "ID: {ff0000}430 {ffffff}| Model: {ff0000}Predator {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}100 km/h"
	bus = "ID: {ff0000}431 {ffffff}| Model: {ff0000}Bus {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}72 km/h"
	rhino = "ID: {ff0000}432 {ffffff}| Model: {ff0000}Rhino {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}52 km/h"
	barracks = "ID: {ff0000}433 {ffffff}| Model: {ff0000}Barracks {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}61 km/h"
	hotknife = "ID: {ff0000}434 {ffffff}| Model: {ff0000}Hotknife {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}93 km/h"
	articletrailer = "ID: {ff0000}435 {ffffff}| Model: {ff0000}Article Trailer {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	previon = "ID: {ff0000}436 {ffffff}| Model: {ff0000}Previon {ffffff}| Price: {ff0000}84.000$ {ffffff}| Max speed: {ff0000}83 km/h"
	coach = "ID: {ff0000}437 {ffffff}| Model: {ff0000}Coach {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}88 km/h"
	cabbie = "ID: {ff0000}438 {ffffff}| Model: {ff0000}Cabbie {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}79 km/h"
	stallion = "ID: {ff0000}439 {ffffff}| Model: {ff0000}Stallion {ffffff}| Price: {ff0000}26.000$ {ffffff}| Max speed: {ff0000}94 km/h"
	rumpo = "ID: {ff0000}440 {ffffff}| Model: {ff0000}Rumpo {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}76 km/h"
	rcbandit = "ID: {ff0000}441 {ffffff}| Model: {ff0000}RC Bandit {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	romero = "ID: {ff0000}442 {ffffff}| Model: {ff0000}Romero {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}77 km/h"
	packer = "ID: {ff0000}443 {ffffff}| Model: {ff0000}Packer {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}70 km/h"
	monster = "ID: {ff0000}444 {ffffff}| Model: {ff0000}Monster {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}61 km/h"
	admiral = "ID: {ff0000}445 {ffffff}| Model: {ff0000}Admiral {ffffff}| Price: {ff0000}140.000$ {ffffff}| Max speed: {ff0000}91 km/h"
	squallo = "ID: {ff0000}446 {ffffff}| Model: {ff0000}Squallo {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}103 km/h"
	seasparrow = "ID: {ff0000}447 {ffffff}| Model: {ff0000}Seasparrow {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	pizzaboy = "ID: {ff0000}448 {ffffff}| Model: {ff0000}Pizzaboy {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}64 km/h"
	tram = "ID: {ff0000}449 {ffffff}| Model: {ff0000}Tram {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	articletrailer2 = "ID: {ff0000}450 {ffffff}| Model: {ff0000}Article Trailer 2 {ffffff}| Price: {ff0000}N/A {ffffff}| Max speed: {ff0000}N/A"
	infa = {["articletrailer2"]=articletrailer2, ["450"]=articletrailer2, ["tram"]=tram, ["449"]=tram, ["pizzaboy"]=pizzaboy, ["448"]=pizzaboy, ["seasparrow"]=seasparrow, ["447"]= seasparrow, ["squallo"]=squallo, ["446"]=squallo, ["admiral"]=admiral, ["445"]=admiral, ["monster"]= monster, ["444"]= monster, ["packer"]=packer, ["443"]=packer, ["romero"]=romero, ["442"]=romero, ["rcbandit"]=rcbandit, ["441"]=rcbandit, ["rumpo"]=rumpo, ["440"]=rumpo, ["stallion"]=stallion, ["439"]= stallion, ["cabbie"]=cabbie, ["438"]=cabbie, ["coach"]=coach, ["437"]=coach, ["previon"]=previon, ["436"]=previon, ["articletrailer"]=articletrailer, ["435"]=articletrailer, ["hotknife"]=hotknife, ["434"]=hotknife, ["barracks"]=barracks, ["433"]=barracks, ["rhino"]= rhino, ["432"]=rhino, ["bus"]=bus, ["431"]=bus, ["enforcer"]=enforcer, ["427"]=enforcer, ["securicar"]=securicar, ["428"]=securicar, ["banshee"]=banshee, ["429"]=banshee, ["predator"]=predator, ["430"]= predator, ["premier"]=premier, ["426"]=premier,["hunter"]=hunter, ["425"]=hunter, ["bfinjection"]=bfinjection, ["424"]=bfinjection, ["mrwhoopee"]=mrwhoopee, ["423"]=mrwhoopee, ["bobcat"]=bobcat, ["422"]=bobcat, ["washington"]=washington, ["421"]=washington, ["taxi"]=taxi, ["420"]=taxi, ["esperanto"]=esperanto, ["419"]=esperanto, ["moonbeam"]=moonbeam, ["418"]=moonbeam, ["leviathan"]=leviathan, ["417"]=leviathan, ["ambulance"]=ambulance, ["416"]=ambulance, ["cheetah"]=cheetah, ["415"]=cheetah, ["mule"]=mule, ["414"]=mule, ["pony"]=pony, ["413"]=pony, ["voodoo"]=voodoo, ["412"]=voodoo, ["infernus"]=infernus, ["411"]=infernus, ["manana"]=manana, ["410"]= manana, ["stretch"]=stretch, ["409"]=stretch, ["trashmaster"]=trashmaster, ["408"]=trashmaster, ["firetruck"]=firetruck, ["407"]=firetruck, ["dumper"]=dumper, ["406"]=dumper, ["sentinel"]=sentinel, ["405"]=sentinel, ["perenniel"]=perenniel, ["404"]=perenniel, ["linerunner"]=linerunner, ["403"]=linerunner, ["buffalo"]=buffalo, ["402"]=buffalo, ["bravura"]=bravura, ["401"]=bravura, ["landstalker"]=landstalker, ["400"]= landstalker, ["tampa"]=tampa, ["549"]=tampa, ["picador"]=picador, ["600"]=picador, ["oceanic"]=oceanic, ["467"]=oceanic, ["nebula"]=nebula, ["516"]=nebula, ["sultan"]=sultan, ["560"]=sultan, ["glendale"]=glendale, ["466"]=glendale, ["clover"]=clover, ["542"]=clover, ["greenwood"]=greenwood, ["592"]=greenwood, ["majestic"]=majestic, ["517"]=majestic}
end