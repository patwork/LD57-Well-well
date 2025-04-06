class_name MyGameplay
extends Node3D


@onready var well: MyWell = $Well


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
	EventBus.hit_by_obstacle.connect(self.on_hit_by_obstacle)


func on_game_start() -> void:
	print_debug("game_start")

	player_life = Constants.new_game_life
	player_ring = Constants.new_game_ring
	well.set_chunks(1, false)


func on_game_win() -> void:
	print_debug("game_win")
	EventBus.controls_enabled.emit(false)


func on_game_fail() -> void:
	print_debug("game_fail")
	EventBus.controls_enabled.emit(false)


func on_collected_heart() -> void:
	player_life += 1
	if player_life >= Constants.new_game_life:
		well.set_can_spawn_heart(false)


func on_ring_passed() -> void:
	player_ring += 1

	if player_ring <= 20:
		well.set_chunks(1, false)
	elif player_ring <= 45:
		well.set_chunks(2, false)
	elif player_ring <= 70:
		well.set_chunks(3, false)
	elif player_ring <= 95:
		well.set_chunks(3, true)
	else:
		well.set_chunks(4, false)

	if player_ring == Constants.max_rings:
		EventBus.game_win.emit()


func on_hit_by_obstacle(_obstacle: MyObstacle) -> void:
	player_life -= 1
	if player_life == 0:
		EventBus.game_fail.emit()
	elif player_life <= 1:
		well.set_can_spawn_heart(true)
