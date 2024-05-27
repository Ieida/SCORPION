extends Node2D

@onready var stats = $"../Stats"
var damage

func start():
	stats.speed = stats.base_speed * 0.5
	$Expire.start()

func _on_expire_timeout():
	stats.speed = stats.base_speed
