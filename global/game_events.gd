extends Node

signal new_game_resource_updated(resource: GameResourceData, new_quantity: int)
signal game_resource_updated(resource: GameResourceData, new_quantity: int)

signal job_complete(resources: Array[ResourceQuantity], source: Module)

signal recipe_unlocked(recipe: RecipeData, source: Module)
signal recipe_locked(recipe: RecipeData, source: Module)
