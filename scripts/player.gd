extends CharacterBody2D


const SPEED = 150.0
@onready var is_action : bool = false
@onready var is_death : bool = false

func _ready() -> void:
	Events.death.connect(death)
	Events.level_complete.connect(level_complete)
	Events.player_is_action_changed.connect(change_action_state)
	
func _physics_process(delta: float) -> void:
	if is_action:
		return
	var direction = Input.get_vector("walkLeft", "walkRight", "walkTop", "walkBottom")
	print(direction)
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if direction.x != 0 or direction.y != 0:
		$AnimatedSprite2D.play("walk")
	
	else:
		$AnimatedSprite2D.play("idle")
	velocity = direction * SPEED
	
	move_and_slide()
	

func death():
	if not is_death:
		var game_over_scene = load("res://scenes/UI/defeat_screen.tscn").instantiate()
		add_child.call_deferred(game_over_scene)
		is_death = true
	
func level_complete(level_number : int):
	var level_complete_scene = load("res://scenes/UI/win_screen.tscn").instantiate()
	level_complete_scene.level_number = level_number
	add_child.call_deferred(level_complete_scene)
	
func change_action_state(value : bool):
	is_action = value
	
	
	
	
	
