class_name MyItemHeart
extends MyItem


func _on_body_entered(body: Node3D) -> void:
	if body is not MyPlayer:
		return

	set_deferred("monitoring", false)
	mesh_instance_3d.visible = false
	gpu_particles_3d.emitting = true
	audio_stream_player_3d.play()
	EventBus.collected_heart.emit()
