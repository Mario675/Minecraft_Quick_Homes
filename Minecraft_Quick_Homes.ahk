#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

if !FileExist("HomeStorage.ini")
{  
    IniWrite, /home , HomeStorage.ini, Homes, Home1
    IniWrite, /home , HomeStorage.ini, Homes, Home2
    IniWrite, /home , HomeStorage.ini, Homes, Home3
    IniWrite, /home , HomeStorage.ini, Homes, Home4
}

/*
    IniWrite, /home , HomeStorage.ini, Homes, Home1
    IniWrite, /home , HomeStorage.ini, Homes, Home2
    IniWrite, /home , HomeStorage.ini, Homes, Home3
    IniWrite, /home , HomeStorage.ini, Homes, Home4
*/

Current_Home_warp=0
;Declare Cases

CaseSwitch := 0
HomeWarpCasesSwitch(CaseSwitch)
{
    switch CaseSwitch
    {
    case 1:
        IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%CaseSwitch%
        MsgBox, %Current_Home_warp%
        Current_Home_warp=0
        return

    case 2:
        IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%CaseSwitch%
        MsgBox, %Current_Home_warp%
        Current_Home_warp=0
        return
        return
    case 3:

        return
    }
return
}
return

/*
    I want to append to a command like\
    IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%Variable%
    That way, I don't have to retype a lot. 
*/


!1::
;IniRead, OutputVar, Filename, Section, Key [, Default] ;For reference
CaseSwitch := 0
HomeWarpCasesSwitch(1)
return


!2::
HomeWarpCasesSwitch(2)