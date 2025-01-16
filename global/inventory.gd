extends Node


var basic_resources: Dictionary = {}
var organisms: Dictionary = {}
var modules: Dictionary = {}


func get_resource_quantity(dictionary: Dictionary, resource: GameResourceData) -> int:
	if dictionary.has(resource):
		return dictionary[resource]
	else:
		return 0


func update_game_resource(resource: GameResourceData, quantity: int, simulate := false) -> bool:
	# Find resource dictionary
	var resource_dict = null
	if resource is BasicResourceData:
		resource_dict = basic_resources
	elif resource is OrganismData:
		resource_dict = organisms
	elif resource is ModuleData:
		resource_dict = modules
	else:
		print("Resource type not found: ", resource.id)
		return false

	# Check if update is valid (has enough resource when quantity is negative)
	if quantity < 0 && get_resource_quantity(resource_dict, resource) < -quantity:
		print("Not enough resource in Inventory: ", resource.id)
		return false

	# If not simulating
	if !simulate:
		# Apply quantity update
		if resource_dict.has(resource):
			resource_dict[resource] += quantity
		else:
			resource_dict[resource] = quantity
			# If first time updating this resource and quantity != 0, emit event
			if (quantity != 0):
				GameEvents.new_game_resource_updated.emit(resource, resource_dict[resource])

		# If quantity != 0, emit event
		if (quantity != 0):
			GameEvents.game_resource_updated.emit(resource, resource_dict[resource])

	return true


func batch_simulate_and_update_resources(resource_qties: Array[ResourceQuantity]) -> bool:
	# Simulate and update if ok
	if batch_simulate_resources(resource_qties):
		batch_update_resources(resource_qties)
		return true
	else:
		return false


func batch_simulate_resources(resource_qties: Array[ResourceQuantity]) -> bool:
	# Simulate each resource update in the list
	for resource_qty in resource_qties:
		var result = update_game_resource(resource_qty.resource, resource_qty.quantity, true)
		print("Checking for ", resource_qty.quantity, " ", resource_qty.resource.id, ": ", result)
		# If even one simulation fails, stop right there
		if !result:
			return false
	# If all simulations passed
	return true


func batch_update_resources(resource_qties: Array[ResourceQuantity]) -> void:
	# Update each resource update in the list
	for resource_qty in resource_qties:
		update_game_resource(resource_qty.resource, resource_qty.quantity)
