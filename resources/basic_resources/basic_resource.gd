class_name BasicResourceData
extends GameResourceData


enum BasicResourceType {
	BASIC_RESOURCE_A,
	BASIC_RESOURCE_B,
	BASIC_RESOURCE_C,
	BASIC_RESOURCE_DNA,
}


@export var type: BasicResourceType
@export var icon: Texture2D
