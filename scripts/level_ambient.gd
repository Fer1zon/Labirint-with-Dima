extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.death.connect(off_ambient)
	
	
	
func off_ambient():
	stop()
