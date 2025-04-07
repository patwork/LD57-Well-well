extends Node3D


func _ready() -> void:

	# var sfx: int = AudioServer.get_bus_index("SFX")
	# AudioServer.set_bus_mute(sfx, true)

	for child: Node in get_children():
		if child is AudioStreamPlayer3D:
			child.volume_db = -79.99 # shhhh
			child.play()

	# await get_tree().create_timer(2.0).timeout
	# AudioServer.set_bus_mute(sfx, false)
