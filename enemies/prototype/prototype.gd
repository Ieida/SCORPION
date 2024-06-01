class_name Prototype extends Node2D


var target: Node2D
@export var speed: float = 200
@export var targeting_area: Area2D
@export var hitbox: Hitbox
@export var death_particles: GPUParticles2D
@export var sprite: Sprite2D


@onready var intd_intl = preload("res://resources/interdimensional_intelligence/interdimensional_intelligence.tscn")


func _on_hitbox_destroyed():
	drop_interdimensional_intelligence()
	sprite.hide()
	death_particles.emitting = true
	await death_particles.finished
	queue_free()


func _ready():
	add_to_group("targets")
	hitbox.destroyed.connect(_on_hitbox_destroyed)


func _physics_process(delta):
	if hitbox.is_destroyed: return
	
	if target and is_instance_valid(target) and global_position.distance_to(target.global_position) > 16.0:
		global_position = global_position.move_toward(target.global_position, speed * delta)


func _process(_delta):
	if hitbox.is_destroyed: return
	
	if not target:
		var ars = targeting_area.get_overlapping_areas()
		for a in ars:
			if a.is_in_group("human_team"):
				target = a


func drop_interdimensional_intelligence():
	var i = intd_intl.instantiate() as InterdimensionalIntelligence
	get_tree().root.add_child(i)
	i.global_position = global_position
