class_name MyCamera
extends Camera3D


@export var player: MyPlayer = null
@export var in_game: bool = true # FIXME
@export var starting_position: Vector3 = Vector3(0.0, 1.0, 0.0)
@export var starting_fov: float = 75.0
@export var pan_speed: float = 3.0


func _ready() -> void:
	assert(player)
	position = starting_position
	fov = starting_fov


func _process(delta: float) -> void:
	if not in_game:
		return

	var pos_camera: Vector2 = Vector2(position.x, position.z)
	var pos_player: Vector2 = Vector2(player.position.x, player.position.z)
	var dist: float = pos_camera.distance_to(pos_player)

	pos_camera = pos_camera.move_toward(pos_player, pan_speed * dist * delta)
	position = Vector3(pos_camera.x, starting_position.y, pos_camera.y)
