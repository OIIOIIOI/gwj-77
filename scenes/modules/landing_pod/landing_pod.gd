class_name LandingPod
extends Module

# Resources & Modules
const BASIC_RESOURCE_A = preload("res://resources/basic_resources/basic_resource_a.tres")
const COLLECTOR_BOT = preload("res://resources/modules/collector_bot.tres")
# Recipes
const RECIPE_BUILD_COLLECTOR_BOT = preload("res://resources/recipes/build_collector_bot.tres")
const RECIPE_LANDING_POD_RA_PRODUCTION = preload("res://resources/recipes/landing_pod_ra_production.tres")

func _ready() -> void:
	super._ready()

	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)


func on_new_game_resource_updated(resource: GameResourceData, new_quantity: int) -> void:
	print("Landing Pod - New game resource discovered! ", resource.id)

	if resource == BASIC_RESOURCE_A:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_COLLECTOR_BOT, self)
	elif resource == COLLECTOR_BOT:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_COLLECTOR_BOT, self)
		GameEvents.recipe_locked.emit(RECIPE_LANDING_POD_RA_PRODUCTION, self)
