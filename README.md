# About

- Minecraft Quick Homes makes common server commands into a shortcut. Once installed, you no longer have to be delayed with typing in your command/homes perfectly.
- You have the freedom with naming your homes as long as you want, without giving up the diligence and convenience of teleporting.
- The code is open source and made in Autohotkey. You can customize your copy of Minecraft Quick Homes with your own shortcuts.
- Less time on the intricacies, more time on the fun of the game.

<img title="Minecraft_Quick_Homes_Logo" alt="" src="/Minecraft Quick homes Logo/Final Image/Backround Image.png">

## Setup

- Please keep the files in a folder, since Mc_Quick_Homes will be working off it's current directory, Quick_Homes will create files where it is.

1. Launch Script once. Quick homes will create your ini file, (when there is no .ini file).
2. Open your .ini file.
3. Add a space after the home, and input your home.
  Example:

    ```ini
    Before:
    Home1=home
    Home2=home
    Home3=home
    ...
    After:
    Home1=home h
    Home2=warp spawn
    Home3=home spider_xp_farm
    ...
    ```

    - You don't need it to be a home. It can even be a warp. It can be any command.
      - It simply types slash, then your command in your settings that you called.
  
    - If you want to add a section, press `Alt` `+` `Q` on a Minecraft Window.
      - This removes the unnecessary work when customizing your home.
      - You may also remove blank entires from the template.

4. You can adjust what ALT+SHIFT does by changing the variable `Option_To_Add_OR_Multiply` in section `config`

- Option 1, is adding 10 to your input. Option 2, is multiplying your input by two.

- You can change the variable to 1 or 2. Do so otherwise, and app will exit.

Option 1

```Text
1 which is default; Option 1 will add 10 to your input, so
Alt+shift 3
Alt+13
```

Option 2

```Text
Multiples the input by 2, so
ALT+Shift 4
is equivalent to 
ALT+8
```

## Autostart

- Autostart is 0 by default. (And setting autostart to 2 will set it back to 0).

What happens if you set autostart to #?

0. (Not installed)Normal operations.
1. (Install) Follow the directions/guidelines in the msgbox's that the program opens up.
2. (Not used)
3. (Installed) Mc_Quick_Homes will now run minecraft each time it is ran.
4. (Uninstall) Follow the directions/guidelines in the msgbox's that the program opens up.

- Autostart can be configured to launch another minecraft launcher.

```ini
[config]
...
Minecraft_Launcher_Path=C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe
```

- Just add The full path to your launcher, including the `.exe`.

## Usage

1. Launch Script. Then Launch the script again, after it has autocreated Homestorage.ini
2. Configure your Homestorage.ini. You can also press Alt + I to configure Homestorage.ini in minecraft.
3. Use Shortcut Alt+1-9 to /home 1-9
4. Use Shortcut Alt+Shift to add 10 to your input (Default).
5. Use Alt+` To /back
6. Use Alt+c to craft.
7. Use Alt+e to open Ender Chest.
8. Use Alt+t To open Trash
9. Use Alt+v to toggle veinminer.
10. Use Alt+f to toggle tempfly.
11. Use Alt+CapsLock to open the radial menu.
12. Bask in the glory of amazement.
13. When you want to close script, go to your taskbar tray, right click the green icon with an H, and click exit app.
14. or exit app by Alt+Esc. (Alt + x) In older versions.

- Please be sure that you have saved your changes when editing your .ini config file, so changes would take effect in app.
- This script will also not accept almost all hotkeys outside of minecraft (javaw.exe). This is a failsafe.
  - Exceptions are:
    1. Alt + I
        - Settings
    2. Alt + Esc
        - Exiting Quick Homes.

## (Section Switch, and adding more sections - Hotkey Guide)

If you want to `Auto_Switch_Sections_by_Minecraft_Title`, please enable that setting in section `[config]` in `HomeStorage.ini`.

1. Use `Ctrl` `+` `1-9` to switch sections.
2. Use `Ctrl` `+` `Shift` to add ten to your input (Default). Not supported on the numpad.
3. Use `Ctrl` `+` `Numpad` to switch sections.

- Switching sections will normally give feedback in the form of a tooltip. Hold `Ctrl` to read tooltip.
- If you have switched to a section that is not available, the tooltip will not show. Teleporting to homes using a invalid section will type out `/ERROR` in chat.

- Use `Alt` `+` `Q`, to add a new section. Quick Homes will automatically populate the blank homes, along with noting down the active window title.

- `Alt` `+` `Shift` `+` `Q`, will toggle the setting: `Auto_Switch_Sections_by_Minecraft_Title`.
- If there is an invalid value in `Auto_Switch_Sections_by_Minecraft_Title`, it will set it to 1.

## Syntax of sections (Explanation)

> Why on earth is the section called `[Homes&1&blank]`?

- `Name_input`&`Number_switch`&`Window_Title`
- For the first value, you may name `Name_input` however you wish. In the future, `Name_input` will be used for switching sections by inputting a name to quick homes.
- `Number_switch` is used for what order to switch homes. You can quickly and easily reorder them by changing the `Number_Switch`. Example:

  ```ini
  [First_Original_order&1&blank]
  [Second_Original_order&2&blank]
  [Third_Original_order&3&blank]
  ; Can be changed to:
  [First_Original_order&3&blank]
  [Second_Original_order&2&blank]
  [Third_Original_order&1&blank]
 
  ; No copy and pasting required.
  ```

- If there are two of `Number_switch` in `HomeStorage.ini` in a section, the closest one to the top will take priority. Example:

```ini
  [First_Original_order&1&blank] ;<--- This would be used first. 
  
  [Second_Original_order&1&blank]
  ```

- `Window_Title` is used for auto switching sections. This is generated, when you __create a new section on an active Minecraft window__ (`Alt + Q`). Be aware, that Minecraft may change it's window title in newer versions when you are on a server. Meaning, you may have to create a new section, if that was unaccounted for.

## Behavior of `Auto_Switch_Sections_by_Minecraft_Title`

- When you are in minecraft, and you input your first home via hotkey; your `active window title` will be stored. When you `switch sections` in the same `active window title`, then input your home via hotkey, it will allow your action. When you input a home in a different `active window title` via hotkey, it will automatically switch to the `window title` in `HomeStorage.ini`.

## How to Customize your Minecraft Quick Home script

- Scroll down to the point where there is a comment saying `Special keys ---------`.
- Anything below this line `#IfWinActive ahk_exe javaw.exe`, will only trigger while minecraft is active. Anything above this line will get triggered outside of minecraft.

### How to make a "Hotkey"

- First up, most of the documentation that is referenced below you can find on the [AutoHotkey's Help manual.](https://www.autohotkey.com/docs/AutoHotkey.htm)
- Here is an example of a hotkey in Quick homes:

```AutoHotKey
!c::
Wait_Until_Minecraft_Registers_Slash()
send craft`n
return
```

- ! = Alt

- The function called `Wait_Until_Minecraft_Registers_Slash()` is used to make sure to give minecraft a delay to interpet that a slash was inputted, before the rest of the command is inputted. This is a failsafe to make sure the send command doesn't input your characters incorrectly.
- The `send` command allows you to send text.
- The \`n characters is a parameter that means to send the enter key. Or if you don't want to memorize those characters, you can use `{Enter}` surrounded in brackets.
- The `return` command prevents the program from reading past your hotkey script.

#### QnA

- `Wait_Until_Minecraft_Registers_Slash()` function **already** puts a slash before it is finished, so there is almost no need to add an extra slash at the end of your command.

- If the output to minecraft is `/ERROR`, that means that your home is non-existant, in the ini file.
  - Fixes:
  > Change the current header section to 1, or what is defined in your `HomeStorage.ini`.

- If the output to minecraft is `/home`, it is likely that there is nothing filled in.

> - "My custom command goes past what it's supposed to do."

- Please Put a return at the end of your command to prevent the thread from executing more unintended commands.

> - "My hotkey won't activate / It won't respond"

- You didn't put two colons after the command.

> - "When I switch homes rapidly, the alt key appears to be stuck somtimes, or when minecraft is busy loading another part of the world that I am teleporting to."

- This is a documented issue on the [Mincraft Quick Homes Github](https://github.com/Mario675/Minecraft_Quick_Homes/issues/25). A temporary fix would be to press, then release the alt key, to unlatch the virtually held key. When minecraft is busy, and cannot accept an input into the text line, Minecraft Quick Homes will proceed to type into minecraft without the text line. Meaning that windows might pop up from button shortcuts such as the achievement window `(L)`, the server players windows `(P)`, etc.

## Logic with Alt + Shift

> - I know number 10 is inacessable with default, but
>   `Alt+Shift+1 = __1__*1*`
>   - Makes more sense since the shift adds the 1 onto the tenth digit, and then the input after.
>   - Instead of adding 9
>     `Alt+Shift+3 = 1__2__`
>   - Which ones Digit is less than the input.
>   - In conclusion, it would be a bit confusing.
