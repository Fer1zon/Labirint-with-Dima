extends Node2D

@export var enabled : bool = false
@onready var opportunity_use : bool = false
@onready var text_anim_player : AnimationPlayer = $TextAnimationPlayer
@onready var portal_anim_player : AnimationPlayer = $PortalAnimationPlayer
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	self_update(enabled, true)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction"):
		if opportunity_use and enabled:
			var level_number = get_parent().get_meta("level_number")
			Events.level_complete.emit(level_number)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		opportunity_use = true
		if enabled:
			text_anim_player.play("show_label")
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		opportunity_use = false
		if enabled:
			text_anim_player.play("hide_label")
		

		
		
		
func take_signal(value = null):
	if value != null:
		enabled = value
	else:
		enabled = !enabled
		
	self_update(enabled)
		
func self_update(enabled_ : bool, onready_call : bool = false):
	if enabled_:
		portal_anim_player.play("portal_enable")
		
	elif not enabled_ and not onready_call:
		portal_anim_player.play("portal_disable")
	elif not enabled:
		audio_player.stop()
		
		
		
func change_emit_particles(): #Функция для изменения активности частиц
	$GPUParticles2D.emitting = !$GPUParticles2D.emitting
