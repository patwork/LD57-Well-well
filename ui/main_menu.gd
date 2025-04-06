class_name MyMainMenu
extends Control


@onready var button_quit: Button = $MarginContainer/VBoxContainer/Button_quit
@onready var loading: CanvasLayer = $Loading
@onready var animation_player: AnimationPlayer = $Loading/AnimationPlayer


func _ready() -> void:
	if OS.get_name() == "Web":
		button_quit.visible = false
	loading.visible = false
	animation_player.play("RESET")


func _on_button_start_pressed() -> void:
	loading.visible = true
	animation_player.play("loading")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(Constants.game_scene)


func _on_button_info_pressed() -> void:
	get_tree().change_scene_to_file(Constants.info_scene)


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_fullscreen_pressed() -> void:
	var mode: int = DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
