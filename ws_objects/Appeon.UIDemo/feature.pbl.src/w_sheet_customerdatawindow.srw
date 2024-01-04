$PBExportHeader$w_sheet_customerdatawindow.srw
forward
global type w_sheet_customerdatawindow from w_sheet
end type
type cb_add from commandbutton within w_sheet_customerdatawindow
end type
type cb_delete from commandbutton within w_sheet_customerdatawindow
end type
type cb_save from commandbutton within w_sheet_customerdatawindow
end type
type st_detail from statictext within w_sheet_customerdatawindow
end type
type dw_detail from datawindow within w_sheet_customerdatawindow
end type
type dw_browser from datawindow within w_sheet_customerdatawindow
end type
type uo_pic_datawindow from u_picture_tip within w_sheet_customerdatawindow
end type
type uo_pic_datawindow_detail from u_picture_tip within w_sheet_customerdatawindow
end type
end forward

global type w_sheet_customerdatawindow from w_sheet
string tag = "Customer Datawindow"
integer width = 4128
integer height = 3536
string title = "Customer Datawindow"
boolean controlmenu = false
string icon = ".\image\custom_datawindow.ico"
boolean center = false
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
st_detail st_detail
dw_detail dw_detail
dw_browser dw_browser
uo_pic_datawindow uo_pic_datawindow
uo_pic_datawindow_detail uo_pic_datawindow_detail
end type
global w_sheet_customerdatawindow w_sheet_customerdatawindow

forward prototypes
public function integer of_retrieve (long ll_id)
end prototypes

public function integer of_retrieve (long ll_id);integer li_return

li_return = dw_detail.retrieve(ll_id)


return li_return
end function

on w_sheet_customerdatawindow.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.st_detail=create st_detail
this.dw_detail=create dw_detail
this.dw_browser=create dw_browser
this.uo_pic_datawindow=create uo_pic_datawindow
this.uo_pic_datawindow_detail=create uo_pic_datawindow_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.st_detail
this.Control[iCurrent+5]=this.dw_detail
this.Control[iCurrent+6]=this.dw_browser
this.Control[iCurrent+7]=this.uo_pic_datawindow
this.Control[iCurrent+8]=this.uo_pic_datawindow_detail
end on

on w_sheet_customerdatawindow.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.st_detail)
destroy(this.dw_detail)
destroy(this.dw_browser)
destroy(this.uo_pic_datawindow)
destroy(this.uo_pic_datawindow_detail)
end on

event open;call super::open;dw_detail.settransobject(sqlca)

dw_browser.settransobject(sqlca)
dw_browser.retrieve("IN" )
end event

event resize;call super::resize;this.setredraw(False)

cb_delete.x  = cb_add.x + cb_add.width + 60 
cb_save.x  = cb_delete.x + cb_delete.width + 60 

dw_detail.y =  newheight -  dw_detail.height  - 180
dw_detail.width = newwidth - dw_detail.x - 100
st_detail.y = dw_detail.y - st_detail.height - 30

uo_pic_datawindow_detail.y =  st_detail.y - 20 
uo_pic_datawindow_detail.x = dw_detail.x + dw_detail.width - uo_pic_datawindow_detail.width + 10

dw_browser.height =   st_detail.y - 280
dw_browser.width = newwidth - dw_browser.x - 100

uo_pic_datawindow.x = dw_browser.x + dw_browser.width - uo_pic_datawindow.width + 10

this.setredraw(True)
end event

event ue_add;Integer li_row
Integer li_custrow
DateTime ldt_date
  
ldt_date = DateTime(Today(), Now())

IF dw_detail.modifiedcount( ) > 0 Then
	MessageBox(gs_msg_title, "Please save the data first.")
	Return 1
End IF

dw_detail.reset()
li_row = dw_detail.InsertRow(0)

dw_detail.ScrolltoRow(li_row)
dw_detail.SetRow(li_row)
dw_detail.SetItem(li_row, "persontype", "IN")
dw_detail.SetItem(li_row, "modifieddate", ldt_date)
		
Return 1


 
end event

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_personid
Long    ll_addressid
Long    ll_addresstypeid
Long    ll_phonetypeid
Long    ll_customerid
String  ls_phonenumber
DwitemStatus ldws_status

dw_detail.accepttext( )
li_row = dw_browser.GetRow()
IF li_row < 1 Then Return	1	
	li_ret = MessageBox("Delete Person", "Are you sure you want to delete this person?" , Question!, yesno!)
	IF li_ret = 1 Then
		li_row = dw_detail.GetRow()
		ldws_status = dw_detail.GetItemStatus(li_row, 0 , Primary!)
		IF ldws_status = New! Or ldws_status = NewModified! Then
			dw_detail.DeleteRow(li_row)
			dw_detail.ResetUpdate()
			Return 1
		End IF
		
		ll_personid = dw_detail.GetItemNumber(li_row, "businessentityid")
		DELETE FROM Person.BusinessEntityAddress WHERE BusinessEntityID = :ll_personid;
		IF Sqlca.Sqlcode <> 0 THEN
			RollBack;
			Return -1
		END IF
		
		DELETE FROM Person.PersonPhone  WHERE BusinessEntityID = :ll_personid;
		IF Sqlca.Sqlcode <> 0 THEN
			RollBack;
			Return -1
		END IF
		
		DELETE FROM Sales.Customer  WHERE PersonID = :ll_personid;
		IF Sqlca.Sqlcode <> 0 THEN
			RollBack;
			Return -1
		END IF
		
		dw_detail.DeleteRow(li_row)	
		li_row = dw_browser.GetRow()
		dw_browser.DeleteRow(li_row)
		
		IF dw_browser.RowCount() > 1 Then
			dw_browser.ScrollToRow(1)
		End IF					
	End IF		

IF dw_detail.Update() <> 1 THEN
	RollBack;
	Return -1
END IF

Commit;

Return 1
end event

event ue_save;Integer li_status
Long ll_row
Long ll_listrow
Long ll_rowcount
Boolean lb_error
DwItemStatus ldws_status
decimal ll_pk
DateTime ldt_now

dw_detail.AcceptText()
ll_listrow = dw_browser.GetRow()
ll_row =dw_detail.GetRow()
IF ll_row > 0 Then
	ldws_status = dw_detail.GetItemStatus(ll_row, 0, Primary!)	
End IF

dw_browser.SetRedraw(False)
If dw_detail.Modifiedcount() > 0 Then	
	IF ldws_status = Newmodified! Then
		ldt_now = DateTime(Today(), Now())
		INSERT INTO  Person.BusinessEntity(ModifiedDate) Values (:ldt_now);
		IF Sqlca.Sqlcode <> 0 THEN
			dw_browser.SetRedraw(True)
			RollBack;
			Return -1
		END IF
		
		SELECT Max(Isnull(BusinessEntityID,0)) INTO :ll_pk FROM Person.BusinessEntity;
		dw_detail.SetItem(ll_row, "BusinessEntityID", ll_pk)
	END IF
	
	li_status =  dw_detail.update()										
	IF li_status = -1 Then 
		dw_browser.SetRedraw(True)
		Rollback;
		Return -1 
	END IF
	
	IF ldws_status = Newmodified! Then
		ll_listrow = dw_browser.rowcount()  + 1
		dw_detail.Rowscopy(ll_row, ll_row, primary!,dw_browser, ll_listrow, primary!)	
		dw_browser.ResetUpdate()
	ElseIF ldws_status = DataModified! Then
		ll_row = dw_detail.GetRow()
		dw_detail.Rowscopy(ll_row, ll_row, primary!, dw_browser, ll_listrow + 1, primary!)	
		dw_browser.DeleteRow(ll_listrow)
	End IF
	
	dw_browser.ScrollToRow(ll_listrow)
	dw_browser.SelectRow (0, False)
	dw_browser.SelectRow (ll_listrow, True)		
Else	
	dw_browser.SetRedraw(True)
	Return 1	
End IF

dw_browser.SetRedraw(True)

MessageBox(gs_msg_title, "Saved the data successfully.")
Commit;

Return 1
end event

type cb_add from commandbutton within w_sheet_customerdatawindow
integer x = 82
integer y = 40
integer width = 357
integer height = 120
integer taborder = 20
boolean bringtotop = true
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

type cb_delete from commandbutton within w_sheet_customerdatawindow
integer x = 503
integer y = 40
integer width = 357
integer height = 120
integer taborder = 20
boolean bringtotop = true
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

type cb_save from commandbutton within w_sheet_customerdatawindow
integer x = 923
integer y = 40
integer width = 357
integer height = 120
integer taborder = 20
boolean bringtotop = true
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

type st_detail from statictext within w_sheet_customerdatawindow
integer x = 91
integer y = 2136
integer width = 402
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_sheet_customerdatawindow
integer x = 82
integer y = 2256
integer width = 3927
integer height = 1124
integer taborder = 20
string title = "none"
string dataobject = "d_person"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;if dwo.name = "b_modify" then 
	this.modify("emailpromotion.color=255")
end if 
end event

type dw_browser from datawindow within w_sheet_customerdatawindow
integer x = 82
integer y = 176
integer width = 3927
integer height = 1912
integer taborder = 20
string title = "none"
string dataobject = "d_person_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;Long  ll_businessentityid
Integer li_ret

IF currentrow < 1 Then 	
	Return -1
End IF

dw_detail.AcceptText()

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

ll_businessentityid = This.GetItemNumber(currentrow, "businessentityid")

of_retrieve( ll_businessentityid)


end event

type uo_pic_datawindow from u_picture_tip within w_sheet_customerdatawindow
event destroy ( )
string tag = "datawindow"
integer x = 3867
integer y = 40
integer taborder = 10
end type

on uo_pic_datawindow.destroy
call u_picture_tip::destroy
end on

type uo_pic_datawindow_detail from u_picture_tip within w_sheet_customerdatawindow
event destroy ( )
string tag = "datawindow_detail"
integer x = 3867
integer y = 2124
integer taborder = 10
end type

on uo_pic_datawindow_detail.destroy
call u_picture_tip::destroy
end on

