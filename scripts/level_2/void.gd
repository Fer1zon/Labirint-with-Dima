extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("death"):
		return
	if body.on_bridge:
		return
		
	body.death()
