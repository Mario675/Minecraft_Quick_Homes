#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;Create file
if !FileExist("HomeStorage.ini")
{  
    ;[OPTIONS] Secton
    IniWrite, 1, HomeStorage.ini, config, Option_To_Add_OR_Multiply
    IniWrite, 0, HomeStorage.ini, config, Autostart

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



;This is the Msgbox text section Since error checking is different (meaning a lot more code) from message sending. 
App_stay_OPEN_AfterError := false
ErrorsMsgbox(What_type_error, App_stay_OPEN_AfterError)
{
    switch What_type_error
    {
        case 0:
            msgbox Please change Option_To_Add_OR_Multiply, to a valid number, `n 1 or 2.
            ;msgbox App_stay_OPEN_AfterError = %App_stay_OPEN_AfterError% ;debug. Semicolon by default
            if App_stay_OPEN_AfterError = 0
            {
                exitapp
            }
        return
    }

    return
}

;This is basically the check before msgbox
optionFailsafes(Error_App_Stay_Open) ;Designed for checking options section before running Shortcut. In charge of whether app stays open after errors. 
{
    ;First Check
    { 
        global Option_To_Add_OR_Multiply
        IniRead, Option_To_Add_OR_Multiply, HomeStorage.ini, Config, Option_To_Add_OR_Multiply ;This Option does not update during a shortcut.

        if Option_To_Add_OR_Multiply not between 1 and 2
        {
           ErrorsMsgbox(0,Error_App_Stay_Open)
        }
        return
    }
    ;Second Check Future pull#10
    {
        ;This is meant to be a switch error for if UHC fails or if it failed to start up minecraft
        ;Make sure you include a toast message for starting up minecraft. 

    }
    TrayTip, Quickhomes, optionFailsafe cannot find a error, 10
    return
}


Autostart := 0
;Need ErrorsMsgbox and optionFailsafe to be loaded first for user errors.
AutoStart_Setup()
{
    ;Directory for minecraft launcher shortcuts: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Minecraft Launcher
    ;Icon Directory:
    Autostart := 0
    ;IniWrite, 0, HomeStorage.ini, config, Autostart
    IniRead, Autostart, HomeStorage.ini, config, Autostart
    ;Preamble
    msgbox, 308, Minecraft_Quick_Homes Shortcut install,You have set AUTOSTART to "1" in HomeStorage.ini`nThis Setup will install a shortcut to Minecraft quick homes as minecraft.`n`nWhen this shortcut is installed`, It will:`n1. Open Quick homes`n2. Launch minecraft.`nSHORT EXPLANATION:`nThe shortcut will launch the quick homes program, and quick homes will then launch minecraft. `n`nWhen you adjust the AUTOSTART setting to 3`, the shortcut will be uninstalled`, and placed back to it's default.`n`nYOU WILL NEED TO LAUNCH QUICK_HOMES AS ADMIN OR INSTALL WILL NOT WORK.`n`nWithout this program, Minecraft will not be launched. You would need to install the shortcut again manually, or download this program to uninstall it. `n`nYes To confirm install`, No to cancel.




    ;UHC Perms prompt 
    

    return
}

Autostart_Uninstall()
{
    ;Should be triggered if #3
    ;If it has not been changed, throw error.
}

Autostart_MQH_start_Minecraft()
{
    ;This could be triggered if new shortcut is there or :
    ;A shortcut would send a signal to this program. 
}



IniRead, Autostart, HomeStorage.ini, config, Autostart
if Autostart = 1
{
    AutoStart_Setup()
}




optionFailsafes(false)

Wait_Until_Minecraft_Registers_Slash()
{
    send /
    sleep 100
    return
}

;Main Function
CaseSwitch := 0
IFSHIFT := 0
Current_Home_warp=0

HomeWarpCasesSwitch(CaseSwitch, IFSHIFT)
{
    global Option_To_Add_OR_Multiply
    optionFailsafes(true)

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

    Calc_Home: ;Because return in switch statements end the Function.

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