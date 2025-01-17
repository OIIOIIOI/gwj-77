extends CanvasLayer


@onready var label: Label = $MarginContainer/VBoxContainer2/Label
@onready var h_slider: HSlider = $MarginContainer/VBoxContainer2/HSlider


func _ready() -> void:
	on_slider_value_changed(h_slider.value)

	h_slider.value_changed.connect(on_slider_value_changed)


func on_slider_value_changed(value: float) -> void:
	label.text = "Time Scale: " + str(h_slider.value)
	Engine.time_scale = h_slider.value
