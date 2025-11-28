extends Node2D
@export var switch_objects : Array[Node]
@export var existe_press_signal: bool = true#Если true, то сигнал будет отправляться при наступании
@export var existe_unpress_signal: bool = false#Если true, то сигнал будет отправляться при уходе с пластины
@export var delay_press : Timer = null#Устанавливает задержку на отправку сигнала перед нажатием
@export var delay_unpress : Timer = null#Устанавливает задержку на отправку сигнала после отжатие
@export var oneshot : bool =  false#Если True, то сработает только один раз
@onready var oneshot_uses : bool = false#Статус единичного срабатывания
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var area2D : Area2D = $Area2D


func _ready() -> void:
	pass
	
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "legs":
		anim_player.play("pressed")
		if not existe_press_signal:
			return
		
		if oneshot:
			if oneshot_uses:
				return
			
			call_take_signal(switch_objects)
			oneshot_uses = true
			return

			
		if delay_press:#Создаем ожидание, если оно есть а после действуем
			delay_press.connect("timeout", call_take_signal.bind(switch_objects, true, "press"))
			delay_press.start()
		
		else:
			call_take_signal(switch_objects)
		
		
				




func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if body.name == "legs":
		anim_player.play_backwards("pressed")
		if not existe_unpress_signal:
			return
		
		if oneshot:
			if oneshot_uses:
				return
			oneshot_uses = true
			call_take_signal(switch_objects)
			return
		area2D.set_deferred("monitoring", false)
		if delay_unpress:#Создаем ожидание, если оно есть а после действуем
			delay_unpress.connect("timeout", call_take_signal.bind(switch_objects, true, "unpress"))
			delay_unpress.start()
		
		else:
			call_take_signal(switch_objects, true)
			
		 
		
				
		
		
		
func call_take_signal(nodes : Array[Node], changing : bool = false, for_ = null):
	#Удаление сигналов
	if for_ == "press" and delay_press.is_connected("timeout", call_take_signal.bind(switch_objects, true, "press")):
		delay_press.disconnect("timeout", call_take_signal.bind(switch_objects, true, "press"))
	elif for_ == "unpress" and delay_unpress.is_connected("timeout", call_take_signal.bind(switch_objects, true, "unpress")):
		delay_unpress.disconnect("timeout", call_take_signal.bind(switch_objects, true, "press"))
		
	for object in switch_objects:
		if object.has_method("take_signal"):
			object.take_signal.call_deferred()
			
	if changing:
		area2D.set_deferred("monitoring", true)
			
	
		
