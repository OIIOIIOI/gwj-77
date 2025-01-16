class_name Job
extends Node


var recipe: RecipeData
var one_shot := true
var instant := false
var source: Module


func _init(job_recipe: RecipeData, is_one_shot := true, is_instant := false) ->void:
	recipe = job_recipe
	one_shot = is_one_shot
	instant = is_instant
	name = "Job " + recipe.name


func start() -> void:
	if instant:
		complete_job()
	else:
		get_tree().create_timer(source.get_production_time()).timeout.connect(on_timer_timeout)


func on_timer_timeout() ->void:
	complete_job()


func complete_job() -> void:
	# Check if Inventory has enough resources and consume them if so
	var had_all_ingredients := Inventory.batch_simulate_and_update_resources(recipe.ingredients)
	if had_all_ingredients:
		# Store results in inventory
		Inventory.batch_update_resources(recipe.results)
		# Emit event
		GameEvents.job_complete.emit(recipe.results, source)
	else:
		print("Missing ingredients, no result")

	if !one_shot:
		start()
	else:
		queue_free()
