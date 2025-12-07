extends Sprite2D


@export var draw_tilemap : TileMapLayer
@export var main_tilemap : TileMapLayer
@export var build_duration : float = 1
@onready var direction_point : Marker2D = $Marker2D

var direction_building : Vector2i

var coords_created_tiles : Array[Vector2i] = []
func _ready() -> void:
	direction_building = global_position.direction_to(direction_point.global_position)
	
	
	var current_position = draw_tilemap.local_to_map(global_position) + direction_building
	print(direction_building)
	print(current_position)
	print(draw_tilemap.local_to_map(global_position))
	
	for i in range(5):
		#print(current_position)
		
		
		
			
		if main_tilemap.get_cell_source_id(current_position) != -1:#Если в тайлмапе дорог и стен клетка на которой ставиться мост - не пустая
			print(1)
			var data = main_tilemap.get_cell_tile_data(current_position)#Получаем данные этой клентки
			if data: #Данные будут только у клеток атласа, у коллекций сцен данных нет. То есть если мы уперлись в дорогу или стену строительство завершается, если в пустоту то продолжаем
				print(2)
				
				break
			
			#print(data.get_collision_polygons_count(0))
		if draw_tilemap.get_cell_source_id(current_position) != -1:
			coords_created_tiles.append(null)
			current_position += direction_building
			continue
			
		
		
		coords_created_tiles.append(current_position)
		draw_tilemap.set_cell(current_position, 0, Vector2i(0, 0))
		current_position += direction_building
		await get_tree().create_timer(build_duration).timeout
		
	
	await get_tree().create_timer(10).timeout
	coords_created_tiles.reverse()
	for i in coords_created_tiles:
		if i == null:
			continue
		draw_tilemap.set_cell(i)
		await get_tree().create_timer(1).timeout
	
	
	
	
