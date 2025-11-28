extends Node2D

@export var enabled : bool = true #Переменная отвечающая за текущее состояние

@onready var collision_ : CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var throns_include_sound : Resource = preload("res://sounds/items/throns/throns_included.wav")
@onready var throns_out_sound : Resource = preload("res://sounds/items/throns/throns_out.wav")
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
func _ready():
	self_update(enabled, true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "legs" and enabled:
		Global.play_global_sound(load("res://sounds/player/death_in_throns.wav"))
		Events.death.emit()


func take_signal(value = null):
	if value != null:
		enabled = value
	else:
		enabled = !enabled
		
	self_update(enabled)
	
	
	
func self_update(enabled_ : bool, onready : bool = false):
	
	if enabled_:
		
		collision_.set_deferred("disabled", false)
		sprite.frame = 5
		
		if not onready:
			audio_player.stream = throns_include_sound
			audio_player.play()
		
	else:
		collision_.set_deferred("disabled", true)
		sprite.frame = 6
		
		if not onready:
			audio_player.stream = throns_out_sound
			audio_player.play()
		
	
		
	
		
		
