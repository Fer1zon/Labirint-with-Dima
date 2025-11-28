extends Node2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@export var switch_object : Array[Node]#При добавлении рычага, добавляем ему объекты через инспектор на которые он воздействует 
@onready var light_manage_area : Area2D = $light_manage_area
@onready var switch_area : Area2D = $switch_area
@onready var sprite : Sprite2D = $Sprite2D
@onready var opportunityPickUp : bool = false
@export var toggled_delay : float = 1
@export var enabled : bool = false
@export var enable_all_time : bool = false
@onready var lights_enabled : bool = false
@onready var is_delay : bool = false
func _ready() -> void:
	self_update(enabled, true)
			 


	
func _input(event: InputEvent) -> void:
	if enable_all_time:
		return
	if event.is_action_pressed("interaction"):
		if opportunityPickUp and not is_delay:
			for object in switch_object:
				if object.has_method("take_signal"):
					object.take_signal()
			enabled = !enabled
			self_update(enabled)
			is_delay = true
			await get_tree().create_timer(toggled_delay).timeout
			is_delay = false
			return
						
			
			
			


	
	
	
	
func self_update(enabled_ : bool, onready_call : bool = false):
	if enabled_:
		if not lights_enabled and not onready_call:
			anim_player.play("light_on")
			lights_enabled = true
		sprite.frame = 9
		
	else:
		if lights_enabled and not onready_call:
			anim_player.play("light_off")
			lights_enabled = false
		sprite.frame = 8
	

#Всплывающая подсказка
func _on_switch_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		opportunityPickUp = switch_area.overlaps_body(body)
		anim_player.play("show_label")

func _on_switch_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		opportunityPickUp = switch_area.overlaps_body(body)
		anim_player.play("hide_label")
		
#Включение света


func _on_light_manage_area_body_entered(body: Node2D) -> void:
	if enabled:
		if body.name == "Player":
			if not lights_enabled:
				anim_player.play("light_on")
				lights_enabled = true


func _on_light_manage_area_body_exited(body: Node2D) -> void:
	if enabled:
		if body.name == "Player":
			if lights_enabled:
				anim_player.play("light_off")
				lights_enabled = false
