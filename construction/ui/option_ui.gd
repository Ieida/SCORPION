class_name OptionUI extends Control


signal option_chosen(option: String)


@export var title: Label
@export var option_holder: BoxContainer


@onready var option: PackedScene = preload("res://construction/ui/option.tscn")


func display_options(options: Array[OptionInfo]):
	# Clear previous options
	for c in option_holder.get_children():
		c.queue_free()
	
	# Draw new options
	for o in options:
		var b = option.instantiate() as Option
		if b:
			option_holder.add_child(b)
			b.display(o)
		else: b.queue_free()
	show()


func _on_option_pressed(o: String):
	option_chosen.emit(o)


func set_title(text: String):
	title.text = text
