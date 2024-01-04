$PBExportHeader$w_tip.srw
forward
global type w_tip from window
end type
type mle_info from multilineedit within w_tip
end type
type st_header from statictext within w_tip
end type
type st_noteinfo from statictext within w_tip
end type
type st_note from statictext within w_tip
end type
end forward

global type w_tip from window
string tag = "Tip"
integer width = 4091
integer height = 2820
boolean titlebar = true
string title = "Tip"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_info mle_info
st_header st_header
st_noteinfo st_noteinfo
st_note st_note
end type
global w_tip w_tip

on w_tip.create
this.mle_info=create mle_info
this.st_header=create st_header
this.st_noteinfo=create st_noteinfo
this.st_note=create st_note
this.Control[]={this.mle_info,&
this.st_header,&
this.st_noteinfo,&
this.st_note}
end on

on w_tip.destroy
destroy(this.mle_info)
destroy(this.st_header)
destroy(this.st_noteinfo)
destroy(this.st_note)
end on

event resize;mle_info.width = newwidth - ( mle_info.x * 2)
end event

event open;integer 		li_FileNum
string 		ls_msg,	ls_currentpath, 	ls_filename
blob 			lb_data
String			ls_control,	ls_note, 	ls_hearder,  ls_hearder_end

ls_currentpath	=	GetCurrentDirectory( )
ls_msg	=	Message.StringParm

ls_filename = ls_currentpath+"\tip\Tip_"+ls_msg+".txt"

li_FileNum = FileOpen(ls_filename, TextMode!, Read!)
FileReadEx(li_FileNum, lb_data)
FileClose(li_FileNum)

ls_hearder = "The following is the custom theme JSON for "
ls_hearder_end = " on the current window:"
Choose Case lower(ls_msg)
	Case "singlelineedit"
		ls_control = 'StaticText ("Last Name") and SingleLineEdit'
	Case "commandbutton"
		ls_control = 'CommandButton ("Sample CommandButton 3")'		
	Case "radiobutton"
		ls_control = 'RadioButton ("On Leave")'
	Case "checkbox"
		ls_control = 'GroupBox ("Day") and CheckBox ("Saturday")'
	Case "tab"
		ls_control = 'Tab ("Custom Satistics") and HTrackBar'		
	Case "userobject"
		ls_control = "the UserObject and its controls"		
	Case "datawindow"
		ls_control = "the master DataWindow"		
	Case "datawindow_detail"
		ls_control = "the detail DataWindow"		
	Case "standard"
		ls_control = "Standard Theme"		
	Case "custom"
		ls_control = "this custom "
		ls_hearder_end = "window and its controls:"
	Case Else
		ls_control = ls_msg
End Choose 

st_header.text =ls_hearder+ls_control+ls_hearder_end

ls_note ="The path for the blue custom theme JSON file is:  "+&
"theme\Flat Design Blue\Theme-custom-blue.json "+"~r~n"+ &
"The path for the dark custom theme JSON file is:  "+ &
"theme\Flat Design Dark\Theme-custom-dark.json "+"~r~n"

mle_info.text = string(lb_data, EncodingUTF8!)
st_noteinfo.text = ls_note
 
end event

type mle_info from multilineedit within w_tip
integer x = 82
integer y = 184
integer width = 3950
integer height = 2164
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_header from statictext within w_tip
integer x = 82
integer y = 68
integer width = 3950
integer height = 104
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Following is the custom theme JSON for CommandButton on the current window"
boolean focusrectangle = false
end type

type st_noteinfo from statictext within w_tip
integer x = 82
integer y = 2476
integer width = 3950
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_note from statictext within w_tip
integer x = 82
integer y = 2388
integer width = 402
integer height = 64
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Note:"
boolean focusrectangle = false
end type

