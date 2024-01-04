$PBExportHeader$u_picture_tip.sru
forward
global type u_picture_tip from userobject
end type
type p_picture from picture within u_picture_tip
end type
end forward

global type u_picture_tip from userobject
integer width = 110
integer height = 96
long backcolor = 553648127
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type integer ue_clicked ( )
p_picture p_picture
end type
global u_picture_tip u_picture_tip

forward prototypes
public function integer resize (integer w, integer h)
public function integer of_regpicture (string as_picture)
public function integer of_setpointer (string as_pointer)
public subroutine of_settag (string as_tag)
end prototypes

event type integer ue_clicked();OpenWithParm(w_tip,this.tag )

return 1
end event

public function integer resize (integer w, integer h);p_picture.width = w
p_picture.height = h


return 1
end function

public function integer of_regpicture (string as_picture);p_picture.picturename = as_picture

return 1
end function

public function integer of_setpointer (string as_pointer);p_picture.pointer = as_pointer
this.pointer = as_pointer

return 1
end function

public subroutine of_settag (string as_tag);this.tag = as_tag

end subroutine

on u_picture_tip.create
this.p_picture=create p_picture
this.Control[]={this.p_picture}
end on

on u_picture_tip.destroy
destroy(this.p_picture)
end on

type p_picture from picture within u_picture_tip
integer width = 110
integer height = 96
boolean originalsize = true
string picturename = "image\tip.png"
boolean focusrectangle = false
end type

event clicked;call super::clicked;parent.trigger event ue_clicked()
end event

