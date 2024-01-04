$PBExportHeader$w_sheet.srw
forward
global type w_sheet from window
end type
end forward

global type w_sheet from window
integer width = 4146
integer height = 2812
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type integer ue_add ( )
event type integer ue_delete ( )
event type integer ue_filter ( )
event type integer ue_save ( )
event type integer ue_modify ( )
event type integer ue_cancel ( )
end type
global w_sheet w_sheet

type variables
u_dw_master_detail iuo_dw
end variables

event type integer ue_add();
if isvalid(iuo_dw) then
	iuo_dw.Dynamic Event ue_add()
end if 

Return 1
end event

event type integer ue_delete();
if isvalid(iuo_dw) then
	iuo_dw.Dynamic Event ue_delete()
end if 
 
Return 1

end event

event type integer ue_filter();
if isvalid(iuo_dw) then
	iuo_dw.Dynamic Event ue_filter()
end if 

Return 1
end event

event type integer ue_save();Int li_ret

if isvalid(iuo_dw) then
	li_ret = iuo_dw.Dynamic Event ue_save()
end if 

Return li_ret
end event

event type integer ue_modify(); 
if isvalid(iuo_dw) then
	iuo_dw.Dynamic Event ue_modify()
end if 

Return 1
end event

event type integer ue_cancel();Int li_ret

if isvalid(iuo_dw) then
	li_ret = iuo_dw.Dynamic Event ue_cancel()
end if 
 
Return li_ret

end event

on w_sheet.create
end on

on w_sheet.destroy
end on

event closequery;Int li_ret
IF Isvalid(iuo_dw) then
	IF iuo_dw.ib_modify Then
		li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
		IF li_ret = 1 Then
			IF This.Event ue_save() <> 1 THEN Return 0
		End IF
	End IF
End IF


end event

