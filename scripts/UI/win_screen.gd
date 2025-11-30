extends CanvasLayer

var level_number : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	$Label.text = "Уровень " + str(level_number) + " пройден!"

func camera_disable():
	get_parent().get_node("Camera2D").enabled = false
