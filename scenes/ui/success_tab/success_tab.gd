class_name SuccessTab
extends PanelContainer


const ICON_TAG := "[img=64x64]{icon_path}[/img] "


var target_resource: GameResourceData


@onready var label: RichTextLabel = %RichTextLabel


#func _ready() -> void:
	#pass


func set_text(success_text: String, small = true) -> void:
	label.text = success_text
	if small:
		label.add_theme_font_size_override("normal_font_size", 24)
	else:
		label.add_theme_font_size_override("normal_font_size", 28)
