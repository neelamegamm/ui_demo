$PBExportHeader$w_modernui_frame.srw
$PBExportComments$Generated MDI Frame
forward
global type w_modernui_frame from window
end type
type mdi_1 from mdiclient within w_modernui_frame
end type
type mditbb_1 from tabbedbar within w_modernui_frame
end type
type rbb_main from ribbonbar within w_modernui_frame
end type
end forward

global type w_modernui_frame from window
integer width = 4123
integer height = 2748
boolean titlebar = true
string title = "UI Modernization"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean tabbedview = true
boolean maximizealltabbedsheets = true
event ue_resize ( )
mdi_1 mdi_1
mditbb_1 mditbb_1
rbb_main rbb_main
end type
global w_modernui_frame w_modernui_frame

type variables
String		is_windowslists[]
String		is_windows[], is_recents[]
String		is_themename, is_themeold
end variables

forward prototypes
public subroutine of_add_items (ref emf_str_ribbonbaritem astr_item[], string as_tag, integer ai_type)
public subroutine of_add_recentmenu (string as_window)
public subroutine of_add_windows (string as_window)
public subroutine of_opensheet (string as_window)
public subroutine of_set_item_enabled (string as_tag, integer ai_type, boolean ab_flag)
public subroutine of_set_actionsbar (boolean ab_flag, string as_panel)
public subroutine of_refresh_status (string as_window, boolean abn_active)
public subroutine of_refresh_historymenu ()
public subroutine of_recentmenuclicked (long itemhandle, long index, long subindex)
public subroutine of_menuitemclicked (long itemhandle, long index, long subindex)
public subroutine of_mastermenuclicked (long itemhandle, long index, long subindex)
public subroutine of_tabbuttonclicked (long itemhandle)
public subroutine of_closewindow (string as_type)
public subroutine of_largebuttonclicked (long itemhandle)
public subroutine of_smallbuttonclicked (long itemhandle)
end prototypes

event ue_resize();w_sheet							lw_sheet			


mdi_1.x = this.workspacex() 
mdi_1.y = this.workspacey()  +  rbb_main.height 		 				 
mdi_1.height = this.workspaceHeight() - rbb_main.height 
mdi_1.width  = this.workspaceWidth() 

rbb_main.width = this.workspaceWidth() 

//SetReDraw(False)
//This.arrangesheets( Layer! )
//SetReDraw(True)
	 
lw_sheet  = this.getactivesheet( )
if isvalid(lw_sheet)  then 
	IF lw_sheet.windowstate <> Maximized! THEN lw_sheet.windowstate = Maximized!
end if
end event

public subroutine of_add_items (ref emf_str_ribbonbaritem astr_item[], string as_tag, integer ai_type);integer			li_countitem

li_countitem = upperbound(astr_item)
li_countitem++
astr_item[li_countitem].s_tag = as_tag
astr_item[li_countitem].i_type = ai_type
end subroutine

public subroutine of_add_recentmenu (string as_window);integer 			i , li_win, li_pos
string 			ls_names, ls_recents[]
n_string			ln_string


ln_string = create n_string
li_win = upperbound(is_recents)
if li_win  > 0 then
	ln_string.of_arraytostring(is_recents,",", ls_names)
	ls_names = as_window+","+ls_names
	ln_string.of_parsetoarray( ls_names, ",", is_recents)
	
	//only support have 10 items in the Recent Menu.
	li_win = upperbound(is_recents)
	if li_win > 10 then
		for i = 1 to 10
			ls_recents[i]= is_recents[i]
		next 
		is_recents = ls_recents
	end if 
else
	li_win++
	is_recents[li_win] = as_window
end if 

destroy ln_string
end subroutine

public subroutine of_add_windows (string as_window);integer 			li_win, li_pos
string 			ls_names
n_string			ln_string


ln_string = create n_string
li_win = upperbound(is_windows)
if li_win  > 0 then
	ln_string.of_arraytostring(is_windows,",", ls_names)
	if right(ls_names, 1) <> "," then  ls_names = ls_names + ","
	li_pos = pos(ls_names, as_window+",")
	if li_pos > 0 then
		ls_names = ln_string.of_globalreplace(ls_names, as_window+",","")
	end if 
	ls_names = as_window+","+ls_names
	if right(ls_names, 1) ="," then ls_names = left(ls_names, len(ls_names) -1)
	ln_string.of_parsetoarray( ls_names, ",", is_windows)
else
	li_win++
	is_windows[li_win] = as_window
end if 

destroy ln_string


//add recentmenu
//of_add_recentmenu(as_window)

end subroutine

public subroutine of_opensheet (string as_window);w_sheet							lw_sheet			 
Integer 							li_rc
string								ls_window		


choose case as_window
	case "Standard Theme"	 
		ls_window = "w_sheet_standardtheme"
		li_rc = OpenSheet ( w_sheet_standardtheme, ls_window, this, 0, Layered!)
	case "Custom Theme"
		ls_window = "w_sheet_customtheme"
		li_rc = OpenSheet ( w_sheet_customtheme, ls_window, this, 0, Layered!)
	case "Custom Window"				
		ls_window = "w_sheet_customerwindow"
		li_rc = OpenSheet ( w_sheet_customerwindow, ls_window, this, 0, Layered!)
	case "Custom UserObject"				
		ls_window = "w_sheet_customeruserobject"
		li_rc = OpenSheet ( w_sheet_customeruserobject, ls_window, this, 0, Layered!)
	case "Custom Datawindow"				
		ls_window = "w_sheet_customerdatawindow"
		li_rc = OpenSheet ( w_sheet_customerdatawindow, ls_window, this, 0, Layered!)
	case "Inherited Object"				
		ls_window = "w_sheet_inheritedobject"
		li_rc = OpenSheet ( w_sheet_inheritedobject, ls_window, this, 0, Layered!)		
	case else
		
end choose 



end subroutine

public subroutine of_set_item_enabled (string as_tag, integer ai_type, boolean ab_flag);RibbonLargeButtonItem	lr_LargeButton
RibbonSmallButtonItem 	lr_SmallButton
RibbonCheckBoxItem 		lr_Checkbox
RibbonComboBoxItem		lr_Combobox
integer 						li_return

//ai_type = 2							// Large Button 1, Small Button 2, combo box 3, check box 4
Choose case ai_type
	case 1
		//Get Large Button Object
		li_return = rbb_main.getitembytag( as_tag,lr_LargeButton)			
		if li_return = 1 then
			if lr_LargeButton.enabled <> ab_flag then 
				//Enable the Large Button 
				lr_LargeButton.enabled = ab_flag
				//refresh the Large Button object
				rbb_main.setlargebutton(lr_LargeButton.itemhandle, lr_LargeButton ) 
			end if 
		end if 
	case 2
		//Get Small Button Object
		li_return = rbb_main.getitembytag(as_tag,lr_SmallButton)
		if li_return = 1 then
			if lr_SmallButton.enabled <> ab_flag then 
				//Enable the Small Button 
				lr_SmallButton.enabled = ab_flag
				//refresh the Small Button object
				rbb_main.setsmallbutton( lr_SmallButton.itemhandle , lr_SmallButton)
			end if 
		end if 	
	case 3
		//Get combo box Object
		li_return = rbb_main.getitembytag( as_tag,lr_Combobox)
		if li_return = 1 then
			if lr_Combobox.enabled <> ab_flag then 
				//Enable the combo box
				lr_Combobox.enabled = ab_flag
				//refresh the combo box object
				rbb_main.setcombobox(lr_Combobox.itemhandle, lr_Combobox ) 
			end if 
		end if	
	case 4
		//Get check box Object
		li_return = rbb_main.getitembytag(as_tag,lr_Checkbox)
		if li_return = 1 then
			if lr_Checkbox.enabled <> ab_flag then 
				//Enable the check box
				lr_Checkbox.enabled = ab_flag
				//refresh the check box object
				rbb_main.setcheckbox(lr_Checkbox.itemhandle, lr_Checkbox ) 
			end if 
		end if	
	case else
		//
End Choose 

end subroutine

public subroutine of_set_actionsbar (boolean ab_flag, string as_panel);emf_str_ribbonbaritem	lstr_item[]
integer						i, li_count, li_itemcount

//as_panel = 2							//largebutton 1, smallbutton 2, Combobox 3, Checkbox 4
Choose case as_panel
	case "All"
		of_add_items(lstr_item, "Add" ,2)
		of_add_items(lstr_item, "Delete" ,2)
		of_add_items(lstr_item, "Modify" ,2)
		of_add_items(lstr_item, "Save" ,2)
		of_add_items(lstr_item, "Filter" ,2)	
		
		of_add_items(lstr_item, "TileVertical" ,2)
		of_add_items(lstr_item, "TileHorizontal" ,2)
		of_add_items(lstr_item, "Layer" ,2)
		of_add_items(lstr_item, "Cascade" ,2)
		of_add_items(lstr_item, "ArrangeIcons" ,2)
		
		of_add_items(lstr_item, "Print" ,1)
		of_add_items(lstr_item, "PrintSetup" ,2)
		of_add_items(lstr_item, "PrintTitle" ,4)
		
		of_add_items(lstr_item, "CloseAll" ,2)
		of_add_items(lstr_item, "Close" ,2)
		
		of_add_items(lstr_item, "Source" ,2)
	case "Actions"
		of_add_items(lstr_item, "Add" ,2)
		of_add_items(lstr_item, "Delete" ,2)
		of_add_items(lstr_item, "Modify" ,2)
		of_add_items(lstr_item, "Save" ,2)
		of_add_items(lstr_item, "Filter" ,2)		
	case "Window"		
		of_add_items(lstr_item, "TileVertical" ,2)
		of_add_items(lstr_item, "TileHorizontal" ,2)
		of_add_items(lstr_item, "Layer" ,2)
		of_add_items(lstr_item, "Cascade" ,2)
		of_add_items(lstr_item, "ArrangeIcons" ,2)
	case "Close"
		of_add_items(lstr_item, "CloseAll" ,2)
		of_add_items(lstr_item, "Close" ,2)
	case "Print"
		of_add_items(lstr_item, "Print" ,1)
		of_add_items(lstr_item, "PrintSetup" ,2)
		of_add_items(lstr_item, "PrintTitle" ,4)
	case else
		
End Choose 

li_count = upperbound(lstr_item)
If li_count > 0 then
	for i = 1 to li_count
		of_set_item_enabled(lstr_item[i].s_tag, lstr_item[i].i_type,  ab_flag)
	next 
end if 


end subroutine

public subroutine of_refresh_status (string as_window, boolean abn_active);RibbonLargeButtonItem			lr_largebuttonitem
string 								ls_windowsTag[]={"StandardTheme","CustomTheme","CustomWindow","CustomUserObject","CustomDatawindow"}	 
string 								ls_tag, ls_picturename, ls_temp, ls_refreshwindow
integer								i,	li_return,	li_pos, li_count , li_counttag
n_string								ln_string

ln_string = create n_string
ln_string.of_arraytostring(ls_windowsTag,",", ls_temp)
//refresh Windows Listory
li_count = upperbound(is_windowslists)
if li_count  > 0 then
	ln_string.of_arraytostring(is_windowslists,",", ls_refreshwindow)
	if right(ls_refreshwindow, 1) <> "," then  ls_refreshwindow = ls_refreshwindow + ","
	li_pos = pos(ls_refreshwindow, as_window+",")
	if li_pos > 0 then
		ls_refreshwindow = ln_string.of_globalreplace(ls_refreshwindow, as_window+",","")
	end if 
	ls_refreshwindow = as_window+","+ls_refreshwindow
	if right(ls_refreshwindow, 1) ="," then ls_refreshwindow = left(ls_refreshwindow, len(ls_refreshwindow) -1)
	ln_string.of_parsetoarray( ls_refreshwindow, ",", is_windowslists)
else
	li_count++
	is_windowslists[li_count] = as_window
end if 

destroy n_string

if right(ls_temp, 1) <> "," then  ls_temp = ls_temp + ","
li_pos = pos(ls_temp, as_window+",")
if isnull(li_pos) or li_pos <= 0 then
	return 
end if 
		

end subroutine

public subroutine of_refresh_historymenu ();w_sheet								lw_sheet 
RibbonLargeButtonItem			lr_largebutton
Ribbonmenu							lrm_menu
RibbonMenuItem 					lr_MenuItem
string									ls_tag, ls_text, ls_picturename, ls_title
integer								i, li_count, li_return, li_menucount, li_menuitem, li_rtn
boolean								lbn_set_menu, lb_valid
string 								ls_windowsText[]={"Standard Theme","Custom Theme","Custom Window","Custom UserObject","Custom Datawindow"}		 
string 								ls_pic[]={"image\Standard_Theme.png","image\Custom_Theme.png","image\Custom_Window.png","image\Custom_Userobject.png","image\Custom_Datawindow.png"}


lw_sheet = this.GetActiveSheet ( )
ls_title = lw_sheet.title
If IsValid(lw_sheet) Then
	ls_tag = "History"						
	//Get Large Button Object
	li_return = rbb_main.getitembytag(ls_tag, lr_largebutton)
	if li_return = 1 then 
		if lr_largebutton.enabled = false then
			lr_largebutton.enabled = true
			lr_largebutton.defaultcommand = false
		end if 
		li_menucount = upperbound(is_windowslists) 
		li_count = upperbound(ls_windowsText)
		for li_menuitem = 1 to li_menucount
			for i = 1 to li_count
				if is_windowslists[li_menuitem] = ls_windowsText[i] then
					ls_picturename = ls_pic[i]
					ls_text = ls_windowsText[i]
					//Add ribbon menu
					lrm_menu.insertitem( li_menuitem, ls_text, ls_picturename, "ue_menuitemclicked")					
					exit;
				end if				
			next
		next 
		//Add ribbon menu to the Large Button
		lr_largebutton.setmenu( lrm_menu)
		//refresh the Large Button object
		rbb_main.setlargebutton( lr_largebutton.itemhandle , lr_largebutton)
	end if
end if 

end subroutine

public subroutine of_recentmenuclicked (long itemhandle, long index, long subindex);RibbonApplicationMenu			lr_appmenu
RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text


li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_appmenu)
if li_return = 1 then
	li_return = lr_appmenu.getrecentitem( index, lr_MenuItem)
	if li_return = 1 then
		ls_text = lr_MenuItem.text 
		Choose case ls_text
			case "Standard Theme","Custom Theme","Custom UserObject", "Custom Datawindow"
				of_opensheet(ls_text)
				of_set_actionsbar(true,"All")
				
			case  "Custom Window"
				of_opensheet(ls_text)
				of_set_actionsbar(false,"Actions")
				of_set_actionsbar(true,"Window")
				of_set_actionsbar(true,"Close")
				of_set_actionsbar(true,"Print")						
		
			case else			
											
		End Choose		
		of_refresh_status(ls_text, true)	
		of_refresh_historymenu()
	end if 
end if 
 







end subroutine

public subroutine of_menuitemclicked (long itemhandle, long index, long subindex);RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text

li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_Menu)
if li_return = 1 then
	li_return = lr_Menu.getitem(index, lr_MenuItem)
	if li_return = 1 then
		ls_text = lr_MenuItem.text 
		Choose case ls_text			
			case "Standard Theme","Custom Theme",  "Custom UserObject", "Custom Datawindow"
				of_opensheet(ls_text)
				of_set_actionsbar(true,"All")

			case "Custom Window"
				of_opensheet(ls_text)
				of_set_actionsbar(false,"Actions")
				of_set_actionsbar(true,"Window")
				of_set_actionsbar(true,"Close")
				of_set_actionsbar(true,"Print")			
			case else			

		End Choose		
		of_refresh_status(ls_text, true)		
	end if 
end if 
 







end subroutine

public subroutine of_mastermenuclicked (long itemhandle, long index, long subindex);RibbonApplicationMenu			lr_appmenu
RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text, ls_tag


li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_appmenu)
if li_return = 1 then
	if subindex > 0 then 
		li_return = lr_appmenu.getmasteritem(index, subindex, lr_MenuItem)
	else
		li_return = lr_appmenu.getmasteritem( index, lr_MenuItem)
	end if 
	
	ls_tag = lr_MenuItem.tag
	if li_return = 1 then		 
		Choose case ls_tag
			case "Quit","Exit"
				halt close
			case "Settings"
				open(w_settings)
			case "About"

			case "Readme"

			case ""
				
			case else			

		End Choose		
	end if 
end if 
 







end subroutine

public subroutine of_tabbuttonclicked (long itemhandle);String 							ls_picturename, ls_tag
integer 							li_return
RibbonTabButtonItem 		lr_Tabbuttonitem
w_sheet							lw_sheet 

li_return = rbb_main.gettabbutton(itemhandle, lr_Tabbuttonitem)
if li_return  = 1 then 
	ls_tag = 	lr_Tabbuttonitem.tag	
	Choose case ls_tag
		case "TabMinimize"
			If rbb_main.isminimized( ) Then
				rbb_main.setminimized( false)
				ls_picturename ="ArrowUpSmall!"
			Else
				rbb_main.setminimized( true)
				ls_picturename ="ArrowDownSmall!"
			End If
			lr_Tabbuttonitem.picturename = ls_picturename
			li_return = rbb_main.SetTabButton(lr_Tabbuttonitem.itemhandle, lr_Tabbuttonitem)	
			this.event ue_resize( )
			
//			lw_sheet  = this.getactivesheet( )
//			if isvalid(lw_sheet)  then 
//				lw_sheet.windowstate = Maximized!
//			end if
		case "TabHelp"

		case ""	
			
		case else
			
	End Choose
End if 
end subroutine

public subroutine of_closewindow (string as_type);w_sheet							lw_sheet			
string 							ls_title 

lw_sheet  = this.getactivesheet( )
if IsValid(lw_sheet) then 
	//Get current window title
	ls_title = lw_sheet.title				
	If as_type = "CloseAll" then			
		do 
			Close(lw_sheet)
			lw_sheet = this.getfirstsheet()			
		Loop while IsValid(lw_sheet)
		of_set_actionsbar(false,"All")
		of_refresh_status(ls_title, false)
	else		
		//close current window
		Close(lw_sheet)
		lw_sheet = this.getfirstsheet()
		if not isvalid(lw_sheet) then
			of_set_actionsbar(false,"All")
			of_refresh_status(ls_title, false)
		else
			//set false status for the close window
			of_refresh_status(ls_title, false)
			ls_title = lw_sheet.title	
			//refresh the firstsheet window.
			of_refresh_status(ls_title, true)
		 
			of_set_actionsbar(True,"Actions")		
			of_set_actionsbar(True,"Window")		
			of_set_actionsbar(True,"Print")			
		end if 
	end if 
end if 
end subroutine

public subroutine of_largebuttonclicked (long itemhandle);RibbonLargeButtonItem			lr_largebuttonitem
integer								li_return
string									ls_text


li_return = rbb_main.GetLargebutton(itemhandle, lr_largebuttonitem)
if li_return  = 1 then
	ls_text = lr_largebuttonitem.text
	choose case ls_text
		case "Standard Theme","Custom Theme","Custom UserObject","Custom Datawindow","Inherited Object"
			of_opensheet(ls_text)
			of_set_actionsbar(true,"All")

		case "Custom Window"
			of_opensheet(ls_text)
			of_set_actionsbar(false,"Actions")
			of_set_actionsbar(true,"Window")
			of_set_actionsbar(true,"Close")
			of_set_actionsbar(true,"Print")			
		
		case else
			
	end choose 
	
	of_refresh_status(ls_text, true)	
	of_refresh_historymenu()
end if 


end subroutine

public subroutine of_smallbuttonclicked (long itemhandle);RibbonSmallButtonItem			lr_smallbuttonitem
integer								li_return
string									ls_tag, ls_title
w_sheet								lw_sheet		


lw_sheet  = this.getactivesheet( )
li_return = rbb_main.GetSmallbutton(itemhandle, lr_smallbuttonitem)
if li_return  = 1 then
	ls_tag = lr_smallbuttonitem.tag
	choose case ls_tag
		case "Close"
			of_closewindow(ls_tag)
		case "CloseAll"
			of_closewindow(ls_tag)		
		case "TileVertical"
			this.ArrangeSheets ( Tile! )
		case "TileHorizontal"
			this.ArrangeSheets ( TileHorizontal! )
		case "Layer"			
			this.ArrangeSheets ( Layer! )
		case "Cascade"			
			this.ArrangeSheets ( Cascade! )
		case "ArrangeIcons"
			this.ArrangeSheets ( Icons! )
		case "PrintSetup"	
			PrintSetup ( )
		case ""				
		
		case else
			lw_sheet.dynamic TriggerEvent("ue_"+ls_tag)
	end choose 
	
end if 


end subroutine

on w_modernui_frame.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.rbb_main=create rbb_main
this.Control[]={this.mdi_1,&
this.mditbb_1,&
this.rbb_main}
end on

on w_modernui_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mditbb_1)
destroy(this.rbb_main)
end on

event open;rbb_main.importfromxmlfile( "ribbonbar.xml" )	

end event

event resize;
this.event ue_resize( )
end event

type mdi_1 from mdiclient within w_modernui_frame
long BackColor=268435456
end type

type mditbb_1 from tabbedbar within w_modernui_frame
int X=0
int Y=0
int Width=0
int Height=104
end type

type rbb_main from ribbonbar within w_modernui_frame
event ue_largebuttonclicked ( long itemhandle )
event ue_mastermenuclicked ( long itemhandle,  long index,  long subindex )
event ue_menuitemclicked ( long itemhandle,  long index,  long subindex )
event ue_recentmenuclicked ( long itemhandle,  long index,  long subindex )
event ue_smallbuttonclicked ( long itemhandle )
event ue_tabbuttonclicked ( long itemhandle )
integer x = 18
integer y = 4
integer width = 4087
integer height = 492
long backcolor = 15132390
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event ue_largebuttonclicked(long itemhandle);of_largebuttonclicked(itemhandle)
end event

event ue_mastermenuclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_mastermenuclicked( itemhandle, index,subindex)
end event

event ue_menuitemclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_menuitemclicked( itemhandle, index,subindex)
end event

event ue_recentmenuclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_recentmenuclicked( itemhandle, index,subindex)
end event

event ue_smallbuttonclicked(long itemhandle);of_smallbuttonclicked(itemhandle)
end event

event ue_tabbuttonclicked(long itemhandle);of_tabbuttonclicked(itemhandle)
end event

