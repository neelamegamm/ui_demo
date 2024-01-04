$PBExportHeader$w_sheet_customeruserobject.srw
forward
global type w_sheet_customeruserobject from w_sheet
end type
type uo_custom from u_custom within w_sheet_customeruserobject
end type
end forward

global type w_sheet_customeruserobject from w_sheet
string tag = "Customer UserObject"
integer width = 3707
integer height = 3208
string title = "Customer UserObject"
boolean controlmenu = false
string icon = ".\image\custom_useobject.ico"
boolean center = false
uo_custom uo_custom
end type
global w_sheet_customeruserobject w_sheet_customeruserobject

on w_sheet_customeruserobject.create
int iCurrent
call super::create
this.uo_custom=create uo_custom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_custom
end on

on w_sheet_customeruserobject.destroy
call super::destroy
destroy(this.uo_custom)
end on

event open;call super::open;string 	ls_theme

ls_theme = GetTheme()
IF ls_theme = "Flat Design Dark" THEN	
	//set backcolor
	uo_custom.uo_search.of_setcolor_inner(rgb(32,33,38))
end if 


end event

event resize;call super::resize;uo_custom.width = newwidth  - uo_custom.x - 80
uo_custom.height = newheight - uo_custom.y - 80 - 600

uo_custom.resize( uo_custom.width, uo_custom.height )
end event

event ue_add;
uo_custom.Dynamic Event ue_add()

return 1 
end event

event ue_delete;
uo_custom.Dynamic Event ue_delete()

return 1 
end event

event ue_filter;
uo_custom.Dynamic Event ue_filter()

return 1 
end event

event ue_save;
uo_custom.Dynamic Event ue_save()

return 1 
end event

type uo_custom from u_custom within w_sheet_customeruserobject
integer x = 82
integer y = 80
integer width = 3470
integer height = 2936
integer taborder = 10
string text = "Custom Object"
end type

on uo_custom.destroy
call u_custom::destroy
end on

