extends Node2D

var open_window_link : CanvasLayer
@onready var opportunity_use : bool = false
@export_multiline var internal_text : String = "Привет друг"
@onready var text_anim_player : AnimationPlayer = $TextAnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		opportunity_use = true
		text_anim_player.play("show_label")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		opportunity_use = false
		text_anim_player.play("hide_label")
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction"):
		if open_window_link == null and opportunity_use:
			Events.player_is_action_changed.emit(true)
			var open_table_scene = load("res://scenes/UI/open_tablet.tscn").instantiate()
			open_table_scene.get_node("Control/tablet/MarginContainer/ScrollContainer/Label").text = internal_text
			open_window_link = open_table_scene
			add_child(open_table_scene)
			
		elif open_window_link != null:
			
			var anim_player = open_window_link.get_node("AnimationPlayer")
			anim_player.connect("animation_finished", close_tablet)
			anim_player.play_backwards("show_on_scene")
			
			
			
			
			
			
func close_tablet(_anim_name : StringName):
	Events.player_is_action_changed.emit(false)
	open_window_link.queue_free()
	open_window_link = null
	
	
	

	
		
