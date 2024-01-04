$PBExportHeader$u_person.sru
forward
global type u_person from u_dw_master_detail
end type
type st_detail from statictext within u_person
end type
type uo_search from u_searchbox within u_person
end type
type uo_pic_custom from u_picture_tip within u_person
end type
type cb_save from commandbutton within u_person
end type
type cb_delete from commandbutton within u_person
end type
type cb_add from commandbutton within u_person
end type
end forward

global type u_person from u_dw_master_detail
integer width = 3744
integer height = 2708
st_detail st_detail
uo_search uo_search
uo_pic_custom uo_pic_custom
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
end type
global u_person u_person

type variables
Long il_personid = 0
String is_persontype = "IN"
end variables

forward prototypes
public function integer resize (integer w, integer h)
public function integer of_winopen ()
public function integer of_retrieve (u_dw adw_data, string as_data)
end prototypes

public function integer resize (integer w, integer h);this.setredraw(False)

cb_add.x = uo_search.x + uo_search.width + 60
cb_delete.x = cb_add.x +  cb_add.width + 60
cb_save.x = cb_delete.x +  cb_delete.width + 60

//Detail
dw_detail.width = w - dw_detail.x   - 30
dw_detail.y = h  - dw_detail.height  - 100
st_detail.y = dw_detail.y  - 10 - st_detail.height

//Browse
dw_browser.width = w - dw_browser.x   - 30
dw_browser.height = st_detail.y - dw_browser.y  - 48

uo_pic_custom.x = dw_browser.x + dw_browser.width - uo_pic_custom.width

this.setredraw(True)

return 1 
end function

public function integer of_winopen ();

dw_browser.Retrieve(is_persontype)


return 1 
end function

public function integer of_retrieve (u_dw adw_data, string as_data);String ls_persontype
Long ll_businessentityid

Choose Case adw_data.ClassName()
	Case "dw_browser"
		ll_businessentityid = Long(as_data)
		dw_detail.Retrieve(ll_businessentityid )
		
End Choose

Return 1
end function

on u_person.create
int iCurrent
call super::create
this.st_detail=create st_detail
this.uo_search=create uo_search
this.uo_pic_custom=create uo_pic_custom
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_detail
this.Control[iCurrent+2]=this.uo_search
this.Control[iCurrent+3]=this.uo_pic_custom
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_add
end on

on u_person.destroy
call super::destroy
destroy(this.st_detail)
destroy(this.uo_search)
destroy(this.uo_pic_custom)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
end on

event ue_filter;call super::ue_filter;String ls_filter
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

event ue_add;call super::ue_add;Integer li_row
Integer li_custrow
DateTime ldt_date
  
ldt_date = DateTime(Today(), Now())
Choose Case iuo_currentdw.ClassName()
	Case "dw_browser", "dw_detail"
		
		IF ib_Modify = True Then
			MessageBox(gs_msg_title, "Please save the data first.")
			Return 1
		End IF

		iuo_currentdw = dw_detail
		iuo_currentdw.reset()
		li_row = iuo_currentdw.InsertRow(0)
		
		iuo_currentdw.ScrolltoRow(li_row)
		iuo_currentdw.SetRow(li_row)
		iuo_currentdw.SetItem(li_row, "persontype", is_persontype)
		iuo_currentdw.SetItem(li_row, "modifieddate", ldt_date)
		
	Case ""
		
End Choose

ib_modify = True

Return 1


 
end event

event ue_delete;call super::ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_personid
Long    ll_addressid
Long    ll_addresstypeid
Long    ll_phonetypeid
Long    ll_customerid
String  ls_phonenumber
DwitemStatus ldws_status

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return	1	

Choose case iuo_currentdw.ClassName()
	Case	"dw_browser", "dw_detail"		
		li_ret = MessageBox("Delete Person", "Are you sure you want to delete this person?" , Question!, yesno!)
		IF li_ret = 1 Then
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				iuo_currentdw.ReSetUpdate()
				Return 1
			End IF
			
			ll_personid = iuo_currentdw.GetItemNumber(li_row, "businessentityid")
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
			
			iuo_currentdw.DeleteRow(li_row)	
			
			IF iuo_currentdw.ClassName() = "dw_detail" Then
				li_row = dw_browser.GetRow()
				dw_browser.DeleteRow(li_row)
				
				IF dw_browser.RowCount() > 1 Then
					dw_browser.ScrollToRow(1)
				End IF
			End IF					
		End IF		
	Case ""
		
End Choose


IF iuo_currentdw.Update() <> 1 THEN
	RollBack;
	Return -1
END IF

ib_Modify = False
Commit;

Return 1
end event

event ue_save;call super::ue_save;Integer li_status
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
		il_personid = ll_pk
	END IF
	
	li_status =  dw_detail.update()
	IF li_status = -1 Then 
		dw_browser.SetRedraw(True)
		Rollback;
		Return -1 
	END IF
	
	ib_modify = False
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
ib_modify = False

MessageBox(gs_msg_title, "Saved the data successfully.")
Commit;

Return 1
end event

type dw_detail from u_dw_master_detail`dw_detail within u_person
integer y = 1764
integer width = 3735
integer height = 924
string dataobject = "d_person"
end type

event dw_detail::buttonclicked;call super::buttonclicked;
if dwo.name = "b_modify" then 
	this.modify("emailpromotion.color=255")
end if 
end event

type dw_browser from u_dw_master_detail`dw_browser within u_person
integer y = 172
integer width = 3735
integer height = 1464
string dataobject = "d_person_list"
boolean vscrollbar = true
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;Long  ll_businessentityid
Integer li_ret

IF currentrow < 1 Then 	
	Return -1
End IF

dw_detail.AcceptText()

IF ib_Modify = True Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		Return 1
	ELSE
		iuo_currentdw = dw_detail
//		of_restore_data()
		iuo_currentdw = This
	End IF
End IF

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

ll_businessentityid = This.GetItemNumber(currentrow, "businessentityid")
il_personid = ll_businessentityid

of_retrieve(This, String(ll_businessentityid))	
ib_modify = False

il_last_row = currentrow


end event

type st_detail from statictext within u_person
integer y = 1668
integer width = 402
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail:"
boolean focusrectangle = false
end type

type uo_search from u_searchbox within u_person
integer y = 28
integer taborder = 10
boolean bringtotop = true
end type

on uo_search.destroy
call u_searchbox::destroy
end on

event constructor;call super::constructor;of_setplaceholder("Filter by Last Name / First Name")
of_setrealtimesearch(true)
end event

event ue_search;call super::ue_search;Parent.Post Event ue_filter()
end event

type uo_pic_custom from u_picture_tip within u_person
string tag = "custom"
integer x = 3625
integer y = 32
integer taborder = 50
end type

on uo_pic_custom.destroy
call u_picture_tip::destroy
end on

type cb_save from commandbutton within u_person
integer x = 2286
integer y = 32
integer width = 357
integer height = 120
integer taborder = 30
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

type cb_delete from commandbutton within u_person
integer x = 1865
integer y = 32
integer width = 357
integer height = 120
integer taborder = 40
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

type cb_add from commandbutton within u_person
integer x = 1445
integer y = 32
integer width = 357
integer height = 120
integer taborder = 40
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

