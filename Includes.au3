#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <AutoItConstants.au3>
#include <Timers.au3>
#include <GuiRichEdit.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>
#include <GUIEdit.au3>
#include <EditConstants.au3>	
#include <InetConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <xAPI.au3>

#Region GUIRichEdit
Func GUICtrlRichEdit_WriteLine($hWnd, $sText, $iIncrement = 0, $sAttrib = "", $iColor = -1)

    ; Count the @CRLFs
    StringReplace(_GUICtrlRichEdit_GetText($hWnd, True), @CRLF, "")
    Local $iLines = @extended
    ; Adjust the text char count to account for the @CRLFs
    Local $iEndPoint = _GUICtrlRichEdit_GetTextLength($hWnd, True, True) - $iLines

    ; Add new text
    _GUICtrlRichEdit_AppendText($hWnd, $sText & @CRLF)
    ; Select text between old and new end points
    _GuiCtrlRichEdit_SetSel($hWnd, $iEndPoint, -1)
    ; Convert colour from RGB to BGR
    $iColor = Hex($iColor, 6)
    $iColor = '0x' & StringMid($iColor, 5, 2) & StringMid($iColor, 3, 2) & StringMid($iColor, 1, 2)
    ; Set colour
    If $iColor <> -1 Then _GuiCtrlRichEdit_SetCharColor($hWnd, $iColor)
    ; Set size
    If $iIncrement <> 0 Then _GUICtrlRichEdit_ChangeFontSize($hWnd, $iIncrement)
    ; Set weight
    If $sAttrib <> "" Then _GUICtrlRichEdit_SetCharAttributes($hWnd, $sAttrib)
    ; Clear selection		
    _GUICtrlRichEdit_Deselect($hWnd)
EndFunc
#EndRegion