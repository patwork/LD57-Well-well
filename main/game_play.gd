class_name MyGameplay
extends Node3D


@export var new_game_life: int = 3
@export var new_game_ring: int = 1

var player_life: int:
	set(value):
		player_life = value
		EventBus.update_player_life.emit(value)
	get():
		return player_life

var player_ring: int:
	set(value):
		player_ring = value
		EventBus.update_player_ring.emit(value)
	get():
		return player_ring


func _ready() -> void:
	EventBus.game_start.connect(self.on_game_start)
	EventBus.game_win.connect(self.on_game_win)
	EventBus.game_fail.connect(self.on_game_fail)
	EventBus.collected_heart.connect(self.on_collected_heart)
	EventBus.ring_passed.connect(self.on_ring_passed)


func on_game_start() -> void:
	print_debug("game_start")

	player_life = new_game_life
	player_ring = new_game_ring


func on_game_win() -> void:
	print_debug("game_win")


func on_game_fail() -> void:
	print_debug("game_fail")


func on_collected_heart() -> void:
	player_life += 1


func on_ring_passed() -> void:
	player_ring += 1
