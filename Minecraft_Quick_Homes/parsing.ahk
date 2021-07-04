#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


input := "FirstValue.SecondValue.3rdValue"
array := StrSplit(input, ., "Value")
msgbox % array[1]
msgbox % array[2]
msgbox % array[3]