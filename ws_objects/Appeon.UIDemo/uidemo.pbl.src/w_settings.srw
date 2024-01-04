$PBExportHeader$w_settings.srw
forward
global type w_settings from window
end type
type cb_save from commandbutton within w_settings
end type
type cb_close from commandbutton within w_settings
end type
type ddlb_theme from dropdownlistbox within w_settings
end type
type ddlb_1 from dropdownlistbox within w_settings
end type
type st_theme from statictext within w_settings
end type
type dw_setup from u_dw within w_settings
end type
end forward

global type w_settings from window
integer width = 1865
integer height = 568
boolean titlebar = true
string title = "Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
cb_save cb_save
cb_close cb_close
ddlb_theme ddlb_theme
ddlb_1 ddlb_1
st_theme st_theme
dw_setup dw_setup
end type
global w_settings w_settings

type variables
String is_file
String is_theme
String is_theme_path //= "C:\Program Files (x86)\Appeon19\Shared\PowerBuilder\theme190\"
end variables

forward prototypes
public subroutine of_add_theme ()
end prototypes

public subroutine of_add_theme ();Int i
String ls_theme_name
String ls_current_path
ls_current_path = GetCurrentDirectory( )

is_theme_path = ls_current_path + "\Theme\"

ddlb_1.DirList(is_theme_path+'*.*', 32768+16) 

For i = 2 To ddlb_1.totalitems( )
	ls_theme_name = ddlb_1.text(i)
	IF Left(ls_theme_name,1) = "[" THEN ls_theme_name = Mid(ls_theme_name, 2)
	IF Right(ls_theme_name,1) = "]" THEN ls_theme_name = Left(ls_theme_name, Len(ls_theme_name) - 1)
	ls_theme_name = Trim(ls_theme_name)
	IF FileExists(is_theme_path + ls_theme_name + "\theme.json") THEN
		ddlb_theme.Additem(ls_theme_name)
	END IF
Next 
ddlb_theme.Additem("Do Not Use Themes")

ChangeDirectory(ls_current_path)
end subroutine

on w_settings.create
this.cb_save=create cb_save
this.cb_close=create cb_close
this.ddlb_theme=create ddlb_theme
this.ddlb_1=create ddlb_1
this.st_theme=create st_theme
this.dw_setup=create dw_setup
this.Control[]={this.cb_save,&
this.cb_close,&
this.ddlb_theme,&
this.ddlb_1,&
this.st_theme,&
this.dw_setup}
end on

on w_settings.destroy
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.ddlb_theme)
destroy(this.ddlb_1)
destroy(this.st_theme)
destroy(this.dw_setup)
end on

event open;String ls_theme
This.SetRedraw(False)
is_file = "Theme.ini"
ls_theme = ProfileString(is_file, "Setup", "Theme", "Flat Design Blue")

of_add_theme()
ddlb_theme.Text = ls_theme
is_theme = ls_theme


This.SetRedraw(True)


end event

type cb_save from commandbutton within w_settings
integer x = 997
integer y = 308
integer width = 357
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;String ls_theme
String ls_msg
Int li_ret



ls_theme = Trim(ddlb_theme.Text )
IF ls_theme <> is_theme  AND  ls_theme = "Do Not Use Themes" THEN
	ls_msg = "~r~nYou modified the theme. You must restart your application for the changes to take effect.~r~n"
	ls_msg += "~r~nDo you want to exit the application and then run it again?"
//ELSE
//	ApplyTheme (is_theme_path + ls_theme)
END IF

SetProfileString(is_file, "Setup", "Theme", ls_theme)

IF Len(ls_msg) > 0 THEN
	li_ret = Messagebox(gs_msg_title, "Saved the settings successfully." + ls_msg, Question!, YesNo!, 2)
	Close(parent)
	IF li_ret = 1 THEN
		Close(w_modernui_frame)
	END IF
ELSE
	Messagebox(gs_msg_title, "Saved the settings successfully." + ls_msg)
	IF Not Isvalid(w_modernui_frame) Then 
		Open(w_modernui_frame)
	else
		IF ls_theme <> is_theme THEN
			if isvalid(w_modernui_frame) then w_modernui_frame.dynamic of_closewindow("CloseAll") // close all opening window
			ApplyTheme (is_theme_path + ls_theme)
			is_theme = ls_theme
		END IF
	end  if 
	Close(parent)
END IF
end event

type cb_close from commandbutton within w_settings
integer x = 1417
integer y = 308
integer width = 357
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked; 

Close(parent)
end event

type ddlb_theme from dropdownlistbox within w_settings
integer x = 338
integer y = 108
integer width = 1435
integer height = 476
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_settings
boolean visible = false
integer x = 251
integer y = 280
integer width = 581
integer height = 476
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_theme from statictext within w_settings
integer x = 82
integer y = 116
integer width = 256
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Theme:"
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type dw_setup from u_dw within w_settings
boolean visible = false
integer x = 9
integer y = 952
integer width = 2304
integer height = 736
integer taborder = 10
string dataobject = "d_setup"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_defaulturl
String ls_hosttype
String ls_modeltype

Choose Case dwo.Name
	Case "hosttype"
		ls_modeltype = This.Getitemstring( 1, "modeltype")
		ls_hosttype = data
	Case "modeltype"
		ls_modeltype = data
		ls_hosttype = This.Getitemstring( 1, "hosttype")
End Choose

IF ls_hosttype = "1" Then
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
		Case "SqlModelMapper"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "sqlmodelmapperdefaulturl", "")
	End Choose
Else
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
		Case "SqlModelMapper"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "sqlmodelmapperdefaulturl", "")
	End Choose
End IF

//dw_setup.SetItem(1, "url", ls_defaulturl)
end event

