extends CharacterBody2D


const SPEED = 150.0
@onready var is_action : bool = false
@onready var is_death : bool = false
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Events.death.connect(death)
	Events.level_complete.connect(level_complete)
	Events.player_is_action_changed.connect(change_action_state)
	
func _physics_process(delta: float) -> void:
	if is_action:
		return
	if is_death:
		return
	var direction = Input.get_vector("walkLeft", "walkRight", "walkTop", "walkBottom")
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if direction.x != 0:
		$AnimatedSprite2D.play("walk_left_right")
		
	elif direction.y != 0:
		if direction.y <= 1 and direction.y > 0:
			$AnimatedSprite2D.play("walk_bottom")
		elif direction.y >= -1 and direction.y < 0:
			$AnimatedSprite2D.play("walk_top")
	
	else:
		$AnimatedSprite2D.play("idle")
	velocity = direction * SPEED
	
	move_and_slide()
	

func death():
	if not is_death:
		
		$AnimatedSprite2D.stop()
		
		var game_over_scene = "res://scenes/UI/defeat_screen.tscn"
		var level_number = get_parent().get_meta("level_number")
		is_death = true
		Global.end_game_data = {
		
		"level_scene" : get_parent().scene_file_path,
		"level_number" : level_number
		
		}
		animation_player.play("screen_fading")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(game_over_scene)

		
		


func level_complete(level_number : int):
	
	is_action = true
	$AnimatedSprite2D.stop()
	
	var level_complete_scene = "res://scenes/UI/win_screen.tscn"
	Global.end_game_data = {
		
		"level_scene" : get_parent().scene_file_path,
		"level_number" : level_number
		
		}
	animation_player.play("screen_fading")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(level_complete_scene)
	#get_parent().add_child.call_deferred(level_complete_scene)
	
	
	
	
func change_action_state(value : bool):
	is_action = value
	
	
	
	
	
