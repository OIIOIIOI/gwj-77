extends Node2D


var available_modules: ResourceCollectionData = preload("res://resources/collections/available_modules.tres")
var built_modules: Dictionary = {}

@onready var base_container: Node2D = $Base


func _ready() -> void:
	#Inventory.update_game_resource(Inventory.available_game_resources.collection[0], 0)
	#Inventory.update_game_resource(Inventory.available_game_resources.collection[1], 0)
	#Inventory.update_game_resource(Inventory.available_game_resources.collection[2], 0)

	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)

	# Automatically add to the Inventory all the modules that are available from the start
	for module_data in available_modules.collection:
		if module_data is ModuleData:
			if module_data.available_from_start:
				Inventory.update_game_resource(module_data, 1)


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
