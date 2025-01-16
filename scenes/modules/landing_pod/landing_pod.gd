class_name LandingPod
extends Module


# Resources
const BASIC_RESOURCE_A = preload("res://resources/basic_resources/basic_resource_a.tres")
const BASIC_RESOURCE_B = preload("res://resources/basic_resources/basic_resource_b.tres")
const BASIC_RESOURCE_C = preload("res://resources/basic_resources/basic_resource_c.tres")
# Modules
const MODULE_COLLECTOR_BOT = preload("res://resources/modules/collector_bot.tres")
const MODULE_SPIRAL_CONDENSER = preload("res://resources/modules/spiral_condenser.tres")
const MODULE_MINING_DRILL = preload("res://resources/modules/mining_drill.tres")
const MODULE_BIOLOGY_LAB = preload("res://resources/modules/biology_lab.tres")
# Recipes
const RECIPE_BUILD_COLLECTOR_BOT = preload("res://resources/recipes/build_collector_bot.tres")
const RECIPE_BUILD_SPIRAL_CONDENSER = preload("res://resources/recipes/build_spiral_condenser.tres")
const RECIPE_BUILD_MINING_DRILL = preload("res://resources/recipes/build_mining_drill.tres")
const RECIPE_BUILD_BIOLOGY_LAB = preload("res://resources/recipes/build_biology_lab.tres")


func _ready() -> void:
	super._ready()

	# Listen to new game resources to unlock/lock recipes
	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)


func on_new_game_resource_updated(resource: GameResourceData, new_quantity: int) -> void:
	print("Landing Pod - New game resource discovered! ", resource.id)

	# Unlock recipes
	if resource == BASIC_RESOURCE_A:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_COLLECTOR_BOT, self)
	elif resource == BASIC_RESOURCE_B:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_SPIRAL_CONDENSER, self)
	elif resource == BASIC_RESOURCE_C:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_MINING_DRILL, self)
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_BIOLOGY_LAB, self)

	# Lock recipes again
	elif resource == MODULE_COLLECTOR_BOT:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_COLLECTOR_BOT, self)
	elif resource == MODULE_SPIRAL_CONDENSER:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_SPIRAL_CONDENSER, self)
	elif resource == MODULE_MINING_DRILL:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_MINING_DRILL, self)
	elif resource == MODULE_BIOLOGY_LAB:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_BIOLOGY_LAB, self)
