/*  
    #Code from:
        -https://github.com/Mario675/Minecraft_Quick_Homes

    -This is created so that the code never loses it's original source.
    -Just in case if someone wanted to check for updates.
*/


#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;Create Starting file
if !FileExist("HomeStorage.ini")
{  
    ;[OPTIONS] Secton
    IniWrite, 1, HomeStorage.ini, config, Option_To_Add_OR_Multiply
    IniWrite, 0, HomeStorage.ini, config, Autostart
    IniWrite, C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe, HomeStorage.ini, config, Minecraft_Launcher_Path

    Insert_Home_numbers_into_HomeStorage(1,"")

    TrayTip, Minecraft_Quick_Homes, Created A new .ini config!, 3,
    Exitapp
}

Insert_Home_numbers_into_HomeStorage(section_number, Minecraft_Window_Title)
{
    ;This function actually writes the template into HomeStorage.ini

    ;Checks if inserted parameter is blank.
    if !Minecraft_Window_Title
    {
        Minecraft_Window_Title := "blank"
        ;msgbox %Minecraft_Window_Title%
    }
    ;msgbox %Minecraft_Window_Title%

    ;use a loop command with math.
    Home_Number := 1
    loop 18
    {
        IniWrite, home , HomeStorage.ini, Homes&%section_number%&%Minecraft_Window_Title%, Home%Home_Number%
        Home_Number+= 1
    }
    return
}

End_ErrorsMsgbox_Check____(App_stay_OPEN_AfterError)
{
    
    if App_stay_OPEN_AfterError = 0
    {
        exitapp
    }

    return ;It shouldn't reach this point, but this is just in case.
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
            End_ErrorsMsgbox_Check____(App_stay_OPEN_AfterError)
        return

        case 1:
            msgbox Please change Autostart, to:`n   - 0 or 1.
            End_ErrorsMsgbox_Check____(App_stay_OPEN_AfterError)
        return

        case 3:
            msgbox HomeStorage.ini was moved`, renamed`, or deleted while Minecraft_Quick_Homes was running.`n Please:`n- rename it to the original file`n- or restart Minecraft_Quick_Homes to Auto-Recreate a new file.
            End_ErrorsMsgbox_Check____(App_stay_OPEN_AfterError)
        return

        case 4:
            TrayTip, Minecraft_Quick_Homes, Updated your Homestorage.ini, 3,
            
        return
        
    }

    return
}

;This checks for all errors. Not just the error when the function was called. Function(Variable): Variable will determine if app stays open
optionFailsafes(Error_App_Stay_Open)
{

    {
        if !FileExist("HomeStorage.ini")
        {
            ErrorsMsgbox(3, Error_App_Stay_Open)
            return
        }
    }

    { 
        global Option_To_Add_OR_Multiply
        IniRead, Option_To_Add_OR_Multiply, HomeStorage.ini, Config, Option_To_Add_OR_Multiply ;This Option does not update during a shortcut.

        if Option_To_Add_OR_Multiply not between 1 and 2
        {
           ErrorsMsgbox(0,Error_App_Stay_Open)
        }
        
    }
    
    {
        
        IniRead, Autostart, HomeStorage.ini, Config, Autostart ;This Option does not update during a shortcut.

        ;I know 2 is not used in Autostart thus it won't do anything. Same thing if you chose 0. 😉
        if Autostart not between 0 and 4
        {
           ErrorsMsgbox(1,Error_App_Stay_Open)
        } 

    }
    
    if Autostart = 3
    { ; issue #31 fix

        Check_If_Existing__Minecraft_Launcher_Path__In_Homestorage_ini()
        
    }

    ;TrayTip, Quickhomes, optionFailsafe cannot find a error, 10 ;Debug
    return
}


/*
##These are the two setup functions before calling autostart setup.
- MoveExplorer_Left_Or_Right(Left_Or_Right)
- class Move_Two_Explorer_Windows_To_Half_Of_Monitor

*/
MoveExplorer_Left_Or_Right(Left_Or_Right)
{
    sleep 800
    switch Left_Or_Right
    {
        case 0:
        Send, #{left}
        goto Continue_Past_This_Switch_Statement
        case 1:
        send, #{right}
        goto Continue_Past_This_Switch_Statement
        throw "Switch left or right have failed to go to Continue_Past_This_Switch_Statement"
    }
    Continue_Past_This_Switch_Statement:
    send {Esc}
    sleep 500
    return
} 

class Move_Two_Explorer_Windows_To_Half_Of_Monitor
{
    ;To be called inside autostart setup



    Launch_Explorer_Windows_And_Split()
    {
    

        LoopVariableCount := 0

        Wintitle := A_ScriptDir

        ;msgbox 1"%A_ScriptFullPath%" 2"%A_ScriptDir%" ;debug

        loop 2
        {     
            LoopVariableCount += 1

            if LoopVariableCount = 2
            {
                ;This second
                Run, explore C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Minecraft Launcher
                WinWait, Minecraft Launcher,
                MoveExplorer_Left_Or_Right(1)
            }
            Else ; After else, and after winwait, This Parameter NEEDS 800ms of wait to work.
            {
                ;This first
                Run, explore %Wintitle%,
                WinWait, A ;Wintitle is set to active
                MoveExplorer_Left_Or_Right(0)
            }

        }
        

        return
    }



}


Autostart := 0
;Need ErrorsMsgbox and optionFailsafe to be loaded first for user errors.
AutoStart_Setup()
{
    ;Directory for minecraft launcher shortcuts: C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Minecraft Launcher
    ;Icon Directory:
    Autostart := 0
    
    IniRead, Autostart, HomeStorage.ini, config, Autostart
    ;Preamble
    HANDLE_CABINET_EXPLORER := 0
    msgbox, 308, Minecraft_Quick_Homes Shortcut install,You have set AUTOSTART to "1" in HomeStorage.ini`nThis Setup will install a shortcut to Minecraft quick homes as minecraft.`n`nWhen this shortcut is installed`, It will:`n1. Open Quick homes`n2. Launch minecraft.`nSHORT EXPLANATION:`nThe shortcut will launch the quick homes program, and quick homes will then launch minecraft. `n`nWhen you adjust the AUTOSTART setting to 4`, the shortcut will be uninstalled`, and placed back to it's default.`n `n`nIf Quick Homes were to be removed`, Minecraft will not be launched. You would need to reset the shortcut to the vanilla launcher on your own.`n`nIf so happens that you did delete Quick homes, you would need to install the shortcut again for minecraft manually, or download this program to easily uninstall it. `n`nYes To confirm install`, No to cancel.`n`nP.S.`nChoosing 'no' will set autostart back to 0.


;/*


    
    IfMsgBox, yes
    {
        ;https://www.autohotkey.com/docs/commands/FileCreateShortcut.htm
        ;FileCreateShortcut, Target, C:\My Shortcut.lnk [, WorkingDir, Args, Description, IconFile, ShortcutKey, IconNumber

        MsgBox, 36,Mc_Quick_Homes, Would you like the shortcut name to be:`n1. Ahk_Minecraft Launcher (Yes)`n2. MinecraftLauncher (No)

        IfMsgBox, yes
        {
            FileCreateShortcut, "%A_ScriptFullPath%", Ahk_Minecraft Launcher.lnk, "%A_ScriptFullPath%", ,MC_Quick_Homes`, Autostart Shortcut, C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe,
        }
        IfMsgBox, no
        {
            FileCreateShortcut, "%A_ScriptFullPath%", MinecraftLauncher.lnk, "%A_ScriptFullPath%", ,MC_Quick_Homes`, Autostart Shortcut, C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe,
        }

        
        MsgBox After two windows pop up`, move minecraft shortcut to folder on the right. Confirm with Admin Perms.`nAfter that`, close the two file explorers.`nLaunch the program, and it should open up the minecraft launcher along with Mc_Quick_Homes.`nPS`nIt will take a little bit for windows to update the shortcut in the search menu.

        Move_Two_Explorer_Windows_To_Half_Of_Monitor.Launch_Explorer_Windows_And_Split()
        ;exitapp ;For Debugging Purposes ;Just for the app to stop running afterwards. 


        ;3 means that this program starts up minecraft when it is launched. 
        IniWrite, 3, HomeStorage.ini, config, Autostart
        TrayTip, Autostart is now set to 3, Mc_Quick_Homes, 20
    }


    IfMsgBox, no
    {
        IniWrite, 0, HomeStorage.ini, config, Autostart
        TrayTip, Autostart is now set to 0, Mc_Quick_Homes, 20
        exitapp
    }
;*/

    ;UHC Perms prompt 
    

    return
}

;Replicates the original shortcut for the user to install.
Autostart_Uninstall()
{
    MsgBox After two windows pop up`,move minecraft shortcut to folder on the right. Confirm with Admin Perms.`nAfter that`, close the two file explorers.`nLaunch the program`, and it should only run the minecraft launcher`, not Mc_QuickHomes.`nPS`nIt will take a little bit for windows to update the shortcut in the search menu.
    FileCreateShortcut, "C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe", MinecraftLauncher.lnk, "%A_ScriptFullPath%", ,A gateway to everything Minecraft, C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe,

    Move_Two_Explorer_Windows_To_Half_Of_Monitor.Launch_Explorer_Windows_And_Split()


    IniWrite, 0, HomeStorage.ini, config, Autostart
    TrayTip, Autostart is now set to 0, Mc_Quick_Homes, 20


    return
}

Check_If_Existing__Minecraft_Launcher_Path__In_Homestorage_ini()
{
    Temp_variable_for_checking_valid_path_for_autostart := 0
    IniRead, Temp_variable_for_checking_valid_path_for_autostart, HomeStorage.ini, config, Minecraft_Launcher_Path, 0 ;Set the default to zero, so I can compare it.

    if Temp_variable_for_checking_valid_path_for_autostart = 0
    {
        IniWrite, C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe, HomeStorage.ini, config, Minecraft_Launcher_Path
        ErrorsMsgbox(4, Error_App_Stay_Open)
    }

    return
}

Check_and_launch_Valid_Minecraft_Launcher_Path()
{
    IniRead, Minecraft_Launcher_Path, HomeStorage.ini, config, Minecraft_Launcher_Path 
    Try run %Minecraft_Launcher_Path%
    Catch e
    {
        MsgBox, Non valid path Minecraft_Launcher_Path detected.`nPlease check your Minecraft_Launcher_Path variable in homestorage.ini.`nMake sure it includes the full path, including the executable name and extension.`n`n- Example:`nC:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe
        ExitApp
    }

    return
}


StartupMinecraft()
{
    ; I put the optionFailsafes() here, because of bug #31 on github. Prevents a crash with old files.
    ; It will also check the validity or existence of the Minecraft_Launcher_Path variable.
    optionFailsafes(true)

    Check_and_launch_Valid_Minecraft_Launcher_Path()

    return
}

IniRead, Autostart, HomeStorage.ini, config, Autostart
optionFailsafes(false)
switch Autostart
{
    ;Turning on setup
    case 1:
    AutoStart_Setup()
    Return

    case 2:
    IniWrite, 0, HomeStorage.ini, config, Autostart
    TrayTip, 2 is not used. Setting to 0.,MC_Quick_Homes,10


    ;after setup
    case 3:
        StartupMinecraft()
    return

    case 4:
        Autostart_Uninstall()
    return

}



optionFailsafes(false)

Wait_Until_Minecraft_Registers_Slash()
{
    send /
    sleep 100
    return
}

/*
    https://www.autohotkey.com/docs/commands/LoopParse.htm
    
    - 
    - I would need to make a function that makes new personalized sections, based on the window title.
  It would start at 1, since the 0 `[Homes]` already exists. 
  ```Example
  HS.1
  ```
  Actually, Why not have it start at two? Since the default one, can be accessed with `Alt + Ctrl 1`

    - If the setting to auto switch homes are on, then the auto switch will only occur when it receves a hotkey input.
  ```Example
  When Minecraft_Quick_Homes gets `Alt + 1`, it will put the window title of the JAVA exe, into a variable called Mincraft_Version_title. 
  It would then compare Mincraft_Version_title, with the [Homes] section titles parsed in the array. 
  If it found a match (Aka, the array[3] found in that section https://autohotkey.com/board/topic/66720-read-ini-sections/ ), then it would use the data from `Home1=`, and take it from there. 
  ```

    - I would need to read the total sections in the file, and test each one of them for the version title. 
    
    
    - I would need the period to act as a delimiter, to separate the subjects from each other. 
    - Then I can omit chars from the third string, otherwise known as the `MC_`
    
    I would need these three functions
    1. Parse_Existing_Homes_Into_Array()
    
    
*/

;Update 3.5



class minecraft_version_sections_ReadWrite
{
    Parse_Sections_Homes_Into_Array()
    {
        ;List All Sections
        msgboxtest_var := 0
        IniRead, msgboxtest_var, HomeStorage.ini
        ;msgbox  Output Below `n`n %msgboxtest_var%

        ;{ ;Example
        ;/*


            ;Parse All sections into array.
            ;The first section of the array (home_sections[0]["Homes&1&blank", "etc"]), which notes down all the sections
            ;The second subsection of the array (home_sections[1]), is the 1 section split up into 3 data points.
            home_sections := [[],[]]

            ;| Defining the sections available in HomeStorage. This will not count them. get_existing_sum_of_sections() will.
            ;\/
            home_sections[0] := StrSplit(msgboxtest_var, "`n")
            ; msgbox % home_sections.1[1] ; array[1] is useless, since config will already be in there. 
            ; msgbox % home_sections.1[2] ; However, Array[2] and so forth, will highlight all the other ones.
            
            ; | Defining the subsection stored in this variable.
            ; |                                     | Parsing the sections into subsections **To Be Stored**.
            ; \/                                    \/
            ; home_sections.2/*[Subsection_ID]*/ := StrSplit(home_sections.1[2], "&")
            ; home_sections[2]/*[Subsection_ID]*/ := StrSplit(home_sections[1][2], "&")
            ; home_sections.3/*[Subsection_ID]*/ := StrSplit(home_sections.1[3], "&")
            

            Total_Home_Sections := this.get_existing_sum_of_sections(home_sections)

            dot_operator_start := 1

            

            loop % Total_Home_Sections
            {
                home_sections[dot_operator_start] := StrSplit(home_sections[0][dot_operator_start], "&")
                dot_operator_start++
            }
            
            ;msgbox % home_sections[2][2]

            
            


            

            ; msgbox % home_sections.2[1]
            ; msgbox % home_sections.2[2]
            ; msgbox % home_sections.2[3]

            ; msgbox % home_sections.3[1]
            ; msgbox % home_sections.3[2]
            ; msgbox % home_sections.3[3]
        ;*/
        ;}

        
        return home_sections

    }

    Add_Section_Homes_Into_HomeStorage(home_sections, Minecraft_Window_Title)
    {
        result := this.get_existing_sum_of_sections(home_sections)

        ; now that we got the amount of sections inside, all thats needed, is noting down the minecraft version. 
        ; Since config is not a useful home section, subtract result by 1.



        Insert_Home_numbers_into_HomeStorage(result, Minecraft_Window_Title)

        TrayTip Minecraft Quick Homes, Added Homes&%result%&%Minecraft_Window_Title%

        return
    }

    Get_Active_Window_Title()
    {
        WinGetActiveTitle, active_window_title

        return active_window_title
    }

    ; Just pipe in the Parsed HomeStorage Array here.
    get_existing_sum_of_sections(home_sections)
    {
        ;While home_sections has an index, execute inside code. 
        while home_sections[0][A_Index]
        {
            ;msgbox % home_sections.1[A_Index]","A_Index
            result := A_Index
        }
        

        ;msgbox final index is %result%
        ;If there is no homes index, then the result should be 0. 

        return result
    }

}


class switch_minecraft_header_sections
{

    current_header_section := 0

    ; If no version is specified, aka `,0` then it will use Switch_Section_Hotkey
    ; WARNING DOES NOT SWITCH BY MIDDLE SECTION NUMBER `&#&`
    Switch_Set_Of_Homes_By_Sections(Switch_Section_Hotkey, Minecraft_Version)
    {
        ;This switches the main section header to the hotkey pressed. 
        /*
            example:
            Ctrl + Alt + 1
            This will go to the first header, 
            > [Homes&1&blank]
            If you press:
            Ctrl + Alt + 2
            This will go to the second header,
            > [Homes&2&blank]
            Changing the main header will change how HomeWarpCasesSwitch() calls homes. 
            It's like switching desktops on Windows 10.
        */
        

        if Minecraft_Version = 0
        {
            ; Please Change me from the lazy way. If you see this in the final pull, plug an issue into github. 

            ; Since config is useless for determining a home, add one to the input Switch_Section_Hotkey
            ; Switch_Section_Hotkey++ ; This was leftover from old fix.

            home_sections := minecraft_version_sections_ReadWrite.Parse_Sections_Homes_Into_Array()
            
            ; This is the lazy method below
            ; Switch_Section_Hotkey++ ;Since in home sections, config is first, and not needed.
            ; current_header_section := home_sections[0][Switch_Section_Hotkey] 

            ;Since we can access all the sections from homesections[0][sections], we should search through there using a recursive algorithm.

            ;This is to check if the sections exists. If the section does not exist, break.
            while home_sections[0][A_Index]
            {
                ; msgbox % home_sections[0][A_Index]

                

                ; This should find the second subsection of the sections

                if home_sections[A_Index][2] = Switch_Section_Hotkey
                {
                    ; msgbox % home_sections[A_Index][2] "YAY"
                    hotkey_section_home := A_Index
                    goto break_out_of_loop
                }
                


            }

            


        }
        ;First read the HomeStorage.ini File and parse it into an array. 

        /* ; This can be an optional error message. Decided to turn it off, since it would probably annoy the user.
        if !current_header_section 
        {
            msgbox The section you selected as header does not exist.`n`nPlease add more sections.
        }

        */
        break_out_of_loop:
        return hotkey_section_home
    }





}

get_section_home_name__from_section_pos(section_pos)
{
    home_sections := minecraft_version_sections_ReadWrite.Parse_Sections_Homes_Into_Array()
    home_name := home_sections[0][section_pos]

    return home_name
}

; get_section_name is meant to be used with Switch_Set_Of_Homes_By_Sections()
Show_tooltip_while__section_combo_held__(get_section_pos)
{

    home_name := get_section_home_name__from_section_pos(get_section_pos)

    while GetKeyState("Ctrl", "P") && GetKeyState("Alt", "P")
    {
        ToolTip, %home_name%
    }

    ToolTip


    return
}

!Q::
    ;Notes down current title version, and makes a new section.
    minecraft_version_sections_ReadWrite.Add_Section_Homes_Into_HomeStorage(minecraft_version_sections_ReadWrite.Parse_Sections_Homes_Into_Array(), minecraft_version_sections_ReadWrite.Get_Active_Window_Title())

return


; Switch sections by number. ---------

;Stored__home_section_pos := ""

!^1::
    Stored__home_section_pos := switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(1, 0)
    ; msgbox % test
    Show_tooltip_while__section_combo_held__(switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(1,0))
    

return

!^2::
    Stored__home_section_pos := switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(2, 0)
    ; msgbox % test
    Show_tooltip_while__section_combo_held__(switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(2,0))
return

!^3::
    Stored__home_section_pos := switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(3, 0)
    ; msgbox % test
    Show_tooltip_while__section_combo_held__(switch_minecraft_header_sections.Switch_Set_Of_Homes_By_Sections(3,0))
return

;Main Function
CaseSwitch := 0
IFSHIFT := 0
Current_Home_warp=0

HomeWarpCasesSwitch(CaseSwitch, IFSHIFT)
{
    global Stored__home_section_pos
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

    Home_Name := get_section_home_name__from_section_pos(Stored__home_section_pos)

    IniRead, Current_Home_warp, HomeStorage.ini, %Home_Name%, Home%CaseSwitch%
    Wait_Until_Minecraft_Registers_Slash()
    send %Current_Home_warp%`n
    
    ;MsgBox, %Current_Home_warp% ;Debug

    Fix_Virtual_Alt_Held()
    Fix_Virtual_Shift_Held()
    ;#KeyHistory 100
    ;keyHistory

    send {ShiftUp}


    ;Reset Variables
    Current_Home_warp=0
    IFSHIFT = 0

    return
}

return

;Code modified from:
;https://stackoverflow.com/questions/49009176/autohotkey-causing-control-key-to-get-stuck#49034365
Fix_Virtual_Alt_Held()
{ 
    If GetKeyState("Alt")           ; If the OS believes the key to be in (logical state),
    {
        If !GetKeyState("Alt","P")  ; but  the user isn't physically holding it down (physical state)
        {
            Send {Blind}{Alt Up}
        }
    }
    return
}

Fix_Virtual_Shift_Held()
{
    If GetKeyState("Shift")           ; If the OS believes the key to be in (logical state),
    {
        If !GetKeyState("Shift","P")  ; but  the user isn't physically holding it down (physical state)
        {
            Send {Blind}{Shift Up}
        }
    }
    return
}


;Special keys ---------------------------

!Esc::
    Exitapp
return

;#IfWinActive ahk_exe javaw.exe

;Failsafe in case user uses hotkey out of minecraft. 
;When Testing shortcuts, comment out #IfWinActive javaw.exe

!i::
    if !FileExist("HomeStorage.ini")
    {
        optionFailsafes(true)
    }
    else
    run HomeStorage.ini

return

!v::
    Wait_Until_Minecraft_Registers_Slash()
    send veinminer toggle`n
return  

!t::
    Wait_Until_Minecraft_Registers_Slash()
    send trash`n
return

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