extends Node2D
@export var direction_str : String#left, right, top, down
@export var dart_speed : float = 280
var dart : Resource = preload("res://scenes/dart_thrower/dart.tscn")


func _ready() -> void:
	pass


func take_signal():
	shot()
	
func shot():
	var new_dart = dart.instantiate()
	new_dart.SPEED = dart_speed
	new_dart.global_position = global_position
	
	
	new_dart.direction = new_dart.global_position.direction_to($direction_point.global_position)	
	new_dart.look_at($direction_point.global_position)
	new_dart.global_position = $direction_point.global_position
	add_child(new_dart)
		
