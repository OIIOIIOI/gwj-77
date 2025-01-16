class_name CollectorBot
extends Module


# Resources & Modules
const BASIC_RESOURCE_B = preload("res://resources/basic_resources/basic_resource_b.tres")
const SPIRAL_CONDENSER = preload("res://resources/modules/spiral_condenser.tres")
# Recipes
const RECIPE_BUILD_SPIRAL_CONDENSER = preload("res://resources/recipes/build_spiral_condenser.tres")
const RECIPE_COLLECTOR_BOT_RB_PRODUCTION = preload("res://resources/recipes/collector_bot_rb_production.tres")


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super._ready()

	animation_player.speed_scale = 1.0 / get_production_time()

	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)


func on_new_game_resource_updated(resource: GameResourceData, new_quantity: int) -> void:
	print("Collector Bot - New game resource discovered! ", resource.id)

	if resource == BASIC_RESOURCE_B:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_SPIRAL_CONDENSER, self)
	elif resource == SPIRAL_CONDENSER:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_SPIRAL_CONDENSER, self)
		GameEvents.recipe_locked.emit(RECIPE_COLLECTOR_BOT_RB_PRODUCTION, self)
