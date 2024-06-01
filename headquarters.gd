class_name Headquarters extends Building


@export var _stats: Stats
@export var hitbox: Hitbox


func _ready():
	stats = _stats.duplicate()
	hitbox.destroyed.connect(_on_hitbox_destroyed)
	hitbox.health = _stats.health


func _on_hitbox_destroyed():
	deconstructed.emit()
	queue_free()
