class_name RecipeIngredientContainer
extends PanelContainer


const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


@onready var resource_icon: TextureRect = %ResourceIcon
@onready var quantity_label: Label = %QuantityLabel


func set_ingredient(ingredient: ResourceQuantity) -> void:
	if "icon" in ingredient.resource:
		resource_icon.texture = ingredient.resource.icon

	if ingredient.resource == BASIC_RESOURCE_HEALTH:
		quantity_label.text = "??"
	else:
		quantity_label.text = str(absi(ingredient.quantity))
