class_name MyGameUI
extends CanvasLayer


@onready var control_state: Control = $Control_state
@onready var control_win: Control = $Control_win
@onready var control_loose: Control = $Control_loose
@onready var label_life: Label = %Label_life
@onready var label_ring: Label = %Label_ring


func _ready() -> void:
	EventBus.game_win.connect(self.on_game_win)
	EventBus.game_fail.connect(self.on_game_fail)
	EventBus.update_player_life.connect(self.on_update_player_life)
	EventBus.update_player_ring.connect(self.on_update_player_ring)

	control_state.visible = true
	control_win.visible = false
	control_loose.visible = false


func on_game_win() -> void:
	control_win.visible = true


func on_game_fail() -> void:
	control_loose.visible = true


func _on_button_menu_pressed() -> void:
	Constants.change_scene_safe.call_deferred(Constants.menu_scene)


func on_update_player_life(value: int) -> void:
	label_life.text = Constants.label_life_str % value


func on_update_player_ring(value: int) -> void:
	label_ring.text = Constants.label_ring_str % value
