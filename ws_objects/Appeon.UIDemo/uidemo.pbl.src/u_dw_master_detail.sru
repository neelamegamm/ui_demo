$PBExportHeader$u_dw_master_detail.sru
forward
global type u_dw_master_detail from userobject
end type
type dw_detail from u_dw within u_dw_master_detail
end type
type dw_browser from u_dw within u_dw_master_detail
end type
end forward

global type u_dw_master_detail from userobject
integer width = 3291
integer height = 2156
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type integer ue_add ( )
event type integer ue_delete ( )
event type integer ue_save ( )
event type integer ue_filter ( )
event type integer ue_modify ( )
event type integer ue_cancel ( )
dw_detail dw_detail
dw_browser dw_browser
end type
global u_dw_master_detail u_dw_master_detail

type variables
u_dw 								iuo_currentdw
u_dw_master_detail		 	iuo_parent				
Boolean ib_modify = False
Long il_last_row
 
end variables

forward prototypes
public function integer of_winopen ()
public function integer of_retrieve (u_dw adw_data, string as_data)
end prototypes

event type integer ue_add();

Return 1
end event

event type integer ue_delete();Integer li_row
DwItemStatus ldws_status

li_row = iuo_currentdw.GetRow()

IF li_row < 1 Then Return 0
ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
IF ldws_status = New! Or ldws_status = NewModified! Then
	iuo_currentdw.DeleteRow(li_row)
	iuo_currentdw.ReSetUpdate()
	Return 1
End IF

Return 0
end event

event type integer ue_save();
Return 1
end event

event type integer ue_filter();
Return 1
end event

event type integer ue_modify();//Edit 
If iuo_currentdw.ClassName( ) = "dw_browser" Then
//	tab_1.tabpage_1.dw_browser.TriggerEvent (DoubleClicked!)
End If

Return 1
end event

event type integer ue_cancel();
//
Return 1
end event

public function integer of_winopen ();return 1
end function

public function integer of_retrieve (u_dw adw_data, string as_data);return 1
end function

on u_dw_master_detail.create
this.dw_detail=create dw_detail
this.dw_browser=create dw_browser
this.Control[]={this.dw_detail,&
this.dw_browser}
end on

on u_dw_master_detail.destroy
destroy(this.dw_detail)
destroy(this.dw_browser)
end on

event constructor;iuo_parent = This
end event

type dw_detail from u_dw within u_dw_master_detail
event ue_save ( )
integer y = 980
integer width = 3264
integer height = 1116
integer taborder = 10
end type

event ue_save();//
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

event getfocus;call super::getfocus;iuo_currentdw = This

end event

event losefocus;call super::losefocus;IF Not ib_modify THEN
	This.AcceptText( )
END IF
end event

type dw_browser from u_dw within u_dw_master_detail
event ue_save ( )
integer width = 3264
integer height = 908
integer taborder = 10
end type

event ue_save();//
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

event getfocus;call super::getfocus;iuo_currentdw = This

end event

event losefocus;call super::losefocus;IF Not ib_modify THEN
	This.AcceptText( )
END IF
end event

