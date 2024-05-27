extends Area2D

var targets_that_will_be_hit : Array

func _on_area_entered(area):
  targets_that_will_be_hit.append(area)


func _on_area_exited(area):
  targets_that_will_be_hit.erase(area)
