#include <EZUpdate.au3>
#include <MsgBoxConstants.au3>
#include <xAPI.au3>

Global $configFile = @ScriptDir & "/config.xcfg"
Global $updateVersion = xApiCheckVersion()
Global $appName

ConsoleWrite("Checking For Updates" &@CRLF)
Local $iFileExists = FileExists($configFile)
Local $currVer
	If $iFileExists Then
		;Read Config
		ConsoleWrite("Reading Config File" & @CRLF)
		$appVer = IniRead($configFile, "AppInfo" , "appVer","")
		$appName = IniRead($configFile, "AppInfo" , "appName", "Default")
			ConsoleWrite('Current Version: ' & $appVer & @CRLF)
			ConsoleWrite('Latest Version: ' & $updateVersion & @CRLF)
			if $updateVersion > $appVer Then
				ConsoleWrite("Initiating Update" & @CRLF)
		 		initUpdate()
			Else
				ConsoleWrite('Latest Version Already Installed: v' & $appVer & @CRLF)
			EndIf
			Exit
	Else
		MsgBox($MB_ICONERROR,"Fatal Error","Application is Corrupted, Please Re-install Application")
	EndIf
	Exit
	
Func initUpdate()
Local $exeUrl = "https://raw.githubusercontent.com/xPrject/S4Updater/API/Update/TS4_Updater.exe"
Local $file = "TS4_Updater.exe"
Local $name = $appName
Local $dir = @ScriptDir  & "/"

	ConsoleWrite($exeUrl & $file & @CRLF)
	Local $exeUpdate = EZUpdate($exeUrl, $file, $name, $dir, False)

	If $exeUpdate Then
	    ProgressSet(100, "Download Complete " & $name)
		ConsoleWrite("Download Complete" & $name & @CRLF)
	Else
	    ProgressOff()
	EndIf
UpdateConfig()
EndFunc

Func UpdateConfig()
Local $file = "config.xcfg"
Local $name = $appName
Local $dir = @ScriptDir &"/"
Local $cfgUrl = xApi() & "Update/" & $file

ConsoleWrite($cfgUrl & @CRLF)
Local $cfgUpdate = EZUpdate($cfgUrl, $file, $name, $dir, False)

If $cfgUpdate Then
    ProgressSet(100, "Download Complete " & $name)
	ConsoleWrite("Download Complete" & $name & @CRLF)
Else
    ProgressOff()
EndIf
EndFunc

Func done()
	MsgBox($MB_SYSTEMMODAL,"xUpdater","Update Complete")
	Sleep(1000)
	
EndFunc

Func relaunch()	;Relaunch Client
	Sleep(500)
	ShellExecute(@ScriptDir & "/TS4_Updater.exe")
EndFunc
Exit

	