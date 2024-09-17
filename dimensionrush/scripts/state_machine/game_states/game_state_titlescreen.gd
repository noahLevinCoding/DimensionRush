class_name GameStateTitlescreen
extends State

var titlescreen_menu_scene : PackedScene = preload("res://scenes/game_state_menues/titlescreen.tscn")
var titlescreen_menu_instance : Node = null

func enter():
	titlescreen_menu_instance = titlescreen_menu_scene.instantiate()
	add_child(titlescreen_menu_instance)
