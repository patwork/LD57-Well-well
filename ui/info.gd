class_name MyInfo
extends Control


func _on_button_return_pressed() -> void:
		Constants.change_scene_safe.call_deferred(Constants.menu_scene)
