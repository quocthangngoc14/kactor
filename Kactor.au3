#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Resource\Icon.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #RequireAdmin
Opt("TrayIconHide", 1)
Opt("GUICloseOnESC", 1)
Opt("GUIOnEventMode", 1)

#include <GUIConstants.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <GUITab.au3>
#include <sound.au3>

Global $Tile = "Kactor"
Global $gW = 600, $gH = 360
Global $IconDir, $sFontAwesomePath, $sDefaultFontName = "Segoe UI"

Global $Licence[5][7]
$Licence[0][0] = 4

$Licence[1][0] = 'CCleaner'
$Licence[1][1] = RegRead('HKLM\SOFTWARE\Piriform\CCleaner', '')
$Licence[1][2] = FileGetVersion($Licence[1][1] & '\CCleaner.exe')
$Licence[1][3] = 'CCleaner là công cụ dọn dẹp hệ thống hiệu quả được đông đảo người sử dụng tin dùng. Với các tính năng dọn dẹp rác máy tính, dữ liệu duyệt web, registry, v.v... CCleaner sẽ giúp máy tính bạn trở nên gọn gàng hơn.'
$Licence[1][4] = 'https://www.piriform.com/ccleaner/download'
$Licence[1][5] = 'https://download.piriform.com/ccsetup525pro.exe'

$Licence[2][0] = 'Recuva'
$Licence[2][1] = RegRead('HKLM\SOFTWARE\Piriform\Recuva', '')
$Licence[2][2] = FileGetVersion($Licence[2][1] & '\Recuva.exe')
$Licence[2][3] = 'Recuva là công cụ tiện ích giúp khôi phục các tập tin bị xóa trong máy tính một cách dễ dàng. Phần mềm còn cung cấp các tùy chọn quét theo kiểu tập tin hay trong một thư mục nào đó khiến việc tìm lại dữ liệu trở nên dễ dàng hơn.'
$Licence[2][4] = 'https://www.piriform.com/recuva/download'
$Licence[2][5] = 'http://download.piriform.com/rcsetup153.exe'

$Licence[3][0] = 'Defraggler'
$Licence[3][1] = RegRead('HKLM\SOFTWARE\Piriform\Defraggler', '')
$Licence[3][2] = FileGetVersion($Licence[3][1] & '\Defraggler.exe')
$Licence[3][3] = 'Defraggler là công cụ chống phân mảnh ổ cứng nhẹ gọn, hiệu quả. Bên cạnh đó, phần mềm còn hiển thị tính hình sức khỏe của ổ cứng một cách trực quan, dễ hiêu.'
$Licence[3][4] = 'https://www.piriform.com/defraggler/download'
$Licence[3][5] = 'http://download.piriform.com/dfsetup221.exe'

$Licence[4][0] = 'Speccy'
$Licence[4][1] = RegRead('HKLM\SOFTWARE\Piriform\Speccy', '')
$Licence[4][2] = FileGetVersion($Licence[4][1] & '\Speccy.exe')
$Licence[4][3] = 'Speccy là công cụ giúp người dùng xem toàn bộ thông tin phần cứng của máy tính như CPU, RAM, VGA, Motherboard, màn hình hay thậm chí cả nhiệt độ thân máy v.v... '
$Licence[4][4] = 'https://www.piriform.com/speccy/download'
$Licence[4][5] = 'http://download.piriform.com/spsetup129.exe'

Global $Sound = _SoundOpen('Resource\cute-song.mp3')
_SoundPlay($Sound)

#Region ; Startup and Load resource
_GDIPlus_Startup()
If @Compiled Then
	FileInstall("Resource\FontAwesome.otf", @TempDir & "\FontAwesome.otf")
	FileInstall("Resource\Icon.png", @TempDir & "\Icon.png")
	FileInstall("Resource\Logo.png", @TempDir & "\Logo.png")
	$sFontAwesomePath = @TempDir & "\FontAwesome.otf"
	$IconDir = @TempDir & "\Icon.png"
	$LogoDir = @TempDir & "\Logo.png"
Else
	$sFontAwesomePath = "Resource\FontAwesome.otf"
	$IconDir = "Resource\Icon.png"
	$LogoDir = "Resource\Logo.png"
EndIf
$sDefaultFontName = FileExists(@HomeDrive & '\Windows\Fonts\segoeui.ttf') ? "Segoe UI" : "Arial"
Global Const $sFontAwesomeName = _WinAPI_GetFontResourceInfo($sFontAwesomePath, True)
_WinAPI_AddFontResourceEx($sFontAwesomePath, $FR_PRIVATE)
#EndRegion

#Region ; Create GUI
$hGUI = GUICreate($Tile, $gW, $gH, -1, -1, $WS_POPUP)
GUISetBkColor(0xFFFFFF)
GUICtrlCreateLabel('', 0, 0, $gW, 5)
GUICtrlSetBkColor(-1, 0x0078D7)
GUICtrlSetOnEvent(-1, "_FormMove")

_GDIPlus_CreatePic($IconDir, 5, 10, 35, 35)
GUICtrlCreateLabel($Tile, 45, 10, $gW-75, 35, $SS_CENTERIMAGE)
GUICtrlSetFont(-1, 18, 0, 0, "Segoe UI")
GUICtrlSetOnEvent(-1, "_FormMove")

Global $lb_Tab_Main = GUICtrlCreateLabel("About", 5, 60, 80, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 700, 0, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_TabChange")

Global $lb_Tab_CCleaner = GUICtrlCreateLabel("CCleaner", 85, 60, 80, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 0, 0, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_TabChange")

Global $lb_Tab_Recuva = GUICtrlCreateLabel("Recuva", 165, 60, 80, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 0, 0, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_TabChange")

Global $lb_Tab_Defraggler = GUICtrlCreateLabel("Defraggler", 245, 60, 80, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 0, 0, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_TabChange")

Global $lb_Tab_Speccy = GUICtrlCreateLabel("Speccy", 325, 60, 80, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 0, 0, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_TabChange")

GUICtrlCreateLabel('', 0, 85, $gW, 4)
GUICtrlSetBkColor(-1, 0xD3D3D3)
Global $SliderBar = GUICtrlCreateLabel('', 5, 85, 80, 4)
GUICtrlSetBkColor(-1, 0x0078D7)

Global $CurentTab = $lb_Tab_Main
Global $TabPos = 5

#Region 	;Create Tabs
$hTab = GUICtrlCreateTab(-5, 85, $gW+10, $gH-85-30, BitOR($TCS_FLATBUTTONS, $TCS_FIXEDWIDTH))
_GUICtrlTab_SetItemSize($hTab, 0, 1)
	GUICtrlCreateTabItem(" ")	;Tab Main
		_GDIPlus_CreatePic($LogoDir, 10, 100, 120, 120)
		GUICtrlCreateLabel('', 140, 100, $gW-150, 120)
		GUICtrlSetBkColor(-1, 0xE0E0E0)
		Global $IntroText = "KyTs Activator là chương trình hỗ trợ download và kích hoạt bản quyền của một số phần mềm cần thiết. Chương trình cũng hỗ trợ kiểm tra và cập nhật phiên bản mới nhất của các phần mềm đó một cách tiện lợi."
		GUICtrlCreateLabel($IntroText, 150, 110, $gW-170, 100)
		GUICtrlSetBkColor(-1, 0xE0E0E0)
		GUICtrlSetFont(-1, 12, 0, 2, $sDefaultFontName, 5)

		Global $lb_Tab_Main_VisitFace_Icon = GUICtrlCreateLabel(ChrW(0xf09a), ($gW/2)-250/2, 230, 35, 35, BitOR($SS_CENTER, $SS_CENTERIMAGE))
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x3B5998)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 20, 0, 0, $sFontAwesomeName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")
		Global $lb_Tab_Main_VisitFace = GUICtrlCreateLabel("   Like us on Facebook", ($gW/2)-250/2+35, 230, 250-35, 35, $SS_CENTERIMAGE)
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x3B5998)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 13, 0, 0, $sDefaultFontName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")

		Global $lb_Tab_Main_VisitWeb_Icon = GUICtrlCreateLabel(ChrW(0xf0ac), ($gW/2)-250/2, 275, 35, 35, BitOR($SS_CENTER, $SS_CENTERIMAGE))
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0xFF5722)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 20, 0, 0, $sFontAwesomeName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")
		Global $lb_Tab_Main_VisitWeb = GUICtrlCreateLabel("       Visit our website", ($gW/2)-250/2+35, 275, 250-35, 35, $SS_CENTERIMAGE)
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0xFF5722)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 13, 0, 0, $sDefaultFontName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")

	GUICtrlCreateTabItem(" ")	;Tab Apps
		For $I = 1 To 4
			$Licence[$I][6] = _GDIPlus_CreatePic('Resource\' & $Licence[$I][0] & '-icon.png', 10, 100, 120, 120)
			GUICtrlSetState($Licence[$I][6], $GUI_HIDE)
		Next
		GUICtrlCreateLabel('', 140, 100, $gW-150, 120)
		GUICtrlSetBkColor(-1, 0xE0E0E0)
		Global $lb_Tab_Apps_IntroText = GUICtrlCreateLabel('', 150, 110, $gW-170, 100)
		GUICtrlSetBkColor(-1, 0xE0E0E0)
		GUICtrlSetFont(-1, 12, 0, 2, $sDefaultFontName, 5)

		Global $lb_Tab_Apps_VisitFace_Icon = GUICtrlCreateLabel(ChrW(0xf019), ($gW/2)-250/2, 230, 35, 35, BitOR($SS_CENTER, $SS_CENTERIMAGE))
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x3B5998)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 15, 0, 0, $sFontAwesomeName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")
		Global $lb_Tab_Apps_VisitFace = GUICtrlCreateLabel("   Download this software", ($gW/2)-250/2+35, 230, 250-35, 35, $SS_CENTERIMAGE)
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x0078D7)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 13, 0, 0, $sDefaultFontName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")

		Global $lb_Tab_Apps_VisitWeb_Icon = GUICtrlCreateLabel(ChrW(0xf044), ($gW/2)-250/2, 275, 35, 35, BitOR($SS_CENTER, $SS_CENTERIMAGE))
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x00931C)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 15, 0, 0, $sFontAwesomeName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")
		Global $lb_Tab_Main_VisitWeb = GUICtrlCreateLabel("     Activate this product", ($gW/2)-250/2+35, 275, 250-35, 35, $SS_CENTERIMAGE)
		GUICtrlSetColor(-1, 0xFFFFFF)
		GUICtrlSetBkColor(-1, 0x00C424)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetFont(-1, 13, 0, 0, $sDefaultFontName, 5)
		GUICtrlSetOnEvent(-1, "_VisitWebSite")

	GUICtrlCreateTabItem('')	; End Tabs
#EndRegion 	; Create Tab
GUICtrlCreateLabel('', 0, $gH-40, $gW, 40)
GUICtrlSetBkColor(-1, 0x4D4D4D)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel(ChrW(0xf08b),$gW-40, $gH-40, 40, 40, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x4D4D4D)
GUICtrlSetCursor(-1, 0)
GUICtrlSetTip(-1, "Exit")
GUICtrlSetFont(-1, 20, 0, 0, $sFontAwesomeName, 5)
GUICtrlSetOnEvent(-1, "_Exit")

Global $lb_VisitWeb = GUICtrlCreateLabel('Visit hieuda.com now!', 15, $gH-40, 180, 40, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x4D4D4D)
GUICtrlSetCursor(-1, 0)
GUICtrlSetFont(-1, 10, 0, 4, $sDefaultFontName, 5)
GUICtrlSetOnEvent(-1, "_VisitWebSite")
#EndRegion
WinSetTrans($hGUI, '', 0)
GUISetState()
_ShowForm()

While 1
	Sleep(100)
WEnd


#Region ; Events
Func _ShowForm()
	Local $I
	For $I = 0 To 255 Step +15
		WinSetTrans($hGUI,'', $I)
		Sleep(10)
	Next
EndFunc
Func _HideForm()
	Local $I
	For $I = 255 To 0 Step -15
		WinSetTrans($hGUI,'', $I)
		Sleep(10)
	Next
EndFunc
Func _FormMove()
	DllCall('user32.dll', 'int', 'SendMessage', 'HWND', $hGUI, 'int', 0x0112, 'int', 0xF012, 'int', 0)
EndFunc		;Moving Form
Func _Exit()
	_HideForm()
	_WinAPI_RemoveFontResourceEx($sFontAwesomePath, $FR_PRIVATE)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	_SoundClose($Sound)
	Exit
EndFunc
Func _TabChange()
	Local $I, $iStep, $GUI_CtrlID = @GUI_CtrlId
	If $CurentTab <> $GUI_CtrlID Then
		GUICtrlSetFont($CurentTab, 12, 0, 0, $sDefaultFontName, 5)
		$iStep = $CurentTab < $GUI_CtrlID ? 5 : -5
		Local $TabPos_New = 5+80*Abs($GUI_CtrlID-$lb_Tab_Main)
		For $I = $TabPos To $TabPos_New Step $iStep
			ControlMove($hGUI, '', $SliderBar, $I, 85)
			Sleep(1)
		Next
		If ($CurentTab == $lb_Tab_Main) Then
			GUICtrlSetState($Licence[($GUI_CtrlID-$lb_Tab_CCleaner)+1][6], $GUI_Show)
			GUICtrlSetData($lb_Tab_Apps_IntroText, $Licence[($GUI_CtrlID-$lb_Tab_CCleaner)+1][3])
			GUICtrlSendMsg($hTab, $TCM_SETCURFOCUS, 1, 0)
		ElseIf ($GUI_CtrlID == $lb_Tab_Main) Then
			GUICtrlSendMsg($hTab, $TCM_SETCURFOCUS, 0, 0)
			GUICtrlSetState($Licence[($CurentTab-$lb_Tab_CCleaner)+1][6], $GUI_HIDE)
		Else
			GUICtrlSetState($Licence[($CurentTab-$lb_Tab_CCleaner)+1][6], $GUI_HIDE)
			GUICtrlSetState($Licence[($GUI_CtrlID-$lb_Tab_CCleaner)+1][6], $GUI_Show)
			GUICtrlSetData($lb_Tab_Apps_IntroText, $Licence[($GUI_CtrlID-$lb_Tab_CCleaner)+1][3])
		EndIf
		$TabPos = $TabPos_New
		$CurentTab = $GUI_CtrlID
		GUICtrlSetFont($CurentTab, 12, 700, 0, $sDefaultFontName, 5)
	EndIf
EndFunc
#EndRegion

Func _VisitWebSite()
	Switch @GUI_CtrlId
		Case $lb_VisitWeb, $lb_Tab_Main_VisitWeb, $lb_Tab_Main_VisitWeb_Icon
			ShellExecute('https://www.hieuda.com')
		Case $lb_Tab_Main_VisitFace, $lb_Tab_Main_VisitFace_Icon
			ShellExecute('https://www.facebook.com/voxvanhieu')
	EndSwitch
EndFunc
Func _GDIPlus_CreatePic($FileName, $Left, $Top, $Width, $Heigth)
	Local $hPicCtrl, $hImage, $iHeight, $hGDIBitmap
	$hImage = _GDIPlus_ImageResize(_GDIPlus_ImageLoadFromFile($FileName), $Width, $Heigth)
		$iWidth = _GDIPlus_ImageGetWidth($hImage)
		$iHeight = _GDIPlus_ImageGetHeight($hImage)
		$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
		_GDIPlus_ImageDispose($hImage)
	$hPicCtrl = GUICtrlCreateLabel('', $Left, $Top, $Width, $Heigth, $SS_BITMAP)
	_WinAPI_DeleteObject(GUICtrlSendMsg($hPicCtrl, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
    _WinAPI_DeleteObject($hGDIBitmap)
	Return $hPicCtrl
EndFunc			;~	Using GDIPlus to create Picture control, shouldn't create many control with this and project use GDIPlus