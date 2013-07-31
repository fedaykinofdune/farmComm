#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

Loop
{
    FileReadLine, line, %A_WorkingDir%\controllerProcessList.txt, %A_Index%
    if ErrorLevel
        break
		;For testing:
		;MsgBox, Line #%A_Index% is %line%. Will attempt close of, then termination of, process %line%, via commands (and executable) <Process.exe -q %line%.exe> and <Process.exe -k %line%.exe>, respectively . . .
	Process, Exist, %line%.exe
	NewPID = %ErrorLevel%  ; Save the value immediately since ErrorLevel is often changed.
	if NewPID = 0
		{
		;MsgBox The specified process was not found.
		}
	else
		{
		;MsgBox, A matching process was found (Process ID is %NewPID%).
		Run, %A_WorkingDir%\Process.exe -q %line%.exe, %A_WorkingDir%, hide UseErrorLevel
		Sleep, 750
		Run, %A_WorkingDir%\Process.exe -k %line%.exe, %A_WorkingDir%, hide UseErrorLevel
		Sleep, 1750

		;Special runs to terminate undely meddlesome, unhelpful debugger applications.
		Run, %A_WorkingDir%\Process.exe -k Werfault.exe, %A_WorkingDir%, hide UseErrorLevel
		Sleep, 750

		Run, %A_WorkingDir%\Process.exe -k dwm.exe, %A_WorkingDir%, hide UseErrorLevel
		Sleep, 750
		}

}
;MsgBox, The end of the file has been reached or there was a problem.