class_name RecipeData
extends GameResourceData


const RUN_MODE_AUTO_ONE_SHOT := "run_mode_auto_one_shot"
const RUN_MODE_AUTO_CONTINUOUS := "run_mode_auto_continuous"
const RUN_MODE_MANUAL := "run_mode_manual"


@export var name: String
@export var ingredients: Array[ResourceQuantity]
@export var results: Array[ResourceQuantity]
@export_enum(RUN_MODE_AUTO_ONE_SHOT, RUN_MODE_AUTO_CONTINUOUS, RUN_MODE_MANUAL) var run_mode := RUN_MODE_MANUAL
