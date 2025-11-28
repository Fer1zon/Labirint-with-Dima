extends Node


func play_global_sound(load_sound : Resource, audio_bus : String = "SFX"):
	var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
	audio_player.bus = audio_bus
	audio_player.stream = load_sound
	audio_player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(audio_player)
	
	audio_player.connect("finished", queue_free_node.bind(audio_player))
	audio_player.play()
	
func queue_free_node(node:Node):
	node.queue_free()
