extends Node2D


@export var draw_tilemap : TileMapLayer
@export var main_tilemap : TileMapLayer
#var tilemap : TileMapLayer
@onready var direction_point : Marker2D = $Marker2D
var direction_building : Vector2i

var coords_created_tiles : Array[Vector2i] = []


func _ready() -> void:
	#tilemap = get_parent()
	
	
	direction_building = global_position.direction_to(direction_point.global_position)
	
	var current_position = draw_tilemap.local_to_map(global_position) + direction_building
	for i in range(5):
		
		print(draw_tilemap.get_cell_source_id(current_position))
		print(main_tilemap.get_cell_source_id(current_position))
		if draw_tilemap.get_cell_source_id(current_position) != -1:
			coords_created_tiles.append(null)
			current_position += direction_building
			continue
			
		elif main_tilemap.get_cell_source_id(current_position) != -1:
			break
		
		coords_created_tiles.append(current_position)
		draw_tilemap.set_cell(current_position, 0, Vector2i(0, 0))
		current_position += direction_building
		await get_tree().create_timer(1.5).timeout
		
	#main_tilemap.set_cells_terrain_connect(coords_created_tiles, 0, 0)
	#
	await get_tree().create_timer(1).timeout
	coords_created_tiles.reverse()
	for i in coords_created_tiles:
		if i == null:
			continue
		draw_tilemap.set_cell(i)
		await get_tree().create_timer(1).timeout
	
	
	
	
