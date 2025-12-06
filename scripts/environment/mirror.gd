extends Sprite2D

@onready var bone_sounds : Array[Resource] = [
	preload("res://sounds/items/environment/mirror_crunch_1.wav"),
	preload("res://sounds/items/environment/mirror_crunch_2.wav"),
	
] 

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
func _ready() -> void:
	pass
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "legs":
		
		audio_player.bus = "SFX"
		audio_player.stream = bone_sounds.pick_random()
		audio_player.play()
		
