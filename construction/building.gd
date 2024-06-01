class_name Building extends Node2D


signal deconstructed


static var tiers: Dictionary


var current_tier: Tier
var _current_tier_index: int
var stats: Stats


static func load_tiers():
	for dir in DirAccess.get_directories_at("res://weapons"):
		tiers[dir] = []
		if not DirAccess.dir_exists_absolute("res://weapons/%s/tiers" % dir): continue
		for f in DirAccess.get_files_at("res://weapons/%s/tiers" % dir):
			tiers[dir].append(load("res://weapons/%s/tiers/%s" % [dir, f]))


func _ready():
	if tiers.has(get_groups()[0]):
		current_tier = tiers[get_groups()[0]][0]
		stats = current_tier.stats.duplicate()


func deconstruct():
	deconstructed.emit()


func get_upgrade() -> Tier:
	var n = get_groups()[0]
	if not tiers.has(n): return current_tier
	var i = _current_tier_index + 1
	return tiers[n][i] if i < tiers.size() else tiers[n][_current_tier_index]


func has_upgrade() -> bool:
	var n = get_groups()[0]
	if not tiers.has(n): return false
	return _current_tier_index + 1 < tiers[n].size()


func upgrade():
	if has_upgrade():
		_current_tier_index += 1
		var n = get_groups()[0]
		current_tier = tiers[n][_current_tier_index].duplicate()
		stats = current_tier.stats.duplicate()
