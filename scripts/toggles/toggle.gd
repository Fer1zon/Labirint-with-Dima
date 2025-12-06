extends Node2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@export var switch_object : Array[Node]#При добавлении рычага на сцену, добавляем ему объекты через инспектор на которые он воздействует 
@onready var area2D : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var opportunityPickUp : bool = false
@onready var is_delay : bool = false
@export var toggled_delay : float = 1
@export var enabled : bool = false#Собственный статус
@export var use_self_enabled_value = false #Если True, то все связаные объекты будут получать статус рычага. Если false то каждый будет менять в зависимости от своего
@export var switch_object_on_toggle_status_onready = false #Используеться в свзяке с use_self_enabled_value, если true то при инициализации он будет переключать все привязанные объекты на свой статус
@onready var switch_toggle_sounds : Array = [
	preload("res://sounds/items/toggle/toggle_switch1.wav"),
	preload("res://sounds/items/toggle/toggle_switch2.wav")
											]
											
@export var oneshot : bool =  false#Если True, то сработает только один раз
@onready var oneshot_uses : bool = false#Статус единичного срабатывания


func _ready() -> void:
	if use_self_enabled_value and switch_object_on_toggle_status_onready:
		for object in switch_object:
			if object.has_method("take_signal"):
				object.take_signal.call_deferred(enabled)
			 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction"):
		if opportunityPickUp and not is_delay:#проверяем возможность переключения
			enabled = !enabled
			if oneshot:
				if oneshot_uses:
					return
				else:
					anim_player.play("hide")
			if enabled:#Включаем звук переключения
				play_sound(switch_toggle_sounds[1])
			else:
				play_sound(switch_toggle_sounds[1])
			if use_self_enabled_value:
				for object in switch_object:
					if object.has_method("take_signal"):
						object.take_signal(enabled)
			else:
				for object in switch_object:
					if object == null:
						continue
					if object.has_method("take_signal"):
						object.take_signal()
		
			oneshot_uses = true
			self_update(enabled)
			is_delay = true
			await get_tree().create_timer(toggled_delay).timeout
			is_delay = false
						
		
			
			
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if oneshot_uses and oneshot:
		return
	if body.name == "Player":
		opportunityPickUp = area2D.overlaps_body(body)
		anim_player.play("show")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if oneshot_uses and oneshot:
		return
	if body.name == "Player":
		opportunityPickUp = area2D.overlaps_body(body)
		anim_player.play("hide")
	
	
func self_update(enabled_ : bool):
	if enabled_:
		sprite.frame = 10
		
	else:
		sprite.frame = 7
		
		
func play_sound(load_sound : Resource, audio_bus : String = "SFX"):
	var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
	audio_player.bus = audio_bus
	audio_player.stream = load_sound
	add_child(audio_player)
	
	audio_player.connect("finished", queue_free_node.bind(audio_player))
	audio_player.play()
	
func queue_free_node(node:Node):
	node.queue_free()
	
