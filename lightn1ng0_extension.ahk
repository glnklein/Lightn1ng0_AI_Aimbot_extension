#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force


Run ,%A_AppData%\Lightn1ng0_AI_Aimbot\run.bat ; Start Lightn1ng0_AI


Text := "F9   Set Overlay fewer `nF10 Set Overlay stronger `n`nF12 Show/Hide Lightn1ng0_AI`n`nEND Exit Lightn1ng0_AI"

MsiMessageBox(Text, "Lightn1ng0_AI extension v1.03", 0x40)





WinWait , Lightn1ng0 AI Aimbot ; Wait for Lightn1ng0_AI Windows 


WinSet, AlwaysOnTop , , Lightn1ng0 AI Aimbot  ; set Lightn1ng0_AI Windows Always on Top

Trans=55
EindeutigeID := WinExist("Lightn1ng0 AI Aimbot")
settimer, Overlay ,2500
settimer, renameLg ,2500
return



renameLg:

Random, AusgabeVar , 11111111, 999999999
WinSetTitle,  ahk_id %EindeutigeID%, , %AusgabeVar%  ; Set new Windows Name for 


return


Overlay:

IfWinExist,CTkToplevel
	{
		OverlayID := WinExist("CTkToplevel")
		;WinSet, AlwaysOnTop , , Lightn1ng0 AI Aimbot
		WinGetPos, , , W, H,ahk_id %OverlayID%
		W:=W-4
		H:=H-4
		
		WinGet, OverlayTrans, Transparent , ahk_id %OverlayID%
		;msgbox , % OverlayTrans
			if OverlayTrans = 191
			{
			WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%
			sleep ,500
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


F10::
Trans:=Trans+5
WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%
return


F9::
Trans:=Trans-5
WinSet, TransColor, 0x000000 %Trans%, ahk_id %OverlayID%
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



