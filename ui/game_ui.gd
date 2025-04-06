class_name MyGameUI
extends CanvasLayer


@onready var control_state: Control = $Control_state
@onready var control_win: Control = $Control_win
@onready var control_loose: Control = $Control_loose
@onready var label_life: Label = %Label_life
@onready var label_ring: Label = %Label_ring


func _ready() -> void:
	control_state.visible = true
	control_win.visible = false
	control_loose.visible = false


func _on_button_menu_pressed() -> void:
	Constants.change_scene_safe.call_deferred(Constants.menu_scene)
