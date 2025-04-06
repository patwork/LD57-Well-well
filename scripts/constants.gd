extends Node

var menu_scene: StringName = "res://ui/main_menu.tscn"
var info_scene: StringName = "res://ui/info.tscn"
var game_scene: StringName = "res://main/game.tscn"


func change_scene_safe(filename: StringName):
	await get_tree().process_frame
	get_tree().change_scene_to_file(filename)
