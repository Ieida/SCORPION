class_name InterdimensionalIntelligence extends Area2D


@export var _anim: AnimationPlayer


func _ready():
	_anim.play("drop")
	await _anim.animation_finished
	monitorable = true


func pick_up():
	monitorable = false
	_anim.play("pickup")
	await _anim.animation_finished
	queue_free()
