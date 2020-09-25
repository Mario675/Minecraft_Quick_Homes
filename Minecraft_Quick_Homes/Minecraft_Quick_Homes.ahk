#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;Create file
if !FileExist("HomeStorage.ini")
{  
    ;IniWrite, Value, Filename, Section, Key
    IniWrite, 1, HomeStorage.ini, config, Option_To_Add_OR_Multiply
    ;use a loop command with math.
    Home_Number := 1
    loop 18
    {
        IniWrite, home , HomeStorage.ini, Homes, Home%Home_Number%
        Home_Number+= 1
    }
    TrayTip, Minecraft_Quick_Homes, Created A new .ini config!, 3,
    Exitapp
}

Current_Home_warp=0

Wait_Until_Minecraft_Registers_Slash()
{
    send /
    sleep 100
    return
}



ErrorsMsgbox(What_type_error)
{
    switch What_type_error
    {
        case 0:
            msgbox Please change Option_To_Add_OR_Multiply, to a valid number, `n 1 or 2.
            exitapp
        return
    }

    return
}

;FailSafe For options
IniRead, Option_To_Add_OR_Multiply, HomeStorage.ini, Config, Option_To_Add_OR_Multiply

if Option_To_Add_OR_Multiply not between 1 and 2
{
    ErrorsMsgbox(0)
}

;Main Function
CaseSwitch := 0
IFSHIFT := 0

HomeWarpCasesSwitch(CaseSwitch, IFSHIFT)
{
    global Option_To_Add_OR_Multiply
    switch Option_To_Add_OR_Multiply ;Supports option for shift *2 or shift +9
    {
        case 1: ;Default IFSHIFT multiplier
            If IFSHIFT = 1
            {
                CaseSwitch += 10
            }

        goto Calc_Home 

        case 2: ;Continue Number as if 1=10
            if IFSHIFT = 1
            {
                CaseSwitch *= 2
            }
        goto Calc_Home
        ;case 2 ;Extend 1, 2, 3, 4, to represent 5, 6, 7, 8,

    goto Calc_Home ;In case over 0 or 1
    }

    Calc_Home: ;Because return in switch statements end the variable. 

    IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%CaseSwitch%
    Wait_Until_Minecraft_Registers_Slash()
    send %Current_Home_warp%`n
    
    ;MsgBox, %Current_Home_warp% ;Debug
    ;Reset Variables
    Current_Home_warp=0
    IFSHIFT = 0
    return
}



return

#IfWinActive ahk_exe javaw.exe
;Failsafe in case user uses hotkey out of minecraft. 
;When Testing shortcuts, comment out #IfWinActive javaw.exe


;Special keys ---------------------------

!x::
Exitapp
return

!t::
Wait_Until_Minecraft_Registers_Slash()
send trash`n

!c::
Wait_Until_Minecraft_Registers_Slash()
send craft`n
return

!e::
Wait_Until_Minecraft_Registers_Slash()
send echest`n
return


!`::
Wait_Until_Minecraft_Registers_Slash()
send back`n
return

;Numeral options ------------------------------------------------

!1::
HomeWarpCasesSwitch(1, 0)
return

!2::
HomeWarpCasesSwitch(2, 0)
return

!3::
HomeWarpCasesSwitch(3, 0)
return

!4::
HomeWarpCasesSwitch(4, 0)
return

!5::
HomeWarpCasesSwitch(5, 0)
return

!6::
HomeWarpCasesSwitch(6, 0)
return

!7::
HomeWarpCasesSwitch(7, 0)
return

!8::
HomeWarpCasesSwitch(8, 0)
return

!9::
HomeWarpCasesSwitch(9, 0)
return

;ALT SHIFT NUMERALS ------------------------------------------------

!+1::
HomeWarpCasesSwitch(1, 1)
return

!+2::
HomeWarpCasesSwitch(2, 1)
return

!+3::
HomeWarpCasesSwitch(3, 1)
return

!+4::
HomeWarpCasesSwitch(4, 1)
return

!+5::
HomeWarpCasesSwitch(5, 1)
return

!+6::
HomeWarpCasesSwitch(6, 1)
return

!+7::
HomeWarpCasesSwitch(7, 1)
return

!+8::
HomeWarpCasesSwitch(8, 1)
return

!+9::
HomeWarpCasesSwitch(9, 1)
return