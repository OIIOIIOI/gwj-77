extends Button


@export var time_scale := 1.0


func _ready() -> void:
	text = "x" + str(time_scale)
	pressed.connect(on_pressed)


func on_pressed() -> void:
	Engine.time_scale = time_scale
	for button in get_tree().get_nodes_in_group(&"time_scale_buttons"):
		(button as Button).disabled = false
	disabled = true
