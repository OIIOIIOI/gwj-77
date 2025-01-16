class_name ModuleCore
extends Node2D


@onready var timer: Timer = $Timer
@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var jobs: Node = $Jobs


func _ready() -> void:
	progress_bar.value = 0.0


func _process(delta: float) -> void:
	if timer.is_stopped() && progress_bar.visible:
		progress_bar.visible = false
	elif !timer.is_stopped() && !progress_bar.visible:
		progress_bar.visible = true

	progress_bar.value = 1.0 - timer.time_left / timer.wait_time
