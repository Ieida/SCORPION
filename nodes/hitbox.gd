class_name Hitbox extends Area2D


signal destroyed


@export var max_health: float


@onready var health: float = max_health


var is_destroyed: bool


func take_damage(damage: float):
	if is_destroyed: return
	health -= damage
	if health <= 0:
		is_destroyed = true
		process_mode = Node.PROCESS_MODE_DISABLED
		destroyed.emit()
