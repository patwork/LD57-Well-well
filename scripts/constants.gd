extends Node

var menu_scene: StringName = "res://ui/main_menu.tscn"
var info_scene: StringName = "res://ui/info.tscn"
var game_scene: StringName = "res://main/game.tscn"

var label_life_str: StringName = "LIFE: %d"
var label_ring_str: StringName = "RING: %d"

func change_scene_safe(filename: StringName) -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file(filename)
