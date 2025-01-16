extends Node2D


@export var product: GameResourceData
@export var product_b: GameResourceData


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	animation_player.current_animation = &"produce"
	animation_player.seek(0.0)
	start_production()


func _process(delta: float) -> void:
	var timer_progress = 1 - timer.time_left / timer.wait_time
	animation_player.seek(timer_progress, true)


func start_production() -> void:
	timer.start()


func on_timer_timeout() -> void:
	Inventory.store_game_resource(product, 3)
	Inventory.store_game_resource(product_b, 1)
	start_production()
