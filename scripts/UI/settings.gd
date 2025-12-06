extends Control

@onready var sfx_bus_index = AudioServer.get_bus_index("SFX") 
@onready var music_bus_index = AudioServer.get_bus_index("Music") 

@onready var sfx_slider = $Content/MarginContainer/VBoxContainer/SFX/SFXSlider
@onready var music_slider = $Content/MarginContainer/VBoxContainer/Music/MusicSlider
func _ready() -> void:
	sfx_slider.value = AudioServer.get_bus_volume_linear(sfx_bus_index)
	music_slider.value = AudioServer.get_bus_volume_linear(music_bus_index)
	
	if sfx_slider.value <= 0:
			$Content/MarginContainer/VBoxContainer/SFX/ColorRect.color = Color(0.733, 0.02, 0.376)
			
	elif sfx_slider.value > 0:
		$Content/MarginContainer/VBoxContainer/SFX/ColorRect.color = Color(0.0, 0.663, 0.0, 1.0)
		
		
	if music_slider.value <= 0:
			$Content/MarginContainer/VBoxContainer/Music/ColorRect.color = Color(0.733, 0.02, 0.376)
			
	elif music_slider.value > 0:
		$Content/MarginContainer/VBoxContainer/Music/ColorRect.color = Color(0.0, 0.663, 0.0, 1.0)




func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))


	


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var config = ConfigFile.new()
		config.load(Global.save_path)
		config.set_value("sound_settings", "SFX", sfx_slider.value)
		config.save(Global.save_path)
		
		if sfx_slider.value <= 0:
			$Content/MarginContainer/VBoxContainer/SFX/ColorRect.color = Color(0.733, 0.02, 0.376)
			
		elif sfx_slider.value > 0:
			$Content/MarginContainer/VBoxContainer/SFX/ColorRect.color = Color(0.0, 0.663, 0.0, 1.0)
			
			
		
	
	


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))



func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var config = ConfigFile.new()
		config.load(Global.save_path)
		config.set_value("sound_settings", "Music", music_slider.value)
		config.save(Global.save_path)
		
		if music_slider.value <= 0:
			$Content/MarginContainer/VBoxContainer/Music/ColorRect.color = Color(0.733, 0.02, 0.376)
			
		elif music_slider.value > 0:
			$Content/MarginContainer/VBoxContainer/Music/ColorRect.color = Color(0.0, 0.663, 0.0, 1.0)
