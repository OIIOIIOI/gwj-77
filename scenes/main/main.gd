extends Node2D


const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")
const MODULE_LANDING_POD = preload("res://resources/modules/landing_pod.tres")


var built_modules: Dictionary = {}


@onready var base_container: Node2D = $Base/Modules


func _ready() -> void:
	# Listen to new game resources to add new modules when built
	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)

	# Receive starting resources
	Inventory.update_game_resource(BASIC_RESOURCE_HEALTH, Inventory.MAX_HEALTH)
	Inventory.update_game_resource(MODULE_LANDING_POD, 1)


func on_new_game_resource_updated(resource: GameResourceData, new_quantity: int) -> void:
	print("Main - New game resource discovered! ", resource.id)

	# If new resource is a module that has not been built yet
	if resource is ModuleData && !built_modules.has(resource):
		# Cast resource
		var module_data = resource as ModuleData
		# Instantiate module
		var module_instance = module_data.scene.instantiate() as Module
		module_instance.module_data = module_data
		base_container.add_child(module_instance)
		# Store in dictionary
		built_modules[module_data] = module_instance
