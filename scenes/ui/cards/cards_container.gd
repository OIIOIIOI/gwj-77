class_name CardsContainer
extends HBoxContainer


const SCENE_RESOURCE_CARD = preload("res://scenes/ui/cards/resource_card.tscn")
const SCENE_RECIPE_CARD = preload("res://scenes/ui/cards/recipe_card.tscn")
const BASIC_RESOURCE_HEALTH = preload("res://resources/basic_resources/basic_resource_health.tres")


@export var scroll_parent: ScrollContainer


func _ready() -> void:
	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)
	GameEvents.recipe_unlocked.connect(on_recipe_unlocked)


func on_new_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if !resource is BasicResourceData || resource == BASIC_RESOURCE_HEALTH:
		return

	var card = SCENE_RESOURCE_CARD.instantiate() as ResourceCard
	add_child(card)
	card.set_target_resource(resource)

	sort_cards()


func on_recipe_unlocked(recipe: RecipeData, source: Module) -> void:
	# Only add a recipe panel if recipe is run manually
	if recipe.run_mode != RecipeData.RUN_MODE_MANUAL:
		return

	var card = SCENE_RECIPE_CARD.instantiate() as RecipeCard
	add_child(card)
	card.set_target_recipe(recipe, source)

	sort_cards()

	#await get_tree().create_timer(0.1).timeout
	#if scroll_parent:
		#scroll_parent.scroll_horizontal = scroll_parent.get_h_scroll_bar().max_value


func sort_cards() -> void:
	var basic = []
	var organisms = []
	var species = []
	var buildings = []

	for child in get_children():
		if child is ResourceCard:
			basic.append(child)
		elif child is RecipeCard:
			var result = child.get_recipe_result()
			if result is BasicResourceData:
				basic.append(child)
			elif result is OrganismData:
				organisms.append(child)
			elif result is SpeciesData:
				species.append(child)
			elif result is ModuleData:
				buildings.append(child)

	var i = 0
	for child in basic:
		move_child(child, i)
		i += 1
	for child in organisms:
		move_child(child, i)
		i += 1
	for child in species:
		move_child(child, i)
		i += 1
	for child in buildings:
		move_child(child, i)
		i += 1
