class_name ResourceCard
extends PanelContainer


var target_resource: GameResourceData


@onready var resource_icon: TextureRect = %ResourceIcon
@onready var quantity_label: Label = %QuantityLabel


func _ready() -> void:
	GameEvents.game_resource_updated.connect(on_game_resource_updated)


func set_target_resource(resource: GameResourceData) -> void:
	target_resource = resource
	update_ui()


func on_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if resource == target_resource:
		update_ui()


func update_ui() -> void:
	if "icon" in target_resource:
		resource_icon.texture = target_resource.icon

	quantity_label.text = str(Inventory.get_resource_quantity(target_resource))
