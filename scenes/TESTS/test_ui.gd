extends CanvasLayer


const SCENE_RECIPE_PANEL = preload("res://scenes/TESTS/recipe_panel.tscn")
const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


const ICON_TAG := "[img={icon_size}x{icon_size}]{icon_path}[/img]"
const ICON_SIZE := 80


@onready var rich_text_label: RichTextLabel = $MarginContainer/VBoxContainer/RichTextLabel
@onready var recipe_list: VBoxContainer = $MarginContainer/RecipeList
@onready var label: Label = $MarginContainer/VBoxContainer2/Label
@onready var h_slider: HSlider = $MarginContainer/VBoxContainer2/HSlider
@onready var health_bar: TextureProgressBar = $MarginContainer/HBoxContainer/TextureProgressBar


func _ready() -> void:
	update_resources_ui()
	on_slider_value_changed(h_slider.value)

	h_slider.value_changed.connect(on_slider_value_changed)

	GameEvents.game_resource_updated.connect(on_game_resource_updated)
	GameEvents.recipe_unlocked.connect(on_recipe_unlocked)
	GameEvents.recipe_locked.connect(on_recipe_locked)


func on_game_resource_updated(_resource: GameResourceData, _new_quantity: int) -> void:
	update_resources_ui()


func update_resources_ui() -> void:
	rich_text_label.text = ""

	for resource in Inventory.basic_resources.keys():
		if resource == BASIC_RESOURCE_HEALTH:
			health_bar.value = float(Inventory.basic_resources[resource]) / float(Inventory.MAX_HEALTH)
		else:
			if resource.icon:
				rich_text_label.text += ICON_TAG.format({
					"icon_size": ICON_SIZE,
					"icon_path": resource.icon.resource_path
				})
			else:
				rich_text_label.text += resource.id
			rich_text_label.text += " x" + str(Inventory.basic_resources[resource])
			rich_text_label.text += "\n"

	for resource in Inventory.organisms.keys():
		rich_text_label.text += ICON_TAG.format({
			"icon_size": ICON_SIZE,
			"icon_path": resource.icon.resource_path
		})
		rich_text_label.text += " x" + str(Inventory.organisms[resource])
		rich_text_label.text += "\n"


func on_recipe_unlocked(recipe: RecipeData, source: Module) -> void:
	# Only add a recipe panel if recipe is run manually
	if recipe.run_mode != RecipeData.RUN_MODE_MANUAL:
		return

	var panel = SCENE_RECIPE_PANEL.instantiate() as RecipePanel
	recipe_list.add_child(panel)
	panel.set_recipe(recipe, source)


func on_recipe_locked(recipe: RecipeData, source: Module) -> void:
	for child in recipe_list.get_children():
		if child is RecipePanel:
			if child.recipe == recipe:
				child.queue_free()
				break


func on_slider_value_changed(value: float) -> void:
	label.text = "Time Scale: " + str(h_slider.value)
	Engine.time_scale = h_slider.value
