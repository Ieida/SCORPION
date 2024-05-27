extends RayCast2D


@export var speed: float
@export var damage: int = 10


func _physics_process(delta):
	var d = global_transform.basis_xform(Vector2.RIGHT)
	var m = speed * delta
	force_raycast_update()
	if is_colliding():
		m = global_position.distance_to(get_collision_point())
		var c = get_collider()
		if c.has_method("freeze"):
			c.call("freeze", damage)
		if c.has_method("take_damage"):
			c.call("take_damage", damage)
			queue_free()
			return
	global_translate(d * m)
	target_position.x = m + 0.01
