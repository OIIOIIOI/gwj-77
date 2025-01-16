class_name ModuleData
extends GameResourceData


@export var name: String
@export var scene: PackedScene
@export var available_from_start := false
@export var recipes: Array[RecipeData] = []
@export_range(0, 4) var production_speed_level := 1
@export var upgradable_speed := false
@export var upgradable_efficiency := false
@export var upgradable_automation := false
