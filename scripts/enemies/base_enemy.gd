extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var target : CharacterBody2D = null
var is_wander : bool = false

var directions = {
	"left" : Vector2(-1, 0),
	"right" : Vector2(1, 0),
	"top" : Vector2(0, -1),
	"bottom" : Vector2(0, 1)
}


func _physics_process(delta: float) -> void:
	pass
	
func action():
	if target:
		move_to(target)
	
	else: 
		wander()
	
	
func move_to(point):
	pass
	
func wander():
	if target:
		return
	
	
	
