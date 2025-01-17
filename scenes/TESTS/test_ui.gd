extends CanvasLayer


@onready var h_slider: HSlider = $MarginContainer/HSlider


func _ready() -> void:
	on_slider_value_changed(h_slider.value)

	h_slider.value_changed.connect(on_slider_value_changed)


func on_slider_value_changed(value: float) -> void:
	Engine.time_scale = h_slider.value
