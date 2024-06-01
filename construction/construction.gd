class_name Construction extends Resource


@export var tier: Tier
@export var scene: PackedScene


var name: String:
	get:
		return scene.resource_path.get_file().trim_suffix(".tscn").capitalize()


func instance() -> Node:
	return scene.instantiate()
