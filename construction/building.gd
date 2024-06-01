class_name Building extends Node2D


@onready var tiers: Array[Tier] = load_tiers()


var current_tier: Tier
var _current_tier_index: int
var stats: Stats


func _ready():
	current_tier = tiers[0].duplicate()
	stats = current_tier.stats.duplicate()


func deconstruct():
	pass


func get_upgrade() -> Tier:
	var i = _current_tier_index + 1
	return tiers[i] if i < tiers.size() else tiers[_current_tier_index]


func has_upgrade() -> bool:
	return _current_tier_index + 1 < tiers.size()


func load_tiers() -> Array[Tier]:
	var a: Array[Tier] = []
	var n = Helper.uncapitalize(name)
	for f in DirAccess.get_files_at("res://weapons/%s/tiers" % n):
		a.append(load("res://weapons/%s/tiers/%s" % [n, f]))
	print(a)
	return a


func upgrade():
	if has_upgrade():
		_current_tier_index += 1
		current_tier = tiers[_current_tier_index].duplicate()
		stats = current_tier.stats.duplicate()
