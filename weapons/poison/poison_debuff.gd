extends Node2D

@onready var stats = $"../Stats"
var damage

func start(amt: int):
  damage = amt
  do_damage()
  $Expire.start()
  $DoDamage.start()

func _on_expire_timeout():
  $PoisonTick.stop()

func _on_do_damage_timeout():
  do_damage()

func do_damage():
  stats.hp = max(0, stats.hp - damage)
  if stats.hp == 0:
    get_parent().queue_free()
