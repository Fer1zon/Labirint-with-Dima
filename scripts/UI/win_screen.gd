extends Control

var level_number : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	$CanvasLayer/Label.text = "Уровень " + str(Global.end_game_data["level_number"]) + " пройден!"

func camera_disable():
	pass
	#get_parent().get_node("Camera2D").enabled = false
