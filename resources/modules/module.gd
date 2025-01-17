class_name ModuleData
extends GameResourceData


@export var name: String
@export var scene: PackedScene
@export var icon: Texture2D
@export var available_from_start := false
@export var upgradable := false
@export var default_production: Array[ModuleProductionData] = []
@export var recipes: Array[RecipeData] = []
