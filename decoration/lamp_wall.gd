class_name MyLampWall
extends Node3D


@export var light_color: Color = Color("#e69650")
@export var light_energy: float = 1.0

@onready var omni_light_3d: OmniLight3D = $OmniLight3D


func _ready() -> void:
	omni_light_3d.light_color = light_color
	omni_light_3d.light_energy = light_energy
