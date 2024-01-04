$PBExportHeader$u_custom.sru
forward
global type u_custom from userobject
end type
type uo_search from u_searchbox within u_custom
end type
type cb_add from commandbutton within u_custom
end type
type cb_delete from commandbutton within u_custom
end type
type cb_save from commandbutton within u_custom
end type
type dw_browser from u_dw within u_custom
end type
type uo_pic_userobject from u_picture_tip within u_custom
end type
end forward

global type u_custom from userobject
integer width = 3488
integer height = 2952
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type integer ue_filter ( )
event type integer ue_add ( )
event type integer ue_cancel ( )
event type integer ue_delete ( )
event type integer ue_modify ( )
event type integer ue_save ( )
uo_search uo_search
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
dw_browser dw_browser
uo_pic_userobject uo_pic_userobject
end type
global u_custom u_custom

type variables
u_dw iuo_currentdw
end variables

forward prototypes
public function integer resize (integer w, integer h)
end prototypes

event type integer ue_filter();String ls_filter
String ls_txt

ls_txt = uo_search.of_getsearchtext() 		//  sle_filter.text
ls_filter = ""
IF Len(ls_txt) > 0 Then
	ls_txt = "%" + ls_txt + "%"
	dw_browser.SetFilter("(lastname like '" + ls_txt+"') or (firstname like '" + ls_txt+"')")
	dw_browser.Filter()
	IF dw_browser.RowCount() > 0 THEN
		dw_browser.Event RowFocusChanged(1)
		dw_browser.ScrollToRow(1)
		dw_browser.SetRow(1)		
	END IF
Else
	dw_browser.SetFilter("")
	dw_browser.Filter()
End IF

Return 1
end event

event type integer ue_add();Integer li_row
Integer li_custrow
DateTime ldt_date
  
ldt_date = DateTime(Today(), Now())
IF iuo_currentdw.modifiedcount( ) > 0   Then
	MessageBox(gs_msg_title, "Please save the data first.")
	Return 0
End IF

li_row = iuo_currentdw.InsertRow(0)

iuo_currentdw.ScrolltoRow(li_row)
iuo_currentdw.SetRow(li_row)
iuo_currentdw.SetItem(li_row, "persontype", "IN")
iuo_currentdw.SetItem(li_row, "modifieddate", ldt_date)
		
Return 1
end event

event type integer ue_cancel();
//of_restore_data()
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
Elseif ldws_status = NotModified! or ldws_status =  DataModified! Then
	iuo_currentdw.DeleteRow(li_row)
	iuo_currentdw.Update()
	Return 1
End IF

Return 0
end event

event type integer ue_modify();//Edit 
If iuo_currentdw.ClassName( ) = "dw_browser" Then
//	tab_1.tabpage_1.dw_browser.TriggerEvent (DoubleClicked!)
End If

Return 1
end event

event type integer ue_save();Integer li_status
Long ll_row
Long ll_listrow
Long ll_rowcount
Boolean lb_error
DwItemStatus ldws_status
decimal ll_pk
DateTime ldt_now

 
ll_row = dw_browser.GetRow()
IF ll_row > 0 Then
	ldws_status = dw_browser.GetItemStatus(ll_row, 0, Primary!)	
End IF

If dw_browser.Modifiedcount() > 0 Then
	IF ldws_status = Newmodified! Then
		ldt_now = DateTime(Today(), Now())
		INSERT INTO  Person.BusinessEntity(ModifiedDate) Values (:ldt_now);
		IF Sqlca.Sqlcode <> 0 THEN
			dw_browser.SetRedraw(True)
			RollBack;
			Return -1
		END IF
		
		SELECT Max(Isnull(BusinessEntityID,0)) INTO :ll_pk FROM Person.BusinessEntity;
		dw_browser.SetItem(ll_row, "BusinessEntityID", ll_pk)
	END IF
	
	li_status =  dw_browser.update()										
	IF li_status = -1 Then 
		Rollback;
		Return -1 
	END IF	
		
Else	
	Return 0
End IF

MessageBox(gs_msg_title, "Saved the data successfully.")
Commit;

Return 1
end event

public function integer resize (integer w, integer h);this.setredraw(False)

cb_add.x = uo_search.x + uo_search.width + 60
cb_delete.x = cb_add.x + cb_add.width + 60
cb_save.x = cb_delete.x + cb_delete.width + 60

dw_browser.width = w - ( dw_browser.x * 2 )
dw_browser.height = h - dw_browser.y - 80

uo_pic_userobject.x = dw_browser.x + dw_browser.width - uo_pic_userobject.width + 10

this.setredraw(True)

return 1 
end function

on u_custom.create
this.uo_search=create uo_search
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.dw_browser=create dw_browser
this.uo_pic_userobject=create uo_pic_userobject
this.Control[]={this.uo_search,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.dw_browser,&
this.uo_pic_userobject}
end on

on u_custom.destroy
destroy(this.uo_search)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.dw_browser)
destroy(this.uo_pic_userobject)
end on

event constructor;
dw_browser.settransobject( sqlca)
dw_browser.retrieve("IN")

iuo_currentdw = dw_browser
end event

type uo_search from u_searchbox within u_custom
integer x = 64
integer y = 76
integer taborder = 50
end type

on uo_search.destroy
call u_searchbox::destroy
end on

event constructor;call super::constructor;of_setplaceholder("Filter by Last Name / First Name")
of_setrealtimesearch(true)
end event

event ue_search;call super::ue_search;Parent.Post Event ue_filter()
end event

type cb_add from commandbutton within u_custom
integer x = 1513
integer y = 80
integer width = 357
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;Parent.Event ue_add()
end event

type cb_delete from commandbutton within u_custom
integer x = 1934
integer y = 80
integer width = 357
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;Parent.Event ue_delete()
end event

type cb_save from commandbutton within u_custom
integer x = 2354
integer y = 80
integer width = 357
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;Parent.Event ue_save()
end event

type dw_browser from u_dw within u_custom
integer x = 64
integer y = 236
integer width = 3360
integer height = 2652
integer taborder = 10
string dataobject = "d_customuserobject"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
IF currentrow < 1 Then 	
	Return -1
End IF

This.SelectRow(0, False)
This.SelectRow(currentrow, True)
end event

type uo_pic_userobject from u_picture_tip within u_custom
event destroy ( )
string tag = "userobject"
integer x = 3278
integer y = 80
integer taborder = 30
end type

on uo_pic_userobject.destroy
call u_picture_tip::destroy
end on

