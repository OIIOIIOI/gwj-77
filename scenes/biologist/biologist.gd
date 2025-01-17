class_name Biologist
extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var spots: Node2D = $Spots


func _ready() -> void:
	move_to_new_spot()


func move_to_new_spot() -> void:
	var i = randi_range(0, spots.get_child_count() - 1)
	var spot = spots.get_child(i) as Marker2D
	sprite_2d.position = spot.position
	sprite_2d.scale = spot.scale
	sprite_2d.z_index = spot.z_index

	sprite_2d.frame = randi_range(0, sprite_2d.hframes * sprite_2d.vframes - 1)
	sprite_2d.flip_h = randf() > 0.5

	var delay = randf_range(2.0, 10.0)
	get_tree().create_timer(delay).timeout.connect(move_to_new_spot)
