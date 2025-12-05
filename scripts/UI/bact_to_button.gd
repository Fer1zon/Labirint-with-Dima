extends Button
@export var back_to : String



func _on_pressed() -> void:
	get_tree().change_scene_to_file(back_to)
