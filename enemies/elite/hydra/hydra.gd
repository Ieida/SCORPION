class_name Hydra extends Node2D


@export var _anim: AnimationPlayer
@export var sprite: Sprite2D
@export var hitbox: Hitbox
@export var targeting_area: TargetingArea
@export var death_particles: GPUParticles2D
@export var stats: Stats


@onready var intd_intl = preload("res://resources/interdimensional_intelligence/interdimensional_intelligence.tscn")


var target: Hitbox


func _ready():
	hitbox.destroyed.connect(_on_hitbox_destroyed)
	stats = stats.duplicate()
	hitbox.health = stats.health
	
	targeting_area.monitoring = false
	await _anim.animation_finished
	targeting_area.monitoring = true
	_anim.play("move")


func _physics_process(delta):
	if not target:
		look_for_target()
	elif not is_instance_valid(target):
		target = null
		look_for_target()
	elif is_target_in_attack_range():
		attack()
	else:
		move_to_target(stats.speed * delta)


func _on_hitbox_destroyed():
	drop_interdimensional_intelligence()
	sprite.hide()
	death_particles.emitting = true
	await death_particles.finished
	queue_free()


func attack():
	set_physics_process(false)
	# Charge
	await get_tree().create_timer(60.0 / stats.rate_of_fire / 2.0).timeout
	# Swing
	await get_tree().create_timer(60.0 / stats.rate_of_fire / 2.0).timeout
	if target and is_instance_valid(target):
		target.take_damage(stats.damage)
	set_physics_process(true)


func drop_interdimensional_intelligence():
	var i = intd_intl.instantiate() as InterdimensionalIntelligence
	get_tree().root.add_child(i)
	i.global_position = global_position


func is_target_in_attack_range() -> bool:
	return global_position.distance_to(target.global_position) <= stats.attack_range


func look_for_target():
	if not targeting_area.monitoring: return
	var areas = targeting_area.get_overlapping_areas()
	for area in areas:
		if area.is_in_group("human_team"):
			target = area


func move_to_target(speed: float):
	var dir = global_position.direction_to(target.global_position)
	global_translate(dir * speed)
	
	# Flip sprite
	sprite.flip_h = Vector2.RIGHT.dot(dir) > 0.0
