class_name CardsContainer
extends HBoxContainer


const SCENE_RESOURCE_CARD = preload("res://scenes/ui/cards/resource_card.tscn")
const SCENE_RECIPE_CARD = preload("res://scenes/ui/cards/recipe_card.tscn")
const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


func _ready() -> void:
	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)
	GameEvents.recipe_unlocked.connect(on_recipe_unlocked)


func on_new_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	print("CardsContainer - New game resource discovered! ", resource.id)

	if !resource is BasicResourceData || resource == BASIC_RESOURCE_HEALTH:
		return

	var card = SCENE_RESOURCE_CARD.instantiate() as ResourceCard
	add_child(card)
	card.set_target_resource(resource)


func on_recipe_unlocked(recipe: RecipeData, source: Module) -> void:
	# Only add a recipe panel if recipe is run manually
	if recipe.run_mode != RecipeData.RUN_MODE_MANUAL:
		return

	var card = SCENE_RECIPE_CARD.instantiate() as RecipeCard
	add_child(card)
	card.set_target_recipe(recipe, source)
