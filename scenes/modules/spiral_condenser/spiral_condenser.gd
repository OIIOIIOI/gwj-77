class_name SpiralCondenser
extends Module

# Resources & Modules
const BASIC_RESOURCE_C = preload("res://resources/basic_resources/basic_resource_c.tres")
const MINING_DRILL = preload("res://resources/modules/mining_drill.tres")
const BIOLOGY_LAB = preload("res://resources/modules/biology_lab.tres")
# Recipes
const RECIPE_BUILD_MINING_DRILL = preload("res://resources/recipes/build_mining_drill.tres")
const RECIPE_BUILD_BIOLOGY_LAB = preload("res://resources/recipes/build_biology_lab.tres")
const RECIPE_SPIRAL_CONDENSER_RC_PRODUCTION = preload("res://resources/recipes/spiral_condenser_rc_production.tres")


func _ready() -> void:
	super._ready()

	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)


func on_new_game_resource_updated(resource: GameResourceData, new_quantity: int) -> void:
	print("Spiral Condenser - New game resource discovered! ", resource.id)

	if resource == BASIC_RESOURCE_C:
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_MINING_DRILL, self)
		GameEvents.recipe_unlocked.emit(RECIPE_BUILD_BIOLOGY_LAB, self)
	elif resource == MINING_DRILL:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_MINING_DRILL, self)
		GameEvents.recipe_locked.emit(RECIPE_SPIRAL_CONDENSER_RC_PRODUCTION, self)
	elif resource == BIOLOGY_LAB:
		GameEvents.recipe_locked.emit(RECIPE_BUILD_BIOLOGY_LAB, self)
