extends VBoxContainer


const SCENE_SUCCESS_TAB = preload("res://scenes/ui/success_tab/success_tab.tscn")
const MODULE_MINING_DRILL = preload("res://resources/modules/mining_drill.tres")
const MODULE_BIOLOGY_LAB = preload("res://resources/modules/biology_lab.tres")
const MODULE_DNA_SPLICER = preload("res://resources/modules/dna_splicer.tres")


var success_list: Dictionary = {}
var has_created_first_organism := false
var created_species: Dictionary = {}


func _ready() -> void:
	add_success_tab("end_goal", "Create new species to populate this dead planet", false)
	add_success_tab("expand_base", "Expand your base to collect more resources", true)

	GameEvents.new_game_resource_updated.connect(on_new_game_resource_updated)
	GameEvents.game_resource_updated.connect(on_game_resource_updated)


func add_success_tab(id: String, success_text: String, small: bool) -> void:
	var tab = SCENE_SUCCESS_TAB.instantiate() as SuccessTab
	add_child(tab)
	tab.set_text(success_text, small)
	success_list[id] = tab


func remove_success_tab(id: String) -> void:
		var tab = success_list.get(id) as SuccessTab
		if tab:
			tab.queue_free()
			success_list.erase(id)


func on_new_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if resource == MODULE_MINING_DRILL:
		remove_success_tab("expand_base")
		add_success_tab("build_lab", "Build your Biology Lab", true)

	elif resource == MODULE_BIOLOGY_LAB:
		remove_success_tab("build_lab")
		add_success_tab("create_organism", "Create your first basic organism", true)

	elif resource is OrganismData && !has_created_first_organism:
		has_created_first_organism = true
		remove_success_tab("create_organism")
		add_success_tab("build_splicer", "Build your DNA Splicer to merge organisms into new species", true)

	elif resource == MODULE_DNA_SPLICER:
		remove_success_tab("build_splicer")
		add_success_tab("create_species", "Create your first new species", true)

	elif resource is SpeciesData && created_species.size() == 0:
		created_species.get_or_add(resource.id, resource)
		remove_success_tab("create_species")
		add_success_tab("collect_species", "Create all possible species", true)


func on_game_resource_updated(resource: GameResourceData, _new_quantity: int) -> void:
	if !resource is SpeciesData:
		return

	created_species.get_or_add(resource.id, resource)
	if created_species.size() == 10:
		remove_success_tab("collect_species")
		remove_success_tab("end_goal")
		add_success_tab("end_reached", "Congratulations! Your work here is done.", false)
		Engine.time_scale = 1.0
