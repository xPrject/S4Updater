; #INDEX# ===============================================================
; xAPI BASIC UDF API Library for GitHub
; Version : 3.3.16.0
; Description ...: Repository variables, constants and functions for Access Point Integration
; Author(s) .....: Xedric Antiola
; =====================================================================
; Debug Switch For Testing This Library
  Global $Debug = False
; ======================================================================

;User Credentials (User / Repository Name)
Global $userName = "xPrject"
Global $projectName = "S4Updater"

;Server Access Point And Type
Global $server = "githubusercontent.com"
Global $access = "API"
Global $protocol = "https"
Global $dataType = "raw"

If $Debug Then	
	ConsoleWrite('DEBUG: ENABLED' &@CRLF)
	ConsoleWrite('Fetching API' &@CRLF)
	ConsoleWrite('Result Func: '  & xApi() &@CRLF)
	
	ConsoleWrite(@CRLF)
	
	ConsoleWrite('Func checkVersion()' &@CRLF)
	ConsoleWrite('Fetching Latest Version' &@CRLF)
	ConsoleWrite('Latest Version : ' & xApiCheckVersion() &@CRLF)
	
	
EndIf
	

;Build Access Point Url
Func xApi()
	Global $urlAPI = $protocol & "://" & $dataType & "." & $server & "/" & $userName & "/" & $projectName & "/" & $access & "/"
	Return $urlAPI
EndFunc

;Fetch Version Number From API
Func xApiCheckVersion()
	Local $currentVersion = BinaryToString(InetRead(xApi() & 'CurrentVersion.dat'))
	Return $currentVersion
EndFunc

Func get_readme()
	Local $sSourceURL = xApi() & 'updater_readme.txt'
	Local $sFileName = "updater_readme.txt"
	Local $sTargetPath = @ScriptDir & "\" & $sFileName
	Local $hFileDownload = InetGet($sSourceURL, $sTargetPath, $INET_LOCALCACHE, $INET_DOWNLOADBACKGROUND)
EndFunc


