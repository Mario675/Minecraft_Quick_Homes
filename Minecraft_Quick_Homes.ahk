#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

if !FileExist("HomeStorage.ini")
{  
    ;use a loop command with math.
    Home_Number := 1
    loop 9
    {
        IniWrite, /home , HomeStorage.ini, Homes, Home%Home_Number%
        Home_Number+= 1
    }
    Exitapp
}



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

!6::
HomeWarpCasesSwitch(6)
return

!7::
HomeWarpCasesSwitch(7)
return

!8::
HomeWarpCasesSwitch(8)
return

!9::
HomeWarpCasesSwitch(9)
return