class_name MyWell
extends Node3D


@export var start_speed: float = 1.0
@export var float_speed: float = 5.0
@export var acceleration: float = 1.0
@export var friction: float = 6.0
@export var chunk_height: float = 8.0
@export var chunks_ahead: int = 4

@export var chunks_begin: Array[PackedScene]
@export var chunks_mid: Array[PackedScene]
@export var chunks_late: Array[PackedScene]
@export var chunks_win: Array[PackedScene]

var current_speed: float
var desired_speed: float
var can_spawn_heart: bool
var more_difficult: bool
var game_over: bool
var chunks_id: int


func _ready() -> void:
	EventBus.game_win.connect(self.on_game_over)
	EventBus.game_fail.connect(self.on_game_over)

	position.y = 0.0
	current_speed = 0.0
	desired_speed = float_speed
	can_spawn_heart = false
	more_difficult = false
	game_over = false
	chunks_id = 1


func _process(delta: float) -> void:
	if current_speed < desired_speed:
		current_speed = move_toward(current_speed, desired_speed, acceleration * delta)
	else:
		current_speed = move_toward(current_speed, desired_speed, friction * delta)

	position.y += current_speed * delta

	if game_over:
		return

	if position.y > chunk_height:

		# adjust position y
		position.y -= chunk_height

		# move all children up
		for i: int in get_child_count():
			var child: Node3D = get_child(i) as Node3D
			child.position.y = chunk_height - (chunk_height * i)

		# add new chunk
		add_chunk.call_deferred()

		# remove top chunk
		get_child(0).queue_free()

		# emit signal
		EventBus.ring_passed.emit()


func set_can_spawn_heart(value: bool) -> void:
	can_spawn_heart = value


func set_chunks(value: int, difficulty: bool) -> void:
	chunks_id = value
	more_difficult = difficulty


func pick_chunk_scene() -> PackedScene:
	var scene: PackedScene
	match chunks_id:
		1:
			scene = chunks_begin.pick_random()
		2:
			scene = chunks_mid.pick_random()
		3:
			scene = chunks_late.pick_random()
		4:
			scene = chunks_win.pick_random()
	return scene


func add_chunk() -> void:
	var scene: PackedScene = pick_chunk_scene()
	var chunk: MyChunk = (scene as PackedScene).instantiate()
	add_child(chunk)
	chunk.position.y = -(chunk_height * chunks_ahead)
	chunk.rotation.y = 0.2 * PI * randi_range(0, 10)
	chunk.initialize(can_spawn_heart, more_difficult)


func on_game_over() -> void:
	game_over = true
	desired_speed = 0.0
