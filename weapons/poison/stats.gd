extends Node2D

var hp : int = 20
var base_speed : float = 200
var speed := base_speed

func start_freeze_expiry_timer():
  $FreezeExpiration.start()

func _on_freeze_expiration_timeout():
  speed = base_speed
