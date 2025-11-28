extends Button
@export_file("*.tscn") var path_to_scene_level
@onready var click_sound = preload("res://sounds/UI/click_button.wav")
func _on_pressed() -> void:
	Global.play_global_sound(click_sound, "SFX")
	if not path_to_scene_level:
		return
	get_tree().change_scene_to_file(path_to_scene_level)
	
	
