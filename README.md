# About

- Minecraft Quick Homes makes common server commands into a shortcut. Once installed, you no longer have to be delayed with typing in your command/homes perfectly.
- You have the freedom with naming your homes as long as you want, without giving up the diligence and convenience of teleporting.
- The code is open source and made in Autohotkey. You can customize your copy of Minecraft Quick Homes with your own shortcuts.
- Less time on the intricacies, more time on the fun of the game.

[Minecraft_Quick_Homes_Logo](Minecraft Quick homes Logo\Final Image\Backround Image.png)

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

- You don't need it to be a home. It can even be a warp.
  - This script types whatever you have in your ini corelating to the button you pressed after alt, after inputting /

4. You can adjust what ALT+SHIFT does by changing the variable in section `config`

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
10. Bask in the glory of amazement.
11. When you want to close script, go to your taskbar tray, right click th  e green icon with an H, and click exit app.
12. or exit app by Alt+Esc. (Alt + x) In older versions.

- Please be sure that you have saved your changes when editing your .ini config file, so changes would take effect in app.
- This script will also not accept hotkeys outside of minecraft (javaw.exe). This is a failsafe.

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

> - "My custom command goes past what it's supposed to do."

- Please Put a return at the end of your command to prevent the thread from executing more unintended commands.

> - "My hotkey won't activate / It won't respond"

- You didn't put two colons after the command.

> - "When I switch homes rapidly, the alt key appears to be stuck somtimes, or when minecraft is busy loading another part of the world that I am teleporting to."

- This is a documented issue on the [Mincraft Quick Homes Github](https://github.com/Mario675/Minecraft_Quick_Homes/issues/25). A temporary fix would be to press, then release the alt key, to unlatch the virtually held key. When minecraft is busy, and cannot accept an input into the text line, Minecraft Quick Homes will proceed to type into minecraft without the text line. Meaning that windows might pop up from button shortcuts such as the achievement window `(L)`, the server players windows `(P)`, etc.

## Important End notes

> - I know number 10 is inacessable with default, but
>   `Alt+Shift+1 = __1__*1*`
>   - Makes more sense since the shift adds the 1 onto the tenth digit, and then the input after.
>   - Instead of adding 9
>     `Alt+Shift+3 = 1__2__`
>   - Which ones Digit is less than the input.
>   - In conclusion, it would be a bit confusing.
