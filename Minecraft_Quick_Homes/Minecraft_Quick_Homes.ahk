#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

if !FileExist("HomeStorage.ini")
{  
    ;use a loop command with math.
    Home_Number := 1
    loop 9
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

;Main Function
CaseSwitch := 0
HomeWarpCasesSwitch(CaseSwitch)
{
    IniRead, Current_Home_warp, HomeStorage.ini, Homes, Home%CaseSwitch%
    Wait_Until_Minecraft_Registers_Slash()
    send %Current_Home_warp%`n
    
    ;MsgBox, %Current_Home_warp% ;Debug
    Current_Home_warp=0

    return
}

return

!x::
Exitapp
return

!c::
Wait_Until_Minecraft_Registers_Slash()
send craft`n
return

!e::
Wait_Until_Minecraft_Registers_Slash()
send echest
return


!`::
Wait_Until_Minecraft_Registers_Slash()
send back`n
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