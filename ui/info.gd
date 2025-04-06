extends Control


func _on_button_return_pressed() -> void:
		get_tree().change_scene_to_file(Constants.menu_scene)
