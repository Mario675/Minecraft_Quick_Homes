# Setup
- Please keep the files in a folder, since Mc_Quick_Homes will be working off it's current directory, Quick_Homes will create files where it is.


1. Launch Script once. Quick homes will create your ini file, (when there is no .ini file).
2. Open your .ini file. 
3. add a space after the home, and input your home.
Example:
```
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
This script types whatever you have in your ini corelating to the button you pressed after alt, after inputting /

4. You can adjust what ALT+SHIFT does by changing the variable in section `config`
- You can change the variable to 1 or 2. Do so otherwise, and app will exit. 

Option 1
```
1 which is default; Option 1 will add 10 to your input, so
Alt+shift 3
Alt+13
```

Option 2
```
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
3. (Installed) Mc_Quick_Homes will now run minecraft each time it is ran.
4. (Uninstall) Follow the directions/guidelines in the msgbox's that the program opens up. 

# Useage
1.	Launch Script
2.	Use Shortcut Alt+1-9 to /home 1-9
3.	Use Shortcut Alt+Shift to add 10 to your input (Default). 
4.	Use Alt+` To /back
5.	Use Alt+c to craft. 
6.	Use Alt+e to open Ender Chest. 
7.	Use Alt+t To open Trash
8.	Bask in the glory of amazement. 

9.	When you want to close script, go to your taskbar tray, right click the green icon with an H, and click exit app. 
10.	or exit app by Alt+x 

- Please be sure that you have saved your changes when editing your .ini config file, so changes would take effect in app.

- This script will also not accept hotkeys outside of minecraft (javaw.exe). This is a failsafe. 

## Important End notes
> - I know number 10 is inacessable with default, but
>   `Alt+Shift+1 = __1__*1*`
>   - Makes more sense since the shift adds the 1 onto the tenth digit, and then the input after. 
>   - Instead of adding 9
>   `Alt+Shift+3 = 1__2__`
>   - Which ones Digit is less than the input. 
