class_name Option extends Control


signal chosen


@export var title: Label
@export var description: Label
@export var button: Button


func _ready():
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed():
	chosen.emit()


func display(info: OptionInfo):
	title.text = info.title
	if not info.title: title.hide()
	description.text = str(info.description)
	if not info.description: description.hide()
	button.text = info.button_name
	button.pressed.connect(info.callback, CONNECT_ONE_SHOT)
