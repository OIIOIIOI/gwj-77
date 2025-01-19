class_name ResourceTab
extends PanelContainer


const ICON_TAG := "[img=64x64]{icon_path}[/img] "


var target_resource: GameResourceData


@onready var label: RichTextLabel = %RichTextLabel


func _ready() -> void:
	GameEvents.game_resource_updated.connect(on_game_resource_updated)


func set_target_resource(resource: GameResourceData) -> void:
	target_resource = resource
	update_ui()


func on_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if resource == target_resource:
		update_ui()


func update_ui() -> void:
	if target_resource.icon:
		label.text = ICON_TAG.format({
			"icon_path": target_resource.icon.resource_path
		})

	label.text += str(Inventory.get_resource_quantity(target_resource))
