extends Timer
@export var switch_object : Array[Node2D]



func take_signal():
	if self.is_stopped():
		self.start()
	
	else:
		self.stop()
		




func _on_timeout() -> void:
	for object in switch_object:
		if object.has_method("take_signal"):
			object.take_signal()
