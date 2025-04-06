class_name MyChunk
extends Node3D


func initialize(can_spawn_heart: bool, more_difficult: bool) -> void:
	for child: Node in get_children():

		if not can_spawn_heart and child.is_in_group("item_heart"):
			child.queue_free()

		if more_difficult and child.is_in_group("item_fan"):
			(child as MyObstacleFan).enable_rotation()
