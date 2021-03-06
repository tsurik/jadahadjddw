script_name("AdminHelper")
script_version("1.0") 
script_author("Anthony_Martini")
script_version_number(5)

local inicfg = require 'inicfg'
local tag = '[AdminHelper]{FFFFFF} ' 
local sampev = require 'lib.samp.events'
local key = require 'vkeys'
local id = "-1"
local idd = "1"
local http = require 'socket.http'
local encoding = require 'encoding' -- ��������� ����������
encoding.default = 'CP1251' -- ��������� ��������� �� ���������, ��� ������ ��������� � ���������� �����. CP1251 - ��� Windows-1251
u8 = encoding.UTF8 -- � ������ �������� ��������� ��� ����������� UTF-8
require "lib.moonloader"
local respavn = false
local unload = false
local hpall = false
local check = true
local recon = false
local samp = require 'samp.events'
local ffi = require 'ffi'
local memory = require 'memory'
local infa = {["articletrailer2"]=articletrailer2, ["450"]=articletrailer2, ["tram"]=tram, ["449"]=tram, ["pizzaboy"]=pizzaboy, ["448"]=pizzaboy, ["seasparrow"]=seasparrow, ["447"]= seasparrow, ["squallo"]=squallo, ["446"]=squallo, ["admiral"]=admiral, ["445"]=admiral, ["monster"]= monster, ["444"]= monster, ["packer"]=packer, ["443"]=packer, ["romero"]=romero, ["442"]=romero, ["rcbandit"]=rcbandit, ["441"]=rcbandit, ["rumpo"]=rumpo, ["440"]=rumpo, ["stallion"]=stallion, ["439"]= stallion, ["cabbie"]=cabbie, ["438"]=cabbie, ["coach"]=coach, ["437"]=coach, ["previon"]=previon, ["436"]=previon, ["articletrailer"]=articletrailer, ["435"]=articletrailer, ["hotknife"]=hotknife, ["434"]=hotknife, ["barracks"]=barracks, ["433"]=barracks, ["rhino"]= rhino, ["432"]=rhino, ["bus"]=bus, ["431"]=bus, ["enforcer"]=enforcer, ["427"]=enforcer, ["securicar"]=securicar, ["428"]=securicar, ["banshee"]=banshee, ["429"]=banshee, ["predator"]=predator, ["430"]= predator, ["premier"]=premier, ["426"]=premier,["hunter"]=hunter, ["425"]=hunter, ["bfinjection"]=bfinjection, ["424"]=bfinjection, ["mrwhoopee"]=mrwhoopee, ["423"]=mrwhoopee, ["bobcat"]=bobcat, ["422"]=bobcat, ["washington"]=washington, ["421"]=washington, ["taxi"]=taxi, ["420"]=taxi, ["esperanto"]=esperanto, ["419"]=esperanto, ["moonbeam"]=moonbeam, ["418"]=moonbeam, ["leviathan"]=leviathan, ["417"]=leviathan, ["ambulance"]=ambulance, ["416"]=ambulance, ["cheetah"]=cheetah, ["415"]=cheetah, ["mule"]=mule, ["414"]=mule, ["pony"]=pony, ["413"]=pony, ["voodoo"]=voodoo, ["412"]=voodoo, ["infernus"]=infernus, ["411"]=infernus, ["manana"]=manana, ["410"]= manana, ["stretch"]=stretch, ["409"]=stretch, ["trashmaster"]=trashmaster, ["408"]=trashmaster, ["firetruck"]=firetruck, ["407"]=firetruck, ["dumper"]=dumper, ["406"]=dumper, ["sentinel"]=sentinel, ["405"]=sentinel, ["perenniel"]=perenniel, ["404"]=perenniel, ["linerunner"]=linerunner, ["403"]=linerunner, ["buffalo"]=buffalo, ["402"]=buffalo, ["bravura"]=bravura, ["401"]=bravura, ["landstalker"]=landstalker, ["400"]= landstalker, ["tampa"]=tampa, ["549"]=tampa, ["picador"]=picador, ["600"]=picador, ["oceanic"]=oceanic, ["467"]=oceanic, ["nebula"]=nebula, ["516"]=nebula, ["sultan"]=sultan, ["560"]=sultan, ["glendale"]=glendale, ["466"]=glendale, ["clover"]=clover, ["542"]=clover, ["greenwood"]=greenwood, ["592"]=greenwood, ["majestic"]=majestic, ["517"]=majestic}
local scrptnum = 5
local PlayersNickname = {}
local name = "n1lnickname3"
local captnak = false
local statwarns = false
local nrpnicks = ""
local grovewarns = 0
local ballaswarns = 0
local aztecwarns = 0
local rifawarns = 0
local vagoswarns = 0
local bandclists = {["4291559679"]="Ballas", ["4278242559"]="Aztec", ["4284901119"]="Rifa", ["4278229248"]="Grove", ["4294954240"]="Vagos", ["2236962"]="mask"}
local checkst = false
local ansrecon = false
local sss = {"DM", "dm", "��", "��", "��", "��", "SK", "sk", "��", "��", "tk", "TK", "cheat", "Cheat", "���", "chit", "���", "aim", "�������", "rampage", "off", "���", "��� ��� ������", "afk ��� ������", "�����", "�����", "��� ��", "non rp", "���-��", "NonRP", "�����", "non-rp", "non rp", "Non RP", "non RP", "Dm", "��", "�������", "�������", "��������", "��", "����", "cleo", "������", "��� �����", "���������", "������", "slient", "����"}

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
	f:write("[settings]\ncolor1=0\ncolor2=0\ngg=�������� ���� � �������� ���������� �� Advance RP Silver =]\nprm=������� �������� - arp_s7 ; �����-�������� - arps_ghetto\nnet=��� ������� '���_�������' �������� ����� '�����' (9 ���).\njb=�������� ������ �� forum.advance-rp.ru(� �����)\najb=���� �� �� �������� � ����������, ������ ������ �� �����.\nrp=������� Role-Play �����, �������� ���� :]\noftp=���������� �� ��������� (��� ������� ����� ������������ ��������)\nnapom=true\nacolor=off\nanscolor=0xDAA520\nadSF=false\ncounter_capture=true\nhotkeys=false") 
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
	else sampAddChatMessage(tag.. "������ ������ ������������ ��� ������������� ������������� �� �������� Advance RP", 0xFFA500) unload = true thisScript():unload() end
	if unload == false then sampAddChatMessage(tag .. "" .. thisScript().name .. " ������� ��������. ID ������: {FFDAB9}" .. scrptnum .. "{ffffff}. ����������� �������: {4682B4}Anthony_Martini", 0xFFA500)  sampAddChatMessage(tag .. "������ �� �������: {FFA500}/hhelp{ffffff}. ��������� ����������� {ff6666}:3", 0xFFA500) if check == false then sampAddChatMessage(tag.. "{ff0000}��������! {ffffff}���������� ������ ��� ���������, ��������� {FFDAB9}/aset", 0xFFA500) end end
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
	sampRegisterChatCommand("cwarns", capturewarns)
	sampRegisterChatCommand("wst", statwarns)
	sampRegisterChatCommand("nrpnicks", nonrpnicknames)
	sampRegisterChatCommand("counter", warnscounter)
	sampRegisterChatCommand("bwarn", bandwarn)
	thread = lua_thread.create_suspended(thread_function)
	ini = inicfg.load(nil, "moonloader\\ah\\config.ini")
	kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	if ini == nil then
		gg = "�������� ���� � �������� ���������� �� Advance RP Silver =]"
		prm = "������� �������� - arp_s7 ; �����-�������� - arps_ghetto"
		net = "��� ������� '���_�������' �������� ����� '�����' (9 ���)."
		jb = "�������� ������ �� forum.advance-rp.ru (� �����)"
		ajb = "���� �� �� �������� � ����������, ������ ������ �� �����."
		rp = "������� Role-Play �����, �������� ���� :]"
		oftp = "���������� �� ��������� (��� ������� ����� ������������ ��������)"
		acolor = "off"
		anscolor = "0xDAA520"
		napom = true
		color1 = 0
		color2 = 0
		adSF = false
		counter_capture = true
		hotkeys = false
	end
	while true do
		wait(0)
		if hotkeys == true then
			if isKeyDown(18) and isKeyJustPressed(49) then
				sampSetChatInputText("/sp ")
				sampSetChatInputEnabled(true)
			end
			if isKeyDown(18) and isKeyJustPressed(50) then
				if reidd == nil or reid == nil or not ansrecon then
					sampSetChatInputText("/re ")
				elseif reidd ~= nil and reid ~= nil and ansrecon then
					sampSetChatInputText("/re " .. reid .. " " ..reidd)
				end
				sampSetChatInputEnabled(true)
			end
			if isKeyDown(18) and isKeyJustPressed(51) then
				if rid == nil or not answer then
					sampSetChatInputText("/ans ")
				else
					sampSetChatInputText("/ans " .. rid .. " ")
				end
				sampSetChatInputEnabled(true)
			end
			if isKeyDown(18) and isKeyJustPressed(52) then
				sampShowDialog(321, "{FFA500}" .. tag .. "������ ����������", "{ffffff}�� ������� ��� ������ ������ ���������?", "��", "���")
			end
			if isKeyDown(18) and isKeyJustPressed(53) then
				if respavn == false then
					sampAddChatMessage(tag.. "������� ���������� ��� ��� ��� ������������� �������� ({FFDAB9}Alt + 5{ffffff}).", 0xFFA500)
					respavn = true
				else
					sampSendChat("/respv -1")
					respavn = false
				end
			end
			if isKeyDown(18) and isKeyJustPressed(48) then
				if hpall == false then
					sampAddChatMessage(tag.. "������� ���������� ��� ��� ��� ������������� �������� ({FFDAB9}Alt + 0{ffffff}).", 0xFFA500)
					hpall = true
				else
					sampSendChat("/hpall 100")
					hpall = false
				end
			end
		end
		if napom == true then
			if os.date("%M",os.time()) == "59" and os.date("%S",os.time()) == "00" then
				sampAddChatMessage(tag.. "{ff0000}��������! {ffffff}Payday ����� ����� {FFDAB9}1 ������{ffffff}. �� �������� � AFK =]", 0xFFA500)
				wait(1000)
			end 
		end
		--sampSendChat("/vec 510 " ..color1.. " " ..color2)
		local resultMain, buttonMain, listMain = sampHasDialogRespond(321)
		if resultMain == true then
			if buttonMain == 1 then
				sampSendChat("/vec 510 " ..color1.. " " ..color2)
				sampAddChatMessage(tag.. "��������� ��� �����.", 0xFFA500)
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(0)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampShowDialog(10, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/gg", "{FFA500}������� �����: {ffffff}" ..gg, "������.", "�����", 1)
				end
				if listMain == 1 then
					sampShowDialog(11, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/prm", "{FFA500}������� �����: {ffffff}" ..prm, "������.", "�����", 1)
				end
				if listMain == 2 then
					sampShowDialog(12, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/net", "{FFA500}������� �����: {ffffff}" ..net, "������.", "�����", 1)
				end
				if listMain == 3 then
					sampShowDialog(13, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/jb", "{FFA500}������� �����: {ffffff}" ..jb, "������.", "�����", 1)
				end
				if listMain == 4 then
					sampShowDialog(14, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/ajb", "{FFA500}������� �����: {ffffff}" ..ajb, "������.", "�����", 1)
				end
				if listMain == 5 then
					sampShowDialog(15, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/rp", "{FFA500}������� �����: {ffffff}" ..rp, "������.", "�����", 1)
				end
				if listMain == 6 then
					sampShowDialog(16, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/oftp", "{FFA500}������� �����: {ffffff}" ..oftp, "������.", "�����", 1)
				end
				if listMain == 7 then
					sampShowDialog(20, "{FFA500}" ..tag.. "��������� ����� {FFA500}/a", "{FFA500}������� ����: {ffffff}" ..acolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����] {ffffff}��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
				end
				if listMain == 8 then
					sampShowDialog(21, "{FFA500}" ..tag.. "��������� ����� {FFA500}/ans", "{FFA500}������� ����: {ffffff}" ..anscolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����]{ffffff} ��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
				end
				if listMain == 9 then
					if napom == true then ini.settings.napom = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "����������� � �������� {ff0000}���������", 0xFFA500) 
					elseif napom == false then ini.settings.napom = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "����������� � �������� {00ff00}��������", 0xFFA500) end
				end
				if listMain == 10 then
					if adSF == true then ini.settings.adSF = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ���������� � SF-������� {ff0000}���������", 0xFFA500) 
					elseif adSF == false then ini.settings.adSF = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ���������� � SF-������� {00ff00}��������", 0xFFA500) end
				end
				if listMain == 11 then
					if counter_capture == true then ini.settings.counter_capture = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ������ ��� ������ {ff0000}��������", 0xFFA500) 
					elseif counter_capture == false then ini.settings.counter_capture = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ������ ��� ������ {00ff00}�������", 0xFFA500) end
				end
				if listMain == 12 then
					if hotkeys == true then ini.settings.hotkeys = false inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ������� {ff0000}���������", 0xFFA500) 
					elseif hotkeys == false then ini.settings.hotkeys = true inicfg.save(ini, "moonloader\\ah\\config.ini") sampAddChatMessage(tag.. "������� ������� {00ff00}��������", 0xFFA500) end
				end
				if listMain == 13 then
					sampShowDialog(17, "{FFA500}" ..tag.. "������������� ��������", "{ffffff}�� ������������� ������ ������� ����������� ��������?", "��", "�����", 0)
				end
			end
		end
		local resultMain, buttonMain, listMain = sampHasDialogRespond(17)
		if resultMain == true then
			if buttonMain == 1 then
				stznach()
				sampAddChatMessage(tag.. "����������� �������� ������.", 0xFFA500)
				inicfg.save(ini, "moonloader\\ah\\config.ini")
			else
				asettings()
			end
		end
		local resultInput, buttonInput, listInput, inputgg = sampHasDialogRespond(10)
		if resultInput == true then
			if buttonInput == 1 then
				if #inputgg == 0 then
					sampShowDialog(10, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/gg", "{FFA500}������� �����: {ffffff}" ..gg, "������.", "�����", 1)
				else
					if #inputgg < 10 then
						sampShowDialog(10, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/gg", "{FFA500}������� �����: {ffffff}" ..gg, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.gg = inputgg
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(11, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/prm", "{FFA500}������� �����: {ffffff}" ..prm, "������.", "�����", 1)
				else
					if #inputprm < 10 then
						sampShowDialog(11, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/prm", "{FFA500}������� �����: {ffffff}" ..prm, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.prm = inputprm
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(12, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/net", "{FFA500}������� �����: {ffffff}" ..net, "������.", "�����", 1)
				else
					if #inputnet < 10 then
						sampShowDialog(12, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/net", "{FFA500}������� �����: {ffffff}" ..net, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.net = inputnet
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(13, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/jb", "{FFA500}������� �����: {ffffff}" ..jb, "������.", "�����", 1)
				else
					if #inputjb < 10 then
						sampShowDialog(13, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/jb", "{FFA500}������� �����: {ffffff}" ..jb, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.jb = inputjb
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(14, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/ajb", "{FFA500}������� �����: {ffffff}" ..ajb, "������.", "�����", 1)
				else
					if #inputajb < 10 then
						sampShowDialog(14, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/ajb", "{FFA500}������� �����: {ffffff}" ..ajb, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.ajb = inputajb
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(15, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/rp", "{FFA500}������� �����: {ffffff}" ..rp, "������.", "�����", 1)
				else
					if #inputrp < 10 then
						sampShowDialog(15, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/rp", "{FFA500}������� �����: {ffffff}" ..rp, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.rp = inputrp
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(16, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/oftp", "{FFA500}������� �����: {ffffff}" ..oftp, "������.", "�����", 1)
				else
					if #inputoftp < 10 then
						sampShowDialog(16, "{FFA500}" ..tag.. "�������������� ������� {FFA500}/oftp", "{FFA500}������� �����: {ffffff}" ..oftp, "������.", "�����", 1)
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
					else
						ini.settings.oftp = inputoftp
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(20, "{FFA500}" ..tag.. "��������� ����� {FFA500}/a", "{FFA500}������� ����: {ffffff}" ..acolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����] {ffffff}��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
				else
					if inputacolor == "off" then
						ini.settings.acolor = inputacolor
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "��������� ����� /a {ff0000}���������{ffffff}.", 0xFFA500)
					else
						if #inputacolor < 8 then
							sampShowDialog(20, "{FFA500}" ..tag.. "��������� ����� {FFA500}/a", "{FFA500}������� ����: {ffffff}" ..acolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����] {ffffff}��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
						else
							ini.settings.acolor = inputacolor
							inicfg.save(ini, "moonloader\\ah\\config.ini")
							sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
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
					sampShowDialog(21, "{FFA500}" ..tag.. "��������� ����� {FFA500}/ans", "{FFA500}������� ����: {ffffff}" ..anscolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����]{ffffff} ��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
				else
					if inputanscolor == "off" then
						ini.settings.anscolor = inputanscolor
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "��������� ����� /ans {ff0000}���������{ffffff}.", 0xFFA500)
					else
						if #inputanscolor < 8 then
							sampShowDialog(21, "{FFA500}" ..tag.. "��������� ����� {FFA500}/ans", "{FFA500}������� ����: {ffffff}" ..anscolor.. "\n{ff0000}[!] {ffffff}����������� {FFA500}0x[html ����]{ffffff} ��� {FFA500}off {ffffff}��� ���������� ������� {ff0000}[!]", "������.", "�����", 1)
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������� ��������� ���������� ��������", 0xFFA500)
						else
							ini.settings.anscolor = inputanscolor
							inicfg.save(ini, "moonloader\\ah\\config.ini")
							sampAddChatMessage(tag.. "���������� ������ ������ �������.", 0xFFA500)
						end
					end
				end
			else 
				asettings()
			end
		end
		if ini ~= nil then
			prm = ini.settings.prm
			gg = ini.settings.gg
			net = ini.settings.net
			jb = ini.settings.jb
			ajb = ini.settings.ajb
			rp = ini.settings.rp
			oftp = ini.settings.oftp
			acolor = ini.settings.acolor
			anscolor = ini.settings.anscolor
			napom = ini.settings.napom
			color1 = ini.settings.color1
			color2 = ini.settings.color2
			adSF = ini.settings.adSF
			counter_capture = ini.settings.counter_capture
			hotkeys = ini.settings.hotkeys
		end
		if prm == nil then prm = "������� �������� - arp_s7 ; �����-�������� - arps_ghetto" end
		if gg == nil then gg = "�������� ���� � �������� ���������� �� Advance RP Silver =]" end
		if net == nil then net = "��� ������� '���_�������' �������� ����� '�����' (9 ���)." end
		if jb == nil then jb = "�������� ������ �� forum.advance-rp.ru (� �����)" end
		if ajb == nil then ajb = "���� �� �� �������� � ����������, ������ ������ �� �����." end
		if rp == nil then rp = "������� Role-Play �����, �������� ���� :]" end
		if oftp == nil then oftp = "���������� �� ��������� (��� ������� ����� ������������ ��������)" end
		if acolor == nil then acolor = "off" end
		if anscolor == nil then anscolor = "0xDAA520" end
		if napom == nil then napom = true end
		if color1 == nil then color1 = "0" end
		if color2 == nil then color2 = "0" end
		if adSF == nil then adSF = false end
		if counter_capture == nil then counter_capture = true end
		if hotkeys == nil then hotkeys = false end
	end
end

function asettings()
	if napom == true then vnapom = "{00FF00}��������"
	elseif napom == false then vnapom = "{ff0000}���������" end
	if adSF == true then vadSF = "{00ff00}��������"
	elseif adSF == false then vadSF = "{ff0000}���������" end
	if counter_capture == true then vcounter_capture = "{00ff00}��������"
	elseif counter_capture == false then vcounter_capture = "{ff0000}���������" end
	if acolor == "off" then vacolor = "{ff0000}���������"
	else vacolor = acolor end
	if anscolor == "off" then vanscolor = "{ff0000}���������"
	else vanscolor = anscolor end
	if hotkeys == false then vhotkeys = "{ff0000}���������"
	elseif hotkeys == true then vhotkeys = "{00ff00}��������" end
	sampShowDialog(0, "{FFA500}" ..tag.. "��������� �������", "{FFA500}�������\t{ffffff}������� ��������\n{FFA500}/gg\t{ffffff}" ..gg.. "\n{FFA500}/prm\t{ffffff}" ..prm.. "\n{FFA500}/net\t{ffffff}" ..net.. "\n{FFA500}/jb\t{ffffff}" ..jb.."\n{FFA500}/ajb\t{ffffff}" ..ajb.. "\n{FFA500}/rp\t{ffffff}" ..rp.. "\n{FFA500}/oftp\t{ffffff}" ..oftp.. "\n{FFA500}���� /a\t{ffffff}" ..vacolor.. "\n{FFA500}���� /ans\t{ffffff}" ..vanscolor.. "\n{FFA500}����������� � �� \t" ..vnapom.. "\n{FFA500}/ad � SF-�������\t" ..vadSF.. "\n{FFA500}������� ������\t" ..vcounter_capture.. "\n{FFA500}������� �������\t" ..vhotkeys.. "\n{008000}������� ����������� ��������", "��", "������", 5)
end

function test()
	if recon == true then
		vrecon = "on"
	else
		vrecon = "off"
	end
	sampAddChatMessage("Server Number: " ..server.. " | Server Name: " ..server_name.. " | ServerIP: " ..sampGetCurrentServerAddress(), -1)
	sampAddChatMessage("Recon Status: " ..vrecon.. " | Recon id: " ..id.. " | Recon idd: " ..idd.. " | SPname: " ..name, -1)
end

function admhelp()
	if hotkeys == true then hkhelp = "{00ff00}[������� �������]"
	else hkhelp = "{ff0000}[������� �������]" end
	sampShowDialog(10000, "{FFA500}" .. tag.. "������ �� �������", "{FFA500}/aset - {ffffff}��������� �������\n{FFA500}/ahupdate - {ffffff}��������� ������ �� ������� ����������\n{FFA500}/re - {ffffff}������ ������ �� ������\n{FFA500}/pn - {ffffff}''����� ������� ���������''\n{FFA500}/reoff - {ffffff}''��������� �� ����������'' (/reoff -1 ��� ���������)\n{FFA500}/bwarn - {ffffff}������ ���� ��������� �����\n{FFA500}/counter - {ffffff}�������������� ����������� �������� ������\n{FFA500}/cwarns - {ffffff}������� ������ � ������ ��������� �������\n{FFA500}/nrpnicks - {ffffff}������ �� ����� ����\n{FFA500}/slap - {ffffff}����� ������\n{FFA500}/cinf - {ffffff}���������� � ����������\n{FFA500}/spoff - {ffffff}����� �� ������ (�������� ��� ���� ������)\n{FFA500}/v - {ffffff}���������� /vec\n{FFA500}/vcol - {ffffff}�������� ���� �� � /v\n{FFA500}/tt - {ffffff}�������� ������ �����\n{FFA500}/gg - {ffffff}�������� �������� ����\n{FFA500}/net - {ffffff}�������� � ����� ����\n{FFA500}/rp - {ffffff}'������� �� �����'\n{FFA500}/prm - {ffffff}������� ��������\n{FFA500}/jb - {ffffff}'������ ������ �� �����'\n{FFA500}/ajb - {ffffff}'�� �������� � ���������� - ������ �� �� ���'\n{FFA500}/oftp - {ffffff}������� �� ���������\n\t\t" ..hkhelp.. "\n{FFA500}Alt+1 - {ffffff}/sp\n{FFA500}Alt+2 - {ffffff}/re �� ������ � ������\n{FFA500}Alt+3 - {ffffff}/ans ���������� ����������� � ������\n{FFA500}Alt+4 - {ffffff}������ ���������\n{FFA500}Alt+5 - {ffffff}������� ���� � ���� ���������\n{FFA500}Alt+0 - {ffffff}������ �������� � ������� (��� ��)", "��")
end

function spoff()
	sampAddChatMessage(tag.. "�� ����� �� ������ ��������.", 0xFFA500)
	sampSendMenuSelectRow(0)
end

function bandwarn(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /bwarn [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /bwarn [id ������]", 0xFFA500)
		elseif arg < 0 or arg > 999 then
			sampAddChatMessage(tag.. "����������� /bwarn [id ������]", 0xFFA500)
		elseif sampIsPlayerConnected(arg) then
			clr = sampGetPlayerColor(arg)
			clr = tostring(clr)
			bands = bandclists[clr]
			if bands ~= "mask" and bands ~= nil then
				sampSendChat("/warn " .. arg .. " ��������� ������ ����� [" .. bands .. "]", -1)
			else
				if bands == nil then
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}����� � ������ ID �� ������� � �����.", 0xFFA500)
				end
				if bands == "mask" then
					wid = arg
					sampSendChat("/st " .. arg)
					checkst = true
				end
			end
		else
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ������ ID ��� �� �������.", 0xFFA500)
		end
	end
end

function veci(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /v [id ����������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /v [id ����������]", 0xFFA500)
		else
			if arg < 400 or arg > 611 then
				sampAddChatMessage(tag.. "{ff0000}������. {ffffff}ID ���������� ��������� � ������� �� 400 �� 611.", 0xFFA500)
			else
				sampSendChat("/vec " ..arg.. " " ..color1.. " " ..color2)
				sampAddChatMessage(tag.. "��������� ������: {FFDAB9}ID " ..arg, 0xFFA500)
			end
		end
	end
end

function warnscounter(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /counter [�����/null ��� ���������] [��������, ������� ������ �������� (��������, -1)]", 0xFFA500)
	else
		banda, value = string.match(arg, "(.+) (.+)")
		if arg == "null" then
			grovewarns = 0
			ballaswarns = 0
			rifawarns = 0
			aztecwarns = 0
			vagoswarns = 0
			statwarns = false
			sampAddChatMessage(tag.. "������� ��� ������� �������", 0xFFA500)
		else
			if value == nil then
				sampAddChatMessage(tag.. "����������� /counter [�����/null ��� ���������] [��������, ������� ������ �������� (��������, -1)]", 0xFFA500)
			else
				value = tonumber(value)
				if type(value) == "number" then
					if banda == "grove" then
						if grovewarns+value > -1 and value ~= 0 then
							grovewarns = grovewarns+value
							sampAddChatMessage(tag.. "���������� ������ ���������.", 0xFFA500)
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� �� ����� �������� ������������� �������� ��� 0.", 0xFFA500)
						end
					elseif banda == "ballas" then
						if ballaswarns+value > -1 and value ~= 0 then
							ballaswarns = ballaswarns+value
							sampAddChatMessage(tag.. "���������� ������ ���������.", 0xFFA500)
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� �� ����� �������� ������������� �������� ��� 0.", 0xFFA500)
						end
					elseif banda == "rifa" then
						if rifawarns+value > -1 and value ~= 0 then
							rifawarns = rifawarns+value
							sampAddChatMessage(tag.. "���������� ������ ���������.", 0xFFA500)
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� �� ����� �������� ������������� �������� ��� 0.", 0xFFA500)
						end
					elseif banda == "aztec" then
						if aztecwarns+value > -1 and value ~= 0 then
							aztecwarns = aztecwarns+value
							sampAddChatMessage(tag.. "���������� ������ ���������.", 0xFFA500)
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� �� ����� �������� ������������� �������� ��� 0.", 0xFFA500)
						end
					elseif banda == "vagos" then
						if vagoswarns+value > -1 and value ~= 0 then
							vagoswarns = vagoswarns+value
							sampAddChatMessage(tag.. "���������� ������ ���������.", 0xFFA500)
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� �� ����� �������� ������������� �������� ��� 0.", 0xFFA500)
						end
					end
				else
					sampAddChatMessage(tag.. "����������� /counter [�����/null ��� ���������] [��������, ������� ������ �������� (��������, -1)]", 0xFFA500)
				end
			end
		end
	end
end

function capturewarns()
	if grovewarns > 0 then
		grove = "{009900}| Grove: " ..grovewarns.. " |"
	else
		grove = ""
	end
	if ballaswarns > 0 then
		ballas = "{cc00ff}| Ballas: " ..ballaswarns.. " |"
	else
		ballas = ""
	end
	if aztecwarns > 0 then
		aztec = "{00ccff}| Aztec: " ..aztecwarns.. " |"
	else
		aztec = ""
	end
	if vagoswarns > 0 then
		vagos = "{ffcd00}| Vagos: " ..vagoswarns.. " |"
	else
		vagos = ""
	end
	if rifawarns > 0 then
		rifa = "{6665ff}| Rifa: " ..rifawarns.. " |"
	else
		rifa = ""
	end
	if rifawarns == 0 and grovewarns == 0 and ballaswarns == 0 and aztecwarns == 0 and vagoswarns == 0 then
		grove = "{FFDAB9}������� ������ ����"
		ballas = ""
		vagos = ""
		rifa = ""
		aztec = ""
	end
	sampAddChatMessage(tag.. "���������� ������: " ..grove.. "" ..ballas.. "" ..aztec.. "" ..vagos.. "" ..rifa, 0xFFA500)
end

function statwarns()
	if statwarns == true then
		if grovewarns > 0 then
			grove = "| Grove: " ..grovewarns.. " |"
		else
			grove = ""
		end
		if ballaswarns > 0 then
			ballas = "| Ballas: " ..ballaswarns.. " |"
		else
			ballas = ""
		end
		if aztecwarns > 0 then
			aztec = "| Aztec: " ..aztecwarns.. " |"
		else
			aztec = ""
		end
		if vagoswarns > 0 then
			vagos = "| Vagos: " ..vagoswarns.. " |"
		else
			vagos = ""
		end
		if rifawarns > 0 then
			rifa = "| Rifa: " ..rifawarns.. " |"
		else
			rifa = ""
		end
		sampSendChat("/msg 1 ���������� ��������������: " ..grove.. "" ..ballas.. "" ..aztec.. "" ..vagos.. "" ..rifa)
		statwarns = false
	end
end

function ttime(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /tt [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /tt [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /tt [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..os.date("%d.%m.%Y").. " " ..os.date("%X",os.time()))
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function quit()
	sampAddChatMessage(tag.. "������ ������� ���� ���������.", 0xFFA500)
	thisScript():unload()
end

function cinformation(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /cinf [id/�������� ���� (� ���������)]", 0xFFA500)
	else
		checkcar()
		inform = infa[arg]
		if inform ~= nil then
			sampAddChatMessage("[AdminHelper] {ffffff}" ..inform, 0xFFA500)
		else
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ �� ���� ���������� �� ����������.", 0xFFA500)
		end
	end
end

function vcolor(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /vcol [id ����� 1] [id ����� 2]", 0xFFA500)
	else
		color1, color2 = string.match(arg, "(.+) (.+)")
		color1 = tonumber(color1)
		if type(color1) ~= "number" then
			sampAddChatMessage(tag.. "����������� /vcol [id ����� 1] [id ����� 2]", 0xFFA500)
		else
			color2 = tonumber(color2)
			if type(color2) ~= "number" then
				sampAddChatMessage(tag.. "����������� /vcol ����������� /vcol [id ����� 1] [id ����� 2]", 0xFFA500)
			else
				if color1 < 0 or color1 > 255 then
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� ID ������ �� 0 �� 255.", 0xFFA500)
				else
					if color2 < 0 or color2 > 255 then
						sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�������� ID ������ �� 0 �� 255.", 0xFFA500)
					else
						ini.settings.color1 = color1
						ini.settings.color2 = color2
						inicfg.save(ini, "moonloader\\ah\\config.ini")
						sampAddChatMessage(tag.. "ID ������ ���������: " ..color1.. ", " ..color2, 0xFFA500)
					end
				end
			end
		end
	end
end

function offtop(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /oftp [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /oftp [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /oftp [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..oftp)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function goodgame(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /gg [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /gg [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /gg [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..gg)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function arecon(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /re [id ������] [id ����������]", 0xFFA500)
	else
		id, idd = string.match(arg, "(.+) (.+)")
		id = tonumber(id)
		if type(id) ~= "number" then
			sampAddChatMessage(tag.. "����������� /re [id ������] [id ����������]", 0xFFA500)
		else
			if id < 0 or id > 999 then
				sampAddChatMessage(tag.. "����������� /re [id ������] [id ����������]", 0xFFA500)
			else
				idd = tonumber(idd)
				if type(idd) ~= "number" then
					sampAddChatMessage(tag.. "����������� /re [id ������] [id ����������]", 0xFFA500)
				else
					if idd < 0 or idd > 999 then
						sampAddChatMessage(tag.. "����������� /re [id ������] [id ����������]", 0xFFA500)
					else
						if sampIsPlayerConnected(id) then
							if sampIsPlayerConnected(idd) then
								name = sampGetPlayerNickname(idd)
								sampAddChatMessage(tag.. "��� ���������� ���������� ����������� {ff0000}/reoff{ffffff}. ���� ����� ������� ��������� {ff0000}/pn", 0xFFA500)
								sampSendChat("/ans " ..id.. " ����� ���������� �� ��������� ���� �������: " ..name.. ".")
								sampSendChat("/sp " ..idd)
								sampSendChat("/sp " ..idd)
								recon = true
							else
								sampSendChat("/ans " ..id.. " ������ ����� ����� �� ���� � � ������ ������ �������.") 
							end
						else
							sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ������ ID ��� �� �������.", 0xFFA500)
						end
					end
				end
			end
		end
	end
end

function nonrpnicknames()
	if nrpnicks == "" then
		sampShowDialog(22820, "{FFA500}" ..tag.. "������� �� ����� ����", "{ffffff}������� �� ����� ���� {ff0000}������", "�������")
	else
		sampShowDialog(22821, "{FFA500}" ..tag.. "������� �� ����� ����", nrpnicks, "�������")
	end
end

function punish(arg)
	if #arg == 0 then
		if recon then
			sampSendChat("/ans " ..id.. " ����� " ..name.. " ������� ���������. �������� ���� =]")
			recon = false
		else
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�� �� �������� ������ �� �������. ������ ������������ {FFDAB9}/pn [id ������]", 0xFFA500)
		end
	end
	arg = tonumber(arg)
	if type(arg) == "number" then
		sampSendChat("/ans " ..arg.. " ����� ������� ��������������� ���������. �������� ���� =]")
	end
end
	
function areconoff(arg)
	if #arg == 0 then
		if recon then
			sampSendChat("/ans " ..id.. " ��������� �� " ..name.. " �� ����������.")
			sampSendMenuSelectRow(0)
			recon = false
		else
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}�� �� �������� ������ �� �������. ������ ������������ {FFDAB9}/reoff [id ������]", 0xFFA500)
		end
	end
	if arg == "-1" then
		sampAddChatMessage(tag.. "������ � ������ ��������", 0xFFA500)
		recon = false
	else
		arg = tonumber(arg)
		if type(arg) == "number" then
			sampSendChat("/ans " ..arg.. " ��������� �� ������ �� ����������. ������ ������ �� �����.")
		end
	end
end

function rrp(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /rp [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /rp [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /rp [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..rp)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function ajaloba(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /ajb [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /ajb [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /ajb [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..ajb)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function promokod(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /prm [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /prm [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /prm [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..prm)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function sampev.onServerMessage(color, text)
--	print(text.. " | " ..color)
-- -10092289 /capture message
--	��������� ���������� -10092289
--	-1717986817
--	-65281 /admins
--	1724645631 "������ ������"
-- 1724645631
	if string.find(color, "-65281", 1, true) and string.find(text, "SMS: ", 1, true) and string.find(text, "�����������:", 1, true) and string.find(text, "ahip26: ", 1, true) then
		_,message, _ = string.match(text, "(.+)ahip26: (.+) | �����������:(.+)")
		if message ~= nil then
			sampSendChat(message, -1)
		end
		return false
	end
	if string.find(color, "1721329407", 1, true) and string.find(text, "[����� non-rp �����]", 1, true) then
		nrpnicks = nrpnicks.. "{FFA500}[" ..os.date("%X",os.time()).. "] {ffffff}" ..text.. "\n"
	end
	if string.find(color, "1724645631", 1, true) and string.find(text, "] :", 1, true) then
		rnick, rtext = string.match(text, "(.+) :(.+)")
		--sampAddChatMessage("rnick: " .. rnick .. " | rtext: " .. rtext, -1)
		rid = string.match(rnick, "(%d+)")
		answer = true
		ridd, rtextt = string.match(rtext, "(%d+) (.+)")
		if ridd ~= nil then
			reid = rid
			reidd = ridd
			reidd = tonumber(reidd)
			--sampAddChatMessage(reidd, -1)
			if type(reidd) == "number" then
				for _, val in pairs(sss) do
					if string.find(rtext, val, 1, true) then
						ansrecon = true
					end
				end
				if reidd < 0 or reidd > 999 then
					ansrecon = false
				end
				if hotkeys and ansrecon then
					sampAddChatMessage(tag.. "����� ������ ������ �� {ff0000}" .. reidd .. " id {ffffff}����������� {FFDAB9}Alt + 2.", 0xFFA500)
					thread:run("ar10sec")
				end
			end
			return true
		end
	end
	if adSF == true then
		if string.find(color, "13369599", 1, true) and string.find(text, "��������", 1, true) then
			print(text)
			return false
		end
		if string.find(color, "10027263", 1, true) and string.find(text, "���������� �������� ��������� ���", 1, true) then
			print(text)
			return false
		end
	end
	if counter_capture == true then
		if string.find(color, "-10092289", 1, true) and string.find(text, "����������� ������", 1, true) then
			sampAddChatMessage(tag.. "������� ��������� {00ff00}�������{ffffff}.", 0xFFA500)
			grovewarns = 0
			ballaswarns = 0
			aztecwarns = 0
			rifawarns = 0
			vagoswarns = 0
			captnak = true
			statwarns = false
		end
		if string.find(color, "-11521793", 1, true) and string.find(text, "��������������", 1, true) and captnak == true then
			if string.find(text, "ballas", 1, true) or string.find(text, "Ballas", 1, true) or string.find(text, "������", 1, true) or string.find(text, "������", 1, true) then
				ballaswarns = ballaswarns+1
			elseif string.find(text, "grove", 1, true) or string.find(text, "Grove", 1, true) or string.find(text, "����", 1, true) or string.find(text, "����", 1, true) then
				grovewarns = grovewarns+1
			elseif string.find(text, "rifa", 1, true) or string.find(text, "Rifa", 1, true) or string.find(text, "����", 1, true) or string.find(text, "����", 1, true) then
				rifawarns = rifawarns+1
			elseif string.find(text, "vagos", 1, true) or string.find(text, "Vagos", 1, true) or string.find(text, "�����", 1, true) or string.find(text, "�����", 1, true) then
				vagoswarns = vagoswarns+1
			elseif string.find(text, "aztec", 1, true) or string.find(text, "Aztec", 1, true) or string.find(text, "�����", 1, true) or string.find(text, "�����", 1, true) then
				aztecwarns = aztecwarns+1
			end
		end
		if captnak == true and string.find(color, "-10092289", 1, true) and (string.find(text, "��������� ����������", 1, true) or string.find(text, "��������� ����������", 1, true)) then
			statwarns = true
			if grovewarns > 0 then
				grove = "{009900}| Grove: " ..grovewarns.. " |"
			else
				grove = ""
			end
			if ballaswarns > 0 then
				ballas = "{cc00ff}| Ballas: " ..ballaswarns.. " |"
			else
				ballas = ""
			end
			if aztecwarns > 0 then
				aztec = "{00ccff}| Aztec: " ..aztecwarns.. " |"
			else
				aztec = ""
			end
			if vagoswarns > 0 then
				vagos = "{ffcd00}| Vagos: " ..vagoswarns.. " |"
			else
				vagos = ""
			end
			if rifawarns > 0 then
				rifa = "{6665ff}| Rifa: " ..rifawarns.. " |"
			else
				rifa = ""
			end
			if rifawarns == 0 and grovewarns == 0 and ballaswarns == 0 and aztecwarns == 0 and vagoswarns == 0 then
				grove = "{FFDAB9}������ �� ����������� ����� �� ���� ������"
				ballas = ""
				vagos = ""
				rifa = ""
				aztec = ""
				statwarns = false
			end
			sampAddChatMessage(tag.. "���������� ������: " ..grove.. "" ..ballas.. "" ..aztec.. "" ..vagos.. "" ..rifa, 0xFFA500)
			if statwarns == true then
				sampAddChatMessage(tag.. "��� ����, ����� �������� ���������� ������ � ����� ���, ����������� {FFDAB9}/wst{ffffff}.", 0xFFA500)
			end
			captnak = false
		end
	end
	if (string.find(color, "-11521793", 1, true)) and string.find(text, name, 1, true) and recon then
		sampAddChatMessage(text, 0xDC143C)
		sampSendChat("/ans " ..id.. " ����� " ..name.. " ������� ���������. �������� ���� =]")
		recon = false
		return false
	end
	if string.find(color, "-1717986817", 1, true) and string.find(text, "������", 1, true) and recon then
		sampAddChatMessage(text, 0xDC143C)
		sampSendChat("/ans " ..id.. " ����� " ..name.. " ������� ���������. �������� ���� =]")
		recon = false
		return false
	end
	if anscolor ~= "off" then
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
			sampAddChatMessage(text, anscolor)
			return false
		end
	end
	if acolor ~= "off" then
		if string.find(color, "-1714683649", 1, true) and string.find(text, "[A]", 1, true) then
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
			sampAddChatMessage(text, acolor)
			return false
		end
	end
end

function net(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /net [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /net [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /net [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..net)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function slap(arg)
if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /slap [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /slap [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /slap [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					slapid = arg
					thread:run("slaper")
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end
	
	
function jaloba(arg)
	if #arg == 0 then
		sampAddChatMessage(tag.. "����������� /jb [id ������]", 0xFFA500)
	else
		arg = tonumber(arg)
		if type(arg) ~= "number" then
			sampAddChatMessage(tag.. "����������� /jb [id ������]", 0xFFA500)
		else
			if arg < 0 or arg > 999 then
				sampAddChatMessage(tag.. "����������� /jb [id ������]", 0xFFA500)
			else
				if sampIsPlayerConnected(arg) then
					sampSendChat("/ans " ..arg.. " " ..jb)
				else
					sampAddChatMessage(tag.. "{ff0000}������. {ffffff}������ � ����� ID ��� �� �������.", 0xFFA500)
				end
			end
		end
	end
end

function sampev.onSendCommand(command)
	chatInput = command
end

function sampev.onShowTextDraw(id, textdraw)
	--print(id, textdraw.color, textdraw.boxColor, textdraw.text)
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if string.find(title, "���������� ������", 1, true) and checkst then
		for w in string.gmatch(text, "[^\r\n]+") do
			if string.find(w, "�����������:", 1, true) then
				org = string.match(w, "�����������:(.+)")
				--sampAddChatMessage(dolzh, -1)
			end
		end
		--sampAddChatMessage(org, -1)
		checkst = false
		if string.find(org, "Ballas", 1, true) then
			bands = "Ballas"
		end
		if string.find(org, "Vagos", 1, true) then
			bands = "Vagos"
		end
		if string.find(org, "Grove", 1, true) then
			bands = "Grove"
		end
		if string.find(org, "Aztecas", 1, true) then
			bands = "Aztec"
		end
		if string.find(org, "Rifa", 1, true) then
			bands = "Rifa"
		end
		if bands ~= nil and bands ~= "mask" then
			sampSendChat("/warn " .. wid .. " ��������� ������ ����� [" .. bands .. "]", -1)
		else
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}����� � ������ ID �� ������� � �����.", 0xFFA500)
		end
		return false
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
	if option == "update" then
		wait(5000)
		obnov = io.open("moonloader\\ah\\version.txt", "r+")
		if obnov == nil then 
			sampAddChatMessage(tag.. "{ff0000}������. {ffffff}��������� ���� �����������.", 0xFFA500)
		else
			obnovv = obnov:read()
			obnovv = tonumber(obnovv)
			if obnovv > scrptnum then
				local dlstatus = require('moonloader').download_status
				downloadUrlToFile("https://github.com/tsurik/jadahadjddw/raw/master/AdminHelper.lua", thisScript().path, function(id, status)
					if status == dlstatus.STATUSENDDOWNLOADDATA then
						thisScript():reload()
					end
				end)
				sampAddChatMessage(tag.. "������ ������� �������� �� ������ {FFDAB9}" ..obnovv.. "{FFFFFF}!", 0xFFA500)
				obnov:close()
				return
			else
				sampAddChatMessage(tag.. "���������� �� ����������. ������ ������ �������� {00ff00}����������{ffffff}.", 0xFFA500)
			end
		end
	end
	if option == "ar10sec" then
		wait(10000)
		ansrecon = false
		sampAddChatMessage(tag.. "����� �������� �������.", 0xFFA500)
	end
end

function update()
	downloadUrlToFile("https://github.com/tsurik/jadahadjddw/raw/master/version.txt", "moonloader\\ah\\version.txt")
	sampAddChatMessage(tag.. "��������������� ���������� � ��������...", 0xFFA500)
	thread:run("update")
end

function stznach()
	ini.settings.gg = "�������� ���� � �������� ���������� �� Advance RP Silver =]"
	ini.settings.prm = "������� �������� - arp_s7 ; �����-�������� - arps_ghetto"
	ini.settings.net = "��� ������� '���_�������' �������� ����� '�����' (9 ���)."
	ini.settings.jb = "�������� ������ �� forum.advance-rp.ru (� �����)"
	ini.settings.ajb = "���� �� �� �������� � ����������, ������ ������ �� �����."
	ini.settings.rp = "������� Role-Play �����, �������� ���� :]"
	ini.settings.oftp = "���������� �� ��������� (��� ������� ����� ������������ ��������)"
	ini.settings.acolor = "off"
	ini.settings.anscolor = "0xDAA520"
	ini.settings.napom = true
	ini.settings.adSF = false
	ini.settings.counter_capture = true
	ini.settings.hotkeys = false
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