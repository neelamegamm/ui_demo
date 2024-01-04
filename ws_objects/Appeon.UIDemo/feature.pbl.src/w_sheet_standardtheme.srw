$PBExportHeader$w_sheet_standardtheme.srw
forward
global type w_sheet_standardtheme from w_sheet
end type
type uo_person from u_person within w_sheet_standardtheme
end type
end forward

global type w_sheet_standardtheme from w_sheet
string tag = "Standard Theme"
integer width = 3963
integer height = 2932
string title = "Standard Theme"
boolean controlmenu = false
string icon = ".\image\Standard_Theme.ico"
boolean center = false
uo_person uo_person
end type
global w_sheet_standardtheme w_sheet_standardtheme

on w_sheet_standardtheme.create
int iCurrent
call super::create
this.uo_person=create uo_person
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_person
end on

on w_sheet_standardtheme.destroy
call super::destroy
destroy(this.uo_person)
end on

event resize;call super::resize;uo_person.width = newwidth - uo_person.x - 80
uo_person.height = newheight - 80 - uo_person.y

uo_person. resize( uo_person.width, uo_person.height )	 



end event

event open;call super::open;string 	ls_theme

iuo_dw = uo_person
uo_person.of_winopen()
uo_person.dw_browser.SetFocus()

ls_theme = GetTheme()
IF ls_theme = "Flat Design Dark" THEN	
	//set backcolor
	 uo_person.uo_search.of_setcolor_inner(rgb(32,33,38))
end if 

uo_person.uo_pic_custom.of_settag("standard")
end event

type uo_person from u_person within w_sheet_standardtheme
integer x = 82
integer y = 20
integer width = 3781
integer height = 2744
integer taborder = 20
end type

on uo_person.destroy
call u_person::destroy
end on

