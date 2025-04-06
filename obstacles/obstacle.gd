class_name MyObstacle
extends Area3D


@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if body is MyPlayer:
		EventBus.hit_by_obstacle.emit(self)
