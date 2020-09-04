#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

if !FileExist("HomeStorage.ini")
{  
    ;use a loop command with math.
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
    IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%CaseSwitch%
    MsgBox, %Current_Home_warp%
    Current_Home_warp=0

    return
}

return

/*
    I want to append to a command like\
    IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%Variable%
    That way, I don't have to retype a lot. 
*/


!1::
HomeWarpCasesSwitch(1)
return

!2::
HomeWarpCasesSwitch(2)
return

!3::
HomeWarpCasesSwitch(3)
return

!4::
HomeWarpCasesSwitch(4)
return

!5::
HomeWarpCasesSwitch(5)
return