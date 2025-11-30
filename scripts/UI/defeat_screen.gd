extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	#$background_animation_player.play("screen_fading")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func camera_disable():
	get_parent().get_node("Camera2D").enabled = false
