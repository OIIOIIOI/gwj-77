class_name Module
extends Node2D


const PRODUCTION_TIMES = [8, 5, 3, 2, 1]


var module_data: ModuleData
var recipes: Array[RecipeData]
var production_speed_level := 0
var job_list: Node


func _ready() -> void:
	recipes = module_data.recipes.duplicate(true)
	production_speed_level = module_data.production_speed_level

	job_list = Node.new()
	job_list.name = "Jobs"
	add_child(job_list)

	for recipe in recipes:
		if recipe.run_mode == RecipeData.RUN_MODE_AUTO_CONTINUOUS:
			run_job(Job.new(recipe, false))
		elif recipe.run_mode == RecipeData.RUN_MODE_AUTO_ONE_SHOT:
			run_job(Job.new(recipe, true))

	GameEvents.recipe_locked.connect(on_recipe_locked)


func get_production_time():
	return PRODUCTION_TIMES[production_speed_level]


func run_job(job: Job) -> void:
	# Add node to scene tree if not already there
	if !job.is_inside_tree():
		job_list.add_child(job)

	# Set source and start job
	job.source = self
	job.start()


func on_recipe_locked(recipe: RecipeData, source: Module) -> void:
	for job in job_list.get_children():
		if job is Job:
			if job.recipe == recipe:
				print("Module ", name, " contains a recipe that is now locked: ", recipe.name)
				job.queue_free()
