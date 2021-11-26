;--------------------------------------------------------------------------------------------------------
;	AutoHotKey for normal work
;	Date created: 2021.3.13
;	Date of last edit: 2021.3.13
;	Version: 1.0
;	Logging:
;			1.Generates folder stucture for organizing video projects
;			2.Open these folder by pressing dedicated keys
;			3.Always on top function
;																			----by Peter Xu
;
;--------------------------------------------------------------------------------------------------------
AllOff:					;Sets all folder hotkeys to "Off"(initial state)
Hotkey, ^F3, Off
Hotkey, ^F4, Off
Hotkey, ^F5, Off
Hotkey, ^F6, Off
Hotkey, ^F7, Off
return

;InputBox prompts for active folder location / Error handing
^F2::
	InputBox, DirectoryName, Set Active Project Folder, Enter active folder path:,, 300, 130,,,,,%DirectoryName%
	;Input Box prompts to set active folder location
	if (ErrorLevel = 1) {
		return
	}
	else if FileExist(DirectoryName) {		;Checks if file path is valid;if TRUE, hotkeys ON
		MsgBox,, Active Folder Set, Active Folder: %DirectoryName%.,2
		Hotkey, ^F3, On
		Hotkey, ^F4, On
		Hotkey, ^F5, On
		Hotkey, ^F6, On
		Hotkey, ^F7, On
		return
	}
	else if (DirectoryName = "") {	;Checks if user entered nothing
		MsgBox,,Hotkdys OFF, Entry field blank., 2
		gosub, Alloff
		return
	}
	else {
		MsgBox,,HotKeys OFF, Inbalid file path., 2
		gosub, AllOff
		return
	}
; Hotkeys access each folder individually if it exits-------------------------
^F3::
if FileExist(DirectoryName "/01Footage")
		run, %DirectoryName%/01Footage
		return

^F4::
if FileExist(DirectoryName "/02Resource")
		run, %DirectoryName%/02Resource
		return

^F5::
if FileExist(DirectoryName "/03Audio")
		run, %DirectoryName%/03Audio
		return

^F6::
if FileExist(DirectoryName "/04Proxy")
		run, %DirectoryName%/04Proxy
		return

^F7::
if FileExist(DirectoryName "/05Render")
		run, %DirectoryName%/05Render
		return









; Creat Folder Structure (5 folders)----------------------------------------------------------
#IfWinActive ahk_class CabinetWClass    ;Checks that a File Explorer window is the active window


^F1::
CreatFolder("01Footage")
CreatFolder("02Resource")
CreatFolder("03Audio")
CreatFolder("04Proxy")
CreatFolder("05VFX")
CreatFolder("06VRender")

CreatFolder(FolderName)
	{
	Send, ^+n
	Send, %FolderName%
	Send, {Enter}
	Sleep, 1000
	}
	return
#If

; Always on Top--------------------------------------------------------------------------------
^F8:: Winset, Alwaysontop, , A ; ctrl + space
Return



; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
;^!Numpad0::DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0) ; Hibernate
^F9::DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0) ; Suspend



















































