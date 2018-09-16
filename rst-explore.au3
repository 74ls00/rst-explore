#Include <Array.au3>
#Include <WinAPIEx.au3>

Global $step = 0 ; начальное количество адресов


$explorerList = ProcessList("explorer.exe") ;список всех pid проводника

For $i = 1 To $explorerList[0][0]

;получаем список окон для всех процессов ;не сработало
Global $Data = _WinAPI_EnumProcessWindows(ProcessExists("explorer.exe"), False)


Next


	  Global $text[$Data[0][0]+1] ; установка размера массива для поиска по размеру всего списка

For $i = 1 To $Data[0][0]
   While $Data[$i][1] = "CabinetWClass"
	  $step = $step+1
; выделение адреса из окна
$text[$step] = StringRegExpReplace(ControlGetText($Data[$i][0], "", "[CLASS:ToolbarWindow32; INSTANCE:2]"), "(?m)^.*?:\h*", "")
	  ExitLoop
   WEnd
Next
	  $text[0]=$step ; количество нужных адресов
	  ReDim $text[$step+1] ; уменьшение массива до количества нужных адресова


If IsArray($text) Then
	_ArrayDisplay($text)
EndIf

If IsArray($Data) Then
	_ArrayDisplay($Data)
 EndIf


Do
ProcessClose('explorer.exe')
Until Not ProcessExists('explorer.exe')

 MsgBox(4096, "", $text[0])


ShellExecute(@WindowsDir & '\explorer.exe', "", '', '', @SW_SHOW)






For $i = 1 To $step ; запуск сохранёных окон
ShellExecute(@WindowsDir & '\explorer.exe', '"' & $text[$i] & '"', '', '', @SW_SHOW)
Next








;ShellExecute(@WindowsDir & '\explorer.exe', IniRead ( $inifile, "adress", $i, "" ), '', '', @SW_SHOW)








;;;;;;;;;;;;;;;;;









;Const $inifile = @ScriptDir & "\tmp.ini"
;IniWrite ( $inifile, "system", "windows", $Data[0][0] )
;IniWrite ( $inifile, "adress", $i, StringRegExpReplace ( $text[$i], 'Адрес: ', "" , 1) )


;MsgBox(4096, "Заголовок", "Это диалоговое окно закроется по таймауту через 10 секунд", 10)


 ;$text[0] = $step


; $text[0] = $Data[0][0]





;MsgBox(4096, $Data[$i][1], "i=" & $i & " step=" & $step, 10)


;$text[$step] = ControlGetText($Data[$i][0], "", "[CLASS:ToolbarWindow32; INSTANCE:2]")

;MsgBox(4096, "Заголовок", "Э2", 10)


;Do
;ProcessClose('explorer.exe')
;Until Not ProcessExists('explorer.exe')




;ShellExecute(@WindowsDir & '\explorer.exe', "", '', '', @SW_SHOW)
;For $i = 1 To $Data[0][0]

;ShellExecute(@WindowsDir & '\explorer.exe', StringRegExpReplace ( $text[$i], 'Адрес: ', "" , 1), '', '', @SW_SHOW)
;Next
;ShellExecute(@WindowsDir & '\explorer.exe', IniRead ( $inifile, "adress", $i, "" ), '', '', @SW_SHOW)




;ShellExecute(@WindowsDir & '\explorer.exe', "/res", '', '', @SW_SHOW)
;IniRead ( $inifile, "adress", "1", "default" )






;If IsArray($Data) Then
;	_ArrayDisplay($Data)
 ;EndIf






;http://forum.oszone.net/post-1305092.html



