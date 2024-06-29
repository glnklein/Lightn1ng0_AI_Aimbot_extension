#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force




Run ,%A_AppData%\Lightn1ng0_AI_Aimbot\run.bat , , Hide, ; Start Lightn1ng0_AI


Text := "F7 Hidden/show square FOV `nF8 Hidden/show circle FOV `nF9   Set Overlay FOV fewer `nF10 Set Overlay FOV stronger `n`nF12 Show/Hide Lightn1ng0_AI`n`nEND Exit Lightn1ng0_AI"

MsiMessageBox(Text, "Lightn1ng0_AI extension v1.05", 0x40)





WinWait , Lightn1ng0 AI Aimbot ; Wait for Lightn1ng0_AI Windows 


WinSet, AlwaysOnTop , , Lightn1ng0 AI Aimbot  ; set Lightn1ng0_AI Windows Always on Top

Trans=55
FOVc:=0
FOVq:=1
EindeutigeID := WinExist("Lightn1ng0 AI Aimbot")
hCircle := makeCircle(0xFFFFFF, r := 0, 0, Trans)
settimer, Overlay ,2500
settimer, renameLg ,2500
return



renameLg:

Random, AusgabeVar , 11111111, 999999999
WinSetTitle,  ahk_id %EindeutigeID%, , %AusgabeVar% Help with F1 ; Set new Windows Name for 


return


Overlay:

IfWinExist,CTkToplevel
	{
		OverlayID := WinExist("CTkToplevel")
		;WinSet, AlwaysOnTop , , Lightn1ng0 AI Aimbot
		WinGetPos, , , W, H,ahk_id %OverlayID%
		W:=W-4
		H:=H-4
		radius:=w/2+35
		
		WinGet, OverlayTrans, Transparent , ahk_id %OverlayID%
		
			if OverlayTrans = 191
			{
			WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%
			sleep ,500
			
			
			if FOVc = 1
			hCircle := makeCircle(0xFFFFFF, r := radius, 2, Trans)
			
			if FOVq = 1
			WinSet, Region, 2-2 w%W% h%H%,ahk_id %OverlayID%
			
			
			}
			
			
	}

return

F12:: ; Show and hide Lightn1ng0_AI Windows 
IfWinExist,ahk_id %EindeutigeID% 
	{
	WinHide , ahk_id %EindeutigeID%
	}
	else
	{
	WinShow ,ahk_id %EindeutigeID%
	}
return



F7::
if FOVq = 1
{
FOVq = 0
WinSet, Region, ,ahk_id %OverlayID%
}
else
{
FOVq = 1
WinSet, Region, 2-2 w%W% h%H%,ahk_id %OverlayID%
}

return



F8::
if FOVc = 1
{
FOVc = 0
hCircle := makeCircle(0xFFFFFF, r := 0, 0, Trans)
}
else
{
FOVc = 1
hCircle := makeCircle(0xFFFFFF, r := radius, 2, Trans)
}

return

F10::
Trans:=Trans+5

if Trans > 250 
	Trans:=250 


WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%

if FOVc = 1
hCircle := makeCircle(0xFFFFFF, r := radius, 2, Trans)

return


F9::
Trans:=Trans-5
if Trans < 10 
	Trans:=5

WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%

if FOVc = 1
hCircle := makeCircle(0xFFFFFF, r := radius, 2, Trans)

return




F1:: ; Help
MsiMessageBox(Text, "Lightn1ng0_AI extension v1.05", 0x40)
return


END:: ; End Lightn1ng0_AI
WinShow ,ahk_id %EindeutigeID%
WinClose,ahk_id %EindeutigeID%
ExitApp

MsiMessageBox(Text, Title := "", Options := 0, Owner := 0) {
    Ret := DllCall("msi.dll\MsiMessageBox"
        , "Ptr" , Owner
        , "Str" , Text
        , "str" , Title
        , "UInt", Options
        , "UInt", 0)
    Return {1: "OK", 2: "Cancel", 3: "Cancel", 4: "Retry", 5: "Ignore", 6: "Yes", 7: "No", 10: "Try Again"}[Ret]
}

return


makeCircle(color, r := 50, thickness := 10, transparency := 254 ) {
	static HWND := MakeGui()
	d := 2 * r
	x :=A_ScreenWidth/2-r
	y :=A_ScreenHeight/2-r
		
	; https://autohotkey.com/board/topic/7377-create-a-transparent-circle-in-window-w-winset-region/
	outer := DllCall("CreateEllipticRgn", "Int", 0, "Int", 0, "Int", d, "Int", d)
	inner := DllCall("CreateEllipticRgn", "Int", thickness, "Int", thickness, "Int", d - thickness, "Int", d - thickness)
	DllCall("CombineRgn", "UInt", outer, "UInt", outer, "UInt", inner, "Int", 3) ; RGN_XOR = 3
	DllCall("SetWindowRgn", "UInt", HWND, "UInt", outer, "UInt", true)

	Gui %HWND%:Color, % color
	Gui %HWND%:Show, x%x% y%y% w%d% h%d% NoActivate
	WinSet Transparent, % transparency, % "ahk_id " HWND
    
	return HWND
}

MakeGui() {
	Gui New, +E0x20 +AlwaysOnTop +ToolWindow -Caption +Hwndhwnd,fov
	
	return hwnd
}
