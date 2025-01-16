class_name CollectorBot
extends Module


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super._ready()

	animation_player.speed_scale = 0.5
