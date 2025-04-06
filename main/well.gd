class_name MyWell
extends Node3D


@export var float_speed: float = 5.0
@export var chunk_height: float = 8.0
@export var chunks_ahead: int = 4
@export var chunks: Array[PackedScene]


func _ready() -> void:
	assert(not chunks.is_empty())
	position.y = 0.0


func _process(delta: float) -> void:
	position.y += float_speed * delta

	if position.y > chunk_height:

		# adjust position y
		position.y -= chunk_height

		# move all children up
		for i: int in get_child_count():
			var child: Node3D = get_child(i) as Node3D
			child.position.y = chunk_height - (chunk_height * i)

		# add new chunk
		var scene: PackedScene = chunks.pick_random()
		var chunk: MyChunk = (scene as PackedScene).instantiate()
		add_child(chunk)
		chunk.position.y = -(chunk_height * chunks_ahead)
		chunk.rotation.y = 0.2 * PI * randi_range(0, 10)

		# remove top chunk
		get_child(0).queue_free()
