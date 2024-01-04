$PBExportHeader$w_sheet_customerwindow.srw
forward
global type w_sheet_customerwindow from w_sheet
end type
type uo_pic_tab from u_picture_tip within w_sheet_customerwindow
end type
type tab_standard from tab within w_sheet_customerwindow
end type
type tabpage_standard from userobject within tab_standard
end type
type st_standard from statictext within tabpage_standard
end type
type htb_standard from htrackbar within tabpage_standard
end type
type dw_standard from datawindow within tabpage_standard
end type
type tabpage_standard from userobject within tab_standard
st_standard st_standard
htb_standard htb_standard
dw_standard dw_standard
end type
type tab_standard from tab within w_sheet_customerwindow
tabpage_standard tabpage_standard
end type
type tab_custom from tab within w_sheet_customerwindow
end type
type tabpage_custom from userobject within tab_custom
end type
type st_custom from statictext within tabpage_custom
end type
type htb_custom from htrackbar within tabpage_custom
end type
type dw_custom from datawindow within tabpage_custom
end type
type tabpage_custom from userobject within tab_custom
st_custom st_custom
htb_custom htb_custom
dw_custom dw_custom
end type
type tab_custom from tab within w_sheet_customerwindow
tabpage_custom tabpage_custom
end type
type rb_onvacation from radiobutton within w_sheet_customerwindow
end type
type st_lastname from statictext within w_sheet_customerwindow
end type
type sle_lastname from singlelineedit within w_sheet_customerwindow
end type
type st_middlename from statictext within w_sheet_customerwindow
end type
type sle_middlename from singlelineedit within w_sheet_customerwindow
end type
type sle_firstname from singlelineedit within w_sheet_customerwindow
end type
type st_firstname from statictext within w_sheet_customerwindow
end type
type cbx_sunday from checkbox within w_sheet_customerwindow
end type
type cbx_saturday from checkbox within w_sheet_customerwindow
end type
type cbx_friday from checkbox within w_sheet_customerwindow
end type
type cbx_thursday from checkbox within w_sheet_customerwindow
end type
type cbx_wednesday from checkbox within w_sheet_customerwindow
end type
type cbx_tuesday from checkbox within w_sheet_customerwindow
end type
type cbx_monday from checkbox within w_sheet_customerwindow
end type
type rb_onleave from radiobutton within w_sheet_customerwindow
end type
type rb_terminated from radiobutton within w_sheet_customerwindow
end type
type rb_active from radiobutton within w_sheet_customerwindow
end type
type cb_samplecommandbutton4 from commandbutton within w_sheet_customerwindow
end type
type cb_samplecommandbutton3 from commandbutton within w_sheet_customerwindow
end type
type cb_samplecommandbutton2 from commandbutton within w_sheet_customerwindow
end type
type cb_samplecommandbutton1 from commandbutton within w_sheet_customerwindow
end type
type uo_pic_singlelineedit from u_picture_tip within w_sheet_customerwindow
end type
type uo_pic_commandbutton from u_picture_tip within w_sheet_customerwindow
end type
type uo_pic_radiobutton from u_picture_tip within w_sheet_customerwindow
end type
type uo_pic_checkbox from u_picture_tip within w_sheet_customerwindow
end type
type gb_singlelineedit from groupbox within w_sheet_customerwindow
end type
type gb_commandbutton from groupbox within w_sheet_customerwindow
end type
type gb_status from groupbox within w_sheet_customerwindow
end type
type gb_day from groupbox within w_sheet_customerwindow
end type
end forward

global type w_sheet_customerwindow from w_sheet
string tag = "Customer Window"
integer width = 5550
integer height = 3064
string title = "Customer Window"
boolean controlmenu = false
string icon = ".\image\Custom_window.ico"
boolean center = false
uo_pic_tab uo_pic_tab
tab_standard tab_standard
tab_custom tab_custom
rb_onvacation rb_onvacation
st_lastname st_lastname
sle_lastname sle_lastname
st_middlename st_middlename
sle_middlename sle_middlename
sle_firstname sle_firstname
st_firstname st_firstname
cbx_sunday cbx_sunday
cbx_saturday cbx_saturday
cbx_friday cbx_friday
cbx_thursday cbx_thursday
cbx_wednesday cbx_wednesday
cbx_tuesday cbx_tuesday
cbx_monday cbx_monday
rb_onleave rb_onleave
rb_terminated rb_terminated
rb_active rb_active
cb_samplecommandbutton4 cb_samplecommandbutton4
cb_samplecommandbutton3 cb_samplecommandbutton3
cb_samplecommandbutton2 cb_samplecommandbutton2
cb_samplecommandbutton1 cb_samplecommandbutton1
uo_pic_singlelineedit uo_pic_singlelineedit
uo_pic_commandbutton uo_pic_commandbutton
uo_pic_radiobutton uo_pic_radiobutton
uo_pic_checkbox uo_pic_checkbox
gb_singlelineedit gb_singlelineedit
gb_commandbutton gb_commandbutton
gb_status gb_status
gb_day gb_day
end type
global w_sheet_customerwindow w_sheet_customerwindow

forward prototypes
public function integer of_retrieve ()
public function integer of_zoom (datawindow arg_dw, integer ai_zoom)
end prototypes

public function integer of_retrieve ();
tab_standard.tabpage_standard.dw_standard.settransobject(sqlca)
tab_standard.tabpage_standard.dw_standard.retrieve( )

tab_custom.tabpage_custom.dw_custom.settransobject( sqlca)
tab_custom.tabpage_custom.dw_custom.retrieve( )

tab_standard.tabpage_standard.htb_standard.position = 50
tab_standard.tabpage_standard.htb_standard.pagesize = 10
tab_standard.tabpage_standard.htb_standard.linesize = 10

tab_custom.tabpage_custom.htb_custom.position = 50
tab_custom.tabpage_custom.htb_custom.pagesize = 10
tab_custom.tabpage_custom.htb_custom.linesize = 10

return 1
end function

public function integer of_zoom (datawindow arg_dw, integer ai_zoom);
arg_dw.object.datawindow.print.preview = true
arg_dw.object.datawindow.print.preview.zoom = ai_zoom * 2

Return 1
end function

on w_sheet_customerwindow.create
int iCurrent
call super::create
this.uo_pic_tab=create uo_pic_tab
this.tab_standard=create tab_standard
this.tab_custom=create tab_custom
this.rb_onvacation=create rb_onvacation
this.st_lastname=create st_lastname
this.sle_lastname=create sle_lastname
this.st_middlename=create st_middlename
this.sle_middlename=create sle_middlename
this.sle_firstname=create sle_firstname
this.st_firstname=create st_firstname
this.cbx_sunday=create cbx_sunday
this.cbx_saturday=create cbx_saturday
this.cbx_friday=create cbx_friday
this.cbx_thursday=create cbx_thursday
this.cbx_wednesday=create cbx_wednesday
this.cbx_tuesday=create cbx_tuesday
this.cbx_monday=create cbx_monday
this.rb_onleave=create rb_onleave
this.rb_terminated=create rb_terminated
this.rb_active=create rb_active
this.cb_samplecommandbutton4=create cb_samplecommandbutton4
this.cb_samplecommandbutton3=create cb_samplecommandbutton3
this.cb_samplecommandbutton2=create cb_samplecommandbutton2
this.cb_samplecommandbutton1=create cb_samplecommandbutton1
this.uo_pic_singlelineedit=create uo_pic_singlelineedit
this.uo_pic_commandbutton=create uo_pic_commandbutton
this.uo_pic_radiobutton=create uo_pic_radiobutton
this.uo_pic_checkbox=create uo_pic_checkbox
this.gb_singlelineedit=create gb_singlelineedit
this.gb_commandbutton=create gb_commandbutton
this.gb_status=create gb_status
this.gb_day=create gb_day
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_pic_tab
this.Control[iCurrent+2]=this.tab_standard
this.Control[iCurrent+3]=this.tab_custom
this.Control[iCurrent+4]=this.rb_onvacation
this.Control[iCurrent+5]=this.st_lastname
this.Control[iCurrent+6]=this.sle_lastname
this.Control[iCurrent+7]=this.st_middlename
this.Control[iCurrent+8]=this.sle_middlename
this.Control[iCurrent+9]=this.sle_firstname
this.Control[iCurrent+10]=this.st_firstname
this.Control[iCurrent+11]=this.cbx_sunday
this.Control[iCurrent+12]=this.cbx_saturday
this.Control[iCurrent+13]=this.cbx_friday
this.Control[iCurrent+14]=this.cbx_thursday
this.Control[iCurrent+15]=this.cbx_wednesday
this.Control[iCurrent+16]=this.cbx_tuesday
this.Control[iCurrent+17]=this.cbx_monday
this.Control[iCurrent+18]=this.rb_onleave
this.Control[iCurrent+19]=this.rb_terminated
this.Control[iCurrent+20]=this.rb_active
this.Control[iCurrent+21]=this.cb_samplecommandbutton4
this.Control[iCurrent+22]=this.cb_samplecommandbutton3
this.Control[iCurrent+23]=this.cb_samplecommandbutton2
this.Control[iCurrent+24]=this.cb_samplecommandbutton1
this.Control[iCurrent+25]=this.uo_pic_singlelineedit
this.Control[iCurrent+26]=this.uo_pic_commandbutton
this.Control[iCurrent+27]=this.uo_pic_radiobutton
this.Control[iCurrent+28]=this.uo_pic_checkbox
this.Control[iCurrent+29]=this.gb_singlelineedit
this.Control[iCurrent+30]=this.gb_commandbutton
this.Control[iCurrent+31]=this.gb_status
this.Control[iCurrent+32]=this.gb_day
end on

on w_sheet_customerwindow.destroy
call super::destroy
destroy(this.uo_pic_tab)
destroy(this.tab_standard)
destroy(this.tab_custom)
destroy(this.rb_onvacation)
destroy(this.st_lastname)
destroy(this.sle_lastname)
destroy(this.st_middlename)
destroy(this.sle_middlename)
destroy(this.sle_firstname)
destroy(this.st_firstname)
destroy(this.cbx_sunday)
destroy(this.cbx_saturday)
destroy(this.cbx_friday)
destroy(this.cbx_thursday)
destroy(this.cbx_wednesday)
destroy(this.cbx_tuesday)
destroy(this.cbx_monday)
destroy(this.rb_onleave)
destroy(this.rb_terminated)
destroy(this.rb_active)
destroy(this.cb_samplecommandbutton4)
destroy(this.cb_samplecommandbutton3)
destroy(this.cb_samplecommandbutton2)
destroy(this.cb_samplecommandbutton1)
destroy(this.uo_pic_singlelineedit)
destroy(this.uo_pic_commandbutton)
destroy(this.uo_pic_radiobutton)
destroy(this.uo_pic_checkbox)
destroy(this.gb_singlelineedit)
destroy(this.gb_commandbutton)
destroy(this.gb_status)
destroy(this.gb_day)
end on

event open;call super::open;of_retrieve()
end event

event resize;call super::resize;this.setredraw(False)

//Checkbox cbx_monday		
cbx_tuesday.x = cbx_monday.x + cbx_monday.width + 130
cbx_wednesday.x = cbx_tuesday.x + cbx_tuesday.width + 130
cbx_thursday.x = cbx_wednesday.x + cbx_wednesday.width + 130
cbx_friday.x = cbx_thursday.x + cbx_thursday.width + 130
cbx_saturday.x = cbx_friday.x + cbx_friday.width + 130
cbx_sunday.x = cbx_saturday.x + cbx_saturday.width + 130

//cb_samplecommandbutton1
cb_samplecommandbutton2.x = cb_samplecommandbutton1.x + cb_samplecommandbutton1.width + 300
cb_samplecommandbutton3.x = cb_samplecommandbutton2.x + cb_samplecommandbutton2.width + 300
cb_samplecommandbutton4.x = cb_samplecommandbutton3.x + cb_samplecommandbutton3.width + 300

//statictext 	st_firstname
//signlelineedit
sle_firstname.x = st_firstname.x + st_firstname.width + 10
st_middlename.x = sle_firstname.x + sle_firstname.width + 480
sle_middlename.x = st_middlename.x + st_middlename.width + 10
st_lastname.x = sle_middlename.x + sle_middlename.width + 480
sle_lastname.x = st_lastname.x + st_lastname.width + 10


//GroupBox gb_status
rb_active.x = gb_status.x + 100
rb_terminated.x = rb_active.x + rb_active.width + 80
rb_onleave.x = rb_terminated.x + rb_terminated.width + 80
rb_onvacation.x = rb_onleave.x + rb_onleave.width + 80


tab_standard.height = newheight  - tab_standard.y  - 40 - 80
tab_standard.width = ( newwidth / 2 ) - tab_standard.x - (tab_standard.x / 2 )
tab_standard.tabpage_standard.dw_standard.width =  newwidth / 2  - tab_standard.x - (tab_standard.x / 2 )  
tab_standard.tabpage_standard.dw_standard.height = tab_standard.height  - tab_standard.tabpage_standard.htb_standard.height - 20  - 80 - 100

tab_standard.tabpage_standard.htb_standard.y = tab_standard.tabpage_standard.dw_standard.y + tab_standard.tabpage_standard.dw_standard.height + 4 + 40
tab_standard.tabpage_standard.htb_standard.width = tab_standard.tabpage_standard.dw_standard.width - tab_standard.tabpage_standard.htb_standard.x - 20
tab_standard.tabpage_standard.st_standard.y = tab_standard.tabpage_standard.htb_standard.y  + 10

//tab_custom
tab_custom.x = (newwidth / 2) +  (tab_standard.x / 2 )
tab_custom.height = newheight  - tab_custom.y   - 40 - 80
tab_custom.width =  newwidth  - tab_custom.x  -  tab_standard.x 
tab_custom.tabpage_custom.dw_custom.width =  newwidth  - tab_custom.x 
tab_custom.tabpage_custom.dw_custom.height = tab_custom.height  - tab_custom.tabpage_custom.htb_custom.height - 20 - 80 - 100

tab_custom.tabpage_custom.htb_custom.y = tab_custom.tabpage_custom.dw_custom.y + tab_custom.tabpage_custom.dw_custom.height + 4 + 40 
tab_custom.tabpage_custom.htb_custom.width = tab_standard.tabpage_standard.htb_standard.width  - 20	//tab_custom.tabpage_custom.dw_custom.width - tab_custom.tabpage_custom.htb_custom.x		//
tab_custom.tabpage_custom.st_custom.y = tab_custom.tabpage_custom.htb_custom.y + 10

uo_pic_tab.x = tab_custom.x + tab_custom.width - uo_pic_tab.height - 25

this.setredraw(True)

end event

type uo_pic_tab from u_picture_tip within w_sheet_customerwindow
event destroy ( )
string tag = "tab"
integer x = 5280
integer y = 1328
integer taborder = 20
boolean bringtotop = true
end type

on uo_pic_tab.destroy
call u_picture_tip::destroy
end on

type tab_standard from tab within w_sheet_customerwindow
event create ( )
event destroy ( )
integer x = 82
integer y = 1340
integer width = 2341
integer height = 1580
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_standard tabpage_standard
end type

on tab_standard.create
this.tabpage_standard=create tabpage_standard
this.Control[]={this.tabpage_standard}
end on

on tab_standard.destroy
destroy(this.tabpage_standard)
end on

type tabpage_standard from userobject within tab_standard
event create ( )
event destroy ( )
integer x = 18
integer y = 132
integer width = 2304
integer height = 1432
long backcolor = 67108864
string text = "Standard Satistics"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_standard st_standard
htb_standard htb_standard
dw_standard dw_standard
end type

on tabpage_standard.create
this.st_standard=create st_standard
this.htb_standard=create htb_standard
this.dw_standard=create dw_standard
this.Control[]={this.st_standard,&
this.htb_standard,&
this.dw_standard}
end on

on tabpage_standard.destroy
destroy(this.st_standard)
destroy(this.htb_standard)
destroy(this.dw_standard)
end on

type st_standard from statictext within tabpage_standard
integer x = 91
integer y = 1336
integer width = 242
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom:"
boolean focusrectangle = false
end type

type htb_standard from htrackbar within tabpage_standard
integer x = 343
integer y = 1324
integer width = 2021
integer height = 132
integer maxposition = 100
integer tickfrequency = 10
end type

event lineleft;//this.position = this.position - this.linesize
//of_zoom(this.position)
end event

event moved;of_zoom(tab_standard.tabpage_standard.dw_standard, scrollpos)
end event

type dw_standard from datawindow within tabpage_standard
integer x = 32
integer y = 16
integer width = 2295
integer height = 1296
integer taborder = 10
boolean enabled = false
string title = "none"
string dataobject = "d_dept_empidcount_pie"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)


end event

type tab_custom from tab within w_sheet_customerwindow
event create ( )
event destroy ( )
integer x = 3095
integer y = 1340
integer width = 2341
integer height = 1580
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_custom tabpage_custom
end type

on tab_custom.create
this.tabpage_custom=create tabpage_custom
this.Control[]={this.tabpage_custom}
end on

on tab_custom.destroy
destroy(this.tabpage_custom)
end on

type tabpage_custom from userobject within tab_custom
event create ( )
event destroy ( )
integer x = 18
integer y = 132
integer width = 2304
integer height = 1432
long backcolor = 67108864
string text = "Custom Satistics"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_custom st_custom
htb_custom htb_custom
dw_custom dw_custom
end type

on tabpage_custom.create
this.st_custom=create st_custom
this.htb_custom=create htb_custom
this.dw_custom=create dw_custom
this.Control[]={this.st_custom,&
this.htb_custom,&
this.dw_custom}
end on

on tabpage_custom.destroy
destroy(this.st_custom)
destroy(this.htb_custom)
destroy(this.dw_custom)
end on

type st_custom from statictext within tabpage_custom
integer x = 91
integer y = 1336
integer width = 242
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom:"
boolean focusrectangle = false
end type

type htb_custom from htrackbar within tabpage_custom
integer x = 343
integer y = 1324
integer width = 2016
integer height = 132
integer maxposition = 100
integer tickfrequency = 10
end type

event moved;//of_zoom(scrollpos)
of_zoom(tab_custom.tabpage_custom.dw_custom, scrollpos)
end event

type dw_custom from datawindow within tabpage_custom
integer x = 32
integer y = 16
integer width = 2272
integer height = 1296
integer taborder = 10
boolean enabled = false
string title = "none"
string dataobject = "d_dept_empidcount_pie"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)


end event

type rb_onvacation from radiobutton within w_sheet_customerwindow
integer x = 1883
integer y = 768
integer width = 494
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "On Vacation"
end type

type st_lastname from statictext within w_sheet_customerwindow
integer x = 3086
integer y = 160
integer width = 402
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Last Name:"
boolean focusrectangle = false
end type

type sle_lastname from singlelineedit within w_sheet_customerwindow
integer x = 3497
integer y = 160
integer width = 667
integer height = 100
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_middlename from statictext within w_sheet_customerwindow
integer x = 1627
integer y = 160
integer width = 475
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Middle Name:"
boolean focusrectangle = false
end type

type sle_middlename from singlelineedit within w_sheet_customerwindow
integer x = 2107
integer y = 160
integer width = 667
integer height = 100
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_firstname from singlelineedit within w_sheet_customerwindow
integer x = 571
integer y = 160
integer width = 667
integer height = 100
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_firstname from statictext within w_sheet_customerwindow
integer x = 169
integer y = 160
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "First Name:"
boolean focusrectangle = false
end type

type cbx_sunday from checkbox within w_sheet_customerwindow
integer x = 3703
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sunday"
end type

type cbx_saturday from checkbox within w_sheet_customerwindow
integer x = 3113
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Saturday"
end type

type cbx_friday from checkbox within w_sheet_customerwindow
integer x = 2523
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Friday"
end type

type cbx_thursday from checkbox within w_sheet_customerwindow
integer x = 1934
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Thursday"
end type

type cbx_wednesday from checkbox within w_sheet_customerwindow
integer x = 1339
integer y = 1096
integer width = 462
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Wednesday"
end type

type cbx_tuesday from checkbox within w_sheet_customerwindow
integer x = 750
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tuesday"
end type

type cbx_monday from checkbox within w_sheet_customerwindow
integer x = 160
integer y = 1096
integer width = 457
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Monday"
end type

type rb_onleave from radiobutton within w_sheet_customerwindow
integer x = 1317
integer y = 768
integer width = 494
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "On Leave"
end type

type rb_terminated from radiobutton within w_sheet_customerwindow
integer x = 750
integer y = 768
integer width = 494
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Terminated"
end type

type rb_active from radiobutton within w_sheet_customerwindow
integer x = 183
integer y = 768
integer width = 494
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active"
boolean checked = true
end type

type cb_samplecommandbutton4 from commandbutton within w_sheet_customerwindow
integer x = 3547
integer y = 440
integer width = 933
integer height = 132
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sample CommandButton 4"
end type

type cb_samplecommandbutton3 from commandbutton within w_sheet_customerwindow
integer x = 2423
integer y = 440
integer width = 933
integer height = 132
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sample CommandButton 3"
end type

type cb_samplecommandbutton2 from commandbutton within w_sheet_customerwindow
integer x = 1298
integer y = 440
integer width = 933
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sample CommandButton 2"
end type

type cb_samplecommandbutton1 from commandbutton within w_sheet_customerwindow
integer x = 174
integer y = 440
integer width = 933
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sample CommandButton 1"
end type

type uo_pic_singlelineedit from u_picture_tip within w_sheet_customerwindow
event destroy ( )
string tag = "singlelineedit"
integer x = 5266
integer y = 144
integer taborder = 10
end type

on uo_pic_singlelineedit.destroy
call u_picture_tip::destroy
end on

type uo_pic_commandbutton from u_picture_tip within w_sheet_customerwindow
event destroy ( )
string tag = "commandbutton"
integer x = 5266
integer y = 456
integer taborder = 10
end type

on uo_pic_commandbutton.destroy
call u_picture_tip::destroy
end on

type uo_pic_radiobutton from u_picture_tip within w_sheet_customerwindow
event destroy ( )
string tag = "radiobutton"
integer x = 5266
integer y = 760
integer taborder = 10
end type

on uo_pic_radiobutton.destroy
call u_picture_tip::destroy
end on

type uo_pic_checkbox from u_picture_tip within w_sheet_customerwindow
event destroy ( )
string tag = "checkbox"
integer x = 5271
integer y = 1088
integer taborder = 10
end type

on uo_pic_checkbox.destroy
call u_picture_tip::destroy
end on

type gb_singlelineedit from groupbox within w_sheet_customerwindow
integer x = 82
integer y = 40
integer width = 5353
integer height = 280
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_commandbutton from groupbox within w_sheet_customerwindow
integer x = 82
integer y = 352
integer width = 5353
integer height = 280
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_status from groupbox within w_sheet_customerwindow
integer x = 82
integer y = 652
integer width = 5353
integer height = 280
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
end type

type gb_day from groupbox within w_sheet_customerwindow
integer x = 82
integer y = 980
integer width = 5353
integer height = 280
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Day"
end type

