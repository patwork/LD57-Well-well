class_name MyObstacle
extends Area3D


@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sounds: Node3D = $Sounds


func _on_body_entered(body: Node3D) -> void:
	if body is not MyPlayer:
		return

	var sound: AudioStreamPlayer3D = sounds.get_children().pick_random()
	if not sound.playing:
		sound.pitch_scale = randf_range(0.8, 1.2)
		sound.play()

	EventBus.hit_by_obstacle.emit(self)
