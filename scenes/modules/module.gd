class_name Module
extends Node2D


const SCENE_MODULE_CORE = preload("res://scenes/modules/module_core.tscn")


var module_data: ModuleData
var core: ModuleCore

var default_production: Array[ModuleProductionData]
var recipes: Array[RecipeData]
var upgrade_level := 0


@onready var core_marker: Marker2D = %CoreMarker


func _ready() -> void:
	# Add core scene
	core = SCENE_MODULE_CORE.instantiate() as ModuleCore
	add_child(core)

	# Position core if marker was found
	if core_marker:
		core.position = core_marker.position

	# If module has a default production, start it
	default_production = module_data.default_production.duplicate(true)
	if default_production.size() > 0:
		core.timer.timeout.connect(on_production_timer_timeout)
		core.timer.start()

	GameEvents.recipe_locked.connect(on_recipe_locked)


func on_production_timer_timeout() -> void:
	var results: Array[ResourceQuantity] = []

	for prod in default_production:
		var rq = ResourceQuantity.new()
		rq.resource = prod.resource
		rq.quantity = get_production_quantity(prod.level_offset)
		results.append(rq)

	Inventory.batch_update_resources(results)


func get_production_quantity(offset: int = 0) -> int:
	return pow(upgrade_level + 1 + offset, 3)


func run_job(job: Job) -> void:
	# Add node to scene tree if not already there
	if !job.is_inside_tree():
		core.jobs.add_child(job)

	# Set source and start job
	job.source = self
	job.start()


func on_recipe_locked(recipe: RecipeData, source: Module) -> void:
	for job in core.jobs.get_children():
		if job is Job:
			if job.recipe == recipe:
				print("Module ", name, " contains a recipe that is now locked: ", recipe.name)
				job.queue_free()
