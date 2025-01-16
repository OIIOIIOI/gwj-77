class_name RecipePanel
extends PanelContainer


const ICON_TAG := "[img={icon_size}x{icon_size}]{icon_path}[/img]"
const ICON_SIZE := 48


var recipe: RecipeData
var source: Module


@onready var recipe_name: Label = $MarginContainer/VBoxContainer/RecipeName
@onready var ingredients_list: RichTextLabel = $MarginContainer/VBoxContainer/IngredientsList
@onready var button: Button = $MarginContainer/VBoxContainer/Button


func _ready() -> void:
	button.pressed.connect(on_button_pressed)


func set_recipe(recipe_data: RecipeData, recipe_source: Module) -> void:
	recipe = recipe_data
	source = recipe_source

	recipe_name.text = recipe.name

	ingredients_list.text = ""
	for ingredient in recipe.ingredients:
		if ingredient.resource.icon:
			ingredients_list.text += ICON_TAG.format({
				"icon_size": ICON_SIZE,
				"icon_path": ingredient.resource.icon.resource_path
			})
		else:
			ingredients_list.text = ingredient.resource.id
		ingredients_list.text += " x" + str(-ingredient.quantity)
		ingredients_list.text += "\n"


func on_button_pressed() -> void:
	if recipe == null || source == null:
		return

	print("Start recipe: ", recipe.name)
	source.run_job(Job.new(recipe, true, true))
