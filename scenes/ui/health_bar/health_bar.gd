class_name HealthBar
extends Control


const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


@onready var getting_old_timer: Timer = $GettingOldTimer
@onready var health_bar: TextureProgressBar = %HealthProgressBar


func _ready() -> void:
	GameEvents.game_resource_updated.connect(on_game_resource_updated)
	getting_old_timer.timeout.connect(on_getting_old_timer_timeout)


func on_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if resource == BASIC_RESOURCE_HEALTH:
		update_ui()


func on_getting_old_timer_timeout() -> void:
	Inventory.update_game_resource(BASIC_RESOURCE_HEALTH, -1)


func update_ui() -> void:
	if health_bar:
		health_bar.value = float(Inventory.basic_resources[BASIC_RESOURCE_HEALTH]) / float(Inventory.MAX_HEALTH)
