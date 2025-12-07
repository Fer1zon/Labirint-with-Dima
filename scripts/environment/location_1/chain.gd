extends Area2D

var player_in_collision : bool = false #Для того что бы цепь не кочалась бесконечно пока в ней игрок





	

	


func _on_body_entered(body: Node2D) -> void:
	if player_in_collision:
		return
		
	if $AnimationPlayer.is_playing():
		return
		
	var rotation_to_swing = global_position - body.global_position
	var swing_rotation = rotation_to_swing.normalized()

	if swing_rotation.x < 0:
		$AnimationPlayer.play("swing_left")
		
	elif swing_rotation.x > 0:
		$AnimationPlayer.play("swing_right")
	
	player_in_collision = true
		
	


func _on_body_exited(body: Node2D) -> void:
	player_in_collision = false
