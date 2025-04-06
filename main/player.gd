class_name MyPlayer
extends CharacterBody3D


@export var max_speed: float = 2.0
@export var acceleration: float = 8.0
@export var friction: float = 2.0
@export var analog_deadzone: float = 0.1
@export var guy_roll: float = 0.1

@onready var guy: MeshInstance3D = $guy/metarig/Skeleton3D/guy


func _physics_process(delta: float) -> void:
	var input_dir: Vector3 = Vector3(
		Input.get_axis("digital_left", "digital_right"),
		0.0,
		Input.get_axis("digital_up", "digital_down"),
	).normalized()

	if input_dir.length() > analog_deadzone:
		velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, friction * delta)

	guy.rotation.y = velocity.x * guy_roll

	move_and_slide()
