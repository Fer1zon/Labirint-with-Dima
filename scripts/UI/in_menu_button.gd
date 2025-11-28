extends Button





func _on_pressed() -> void:
	var click_sound = load("res://sounds/UI/click_button.wav")
	Global.play_global_sound(click_sound)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/меню.tscn")
	
