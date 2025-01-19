extends VBoxContainer


const SCENE_RESOURCE_TAB = preload("res://scenes/ui/resource_tab/resource_tab.tscn")
const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


func _ready() -> void:
	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)


func on_new_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if !resource is BasicResourceData || resource == BASIC_RESOURCE_HEALTH:
		return

	var tab = SCENE_RESOURCE_TAB.instantiate() as ResourceTab
	add_child(tab)
	tab.set_target_resource(resource)
