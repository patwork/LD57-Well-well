class_name MyGame
extends Node3D


@onready var world_environment: WorldEnvironment = $WorldEnvironment


func _ready() -> void:
	world_environment.environment.glow_enabled = true
	world_environment.environment.fog_enabled = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Constants.change_scene_safe.call_deferred(Constants.menu_scene)
