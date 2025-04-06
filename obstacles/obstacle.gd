class_name MyObstacle
extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is MyPlayer:
		EventBus.hit_by_obstacle.emit(self)
