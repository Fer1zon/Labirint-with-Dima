extends CharacterBody2D

@onready var opportunity_movement : bool = true
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var direction : Vector2 = Vector2(-1, 0)
var SPEED : int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if opportunity_movement:
		var collision = move_and_collide(direction * SPEED * delta)
		if collision:
			var collider = collision.get_collider()
			if collider.name == "walls_and_roads":
				opportunity_movement = false
				collision_shape.disabled = true
				anim_player.play("Столкновение")
			if collider.has_method("death"):
				Events.death.emit()
				

func destroy():
	queue_free()
			
			
			
			
