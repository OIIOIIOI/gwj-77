class_name RecipeCard
extends PanelContainer


const SCENE_RECIPE_INGREDIENT_CONTAINER = preload("res://scenes/ui/cards/recipe_ingredient_container.tscn")


@export var target_recipe: RecipeData
var target_source: Module


@onready var resource_icon: TextureRect = %ResourceIcon
@onready var quantity_label: Label = %QuantityLabel
@onready var ingredients_list: HBoxContainer = %IngredientsList
@onready var craft_button: Button = %CraftButton


func _ready() -> void:
	GameEvents.game_resource_updated.connect(on_game_resource_updated)
	GameEvents.recipe_locked.connect(on_recipe_locked)

	craft_button.disabled = true
	craft_button.pressed.connect(on_craft_button_pressed)

	quantity_label.text = ""

	if target_recipe:
		create_ingredients_slots()
		update_ui()
		check_ingredients()


func set_target_recipe(recipe: RecipeData, source: Module) -> void:
	target_recipe = recipe
	target_source = source

	create_ingredients_slots()
	update_ui()
	check_ingredients()


func create_ingredients_slots() -> void:
	if !target_recipe:
		return

	for slot in ingredients_list.get_children():
		slot.queue_free()

	for ingredient in target_recipe.ingredients:
		var slot = SCENE_RECIPE_INGREDIENT_CONTAINER.instantiate() as RecipeIngredientContainer
		ingredients_list.add_child(slot)
		slot.set_ingredient(ingredient)


func get_recipe_result() -> GameResourceData:
	if target_recipe && target_recipe.results.size() > 0:
		return target_recipe.results[0].resource
	return null


func on_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if resource == target_recipe.results[0].resource:
		update_ui()
	else:
		check_ingredients()


func update_ui() -> void:
	var resource = get_recipe_result()
	if resource == null:
		return

	if "icon" in resource:
		resource_icon.texture = resource.icon

	if !resource is ModuleData:
		quantity_label.text = str(Inventory.get_resource_quantity(resource))

	check_ingredients()


func check_ingredients() -> void:
	var has_all_ingredients := target_recipe && Inventory.batch_simulate_resources(target_recipe.ingredients)
	craft_button.disabled = !has_all_ingredients



func on_recipe_locked(recipe: RecipeData, _source: Module) -> void:
	if recipe == target_recipe:
		queue_free()


func on_craft_button_pressed() -> void:
	print("CLICKED " + str(craft_button.disabled))

	if target_recipe == null || target_source == null:
		return

	print("Start recipe: ", target_recipe.name)
	target_source.run_job(Job.new(target_recipe, true, true))
