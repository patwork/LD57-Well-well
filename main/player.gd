class_name MyPlayer
extends CharacterBody3D


@export var max_speed: float = 2.0
@export var acceleration: float = 8.0
@export var friction: float = 2.0
@export var analog_deadzone: float = 0.1
@export var guy_roll: float = 0.1
@export var invincible_cooldown: float = 1.0

@onready var guy: MeshInstance3D = $guy/metarig/Skeleton3D/guy
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var hurt_sounds: Node3D = $HurtSounds
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var invincible: bool
var controls_enabled: bool


func _ready() -> void:
	assert(guy)

	EventBus.game_win.connect(self.on_game_win)
	EventBus.hit_by_obstacle.connect(self.on_hit_by_obstacle)
	EventBus.controls_enabled.connect(self.on_controls_enabled)

	invincible = false
	controls_enabled = true


func _physics_process(delta: float) -> void:
	if not controls_enabled:
		return

	var input_dir: Vector3 = Vector3(
		Input.get_axis("digital_left", "digital_right"),
		0.0,
		Input.get_axis("digital_up", "digital_down"),
	).normalized()

	if input_dir.length() > analog_deadzone:
		velocity = velocity.move_toward(input_dir * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, friction * delta)

	position.y = 0.0
	guy.rotation.y = velocity.x * guy_roll

	move_and_slide()


func on_game_win() -> void:
	animation_player.play("winner")

	var sec: float = animation_player.get_animation("winner").length
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", Vector3.ZERO, sec)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)


func on_controls_enabled(value: bool) -> void:
	controls_enabled = value


func on_hit_by_obstacle(_obstacle: MyObstacle) -> void:
	if invincible:
		return

	make_invincible_temporarily()

	var sound: AudioStreamPlayer3D = hurt_sounds.get_children().pick_random()
	if not sound.playing:
		sound.pitch_scale = randf_range(0.9, 1.1)
		sound.play()

	if gpu_particles_3d.emitting:
		gpu_particles_3d.restart()
		await get_tree().process_frame

	gpu_particles_3d.emitting = true


func make_invincible_temporarily() -> void:
	invincible = true
	await get_tree().create_timer(invincible_cooldown).timeout
	invincible = false
