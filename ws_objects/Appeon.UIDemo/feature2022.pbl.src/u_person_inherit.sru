$PBExportHeader$u_person_inherit.sru
forward
global type u_person_inherit from u_person_master
end type
end forward

global type u_person_inherit from u_person_master
end type
global u_person_inherit u_person_inherit

on u_person_inherit.create
int iCurrent
call super::create
end on

on u_person_inherit.destroy
call super::destroy
end on

type dw_detail from u_person_master`dw_detail within u_person_inherit
end type

type dw_browser from u_person_master`dw_browser within u_person_inherit
end type

type st_detail from u_person_master`st_detail within u_person_inherit
end type

type uo_search from u_person_master`uo_search within u_person_inherit
end type

type uo_pic_custom from u_person_master`uo_pic_custom within u_person_inherit
end type

type cb_save from u_person_master`cb_save within u_person_inherit
end type

type cb_delete from u_person_master`cb_delete within u_person_inherit
end type

type cb_add from u_person_master`cb_add within u_person_inherit
end type

