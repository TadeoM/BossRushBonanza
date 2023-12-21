extends Node2D

@export var generation_type: Map_Gen_Algorithms.GenerationTypes

# Called when the node enters the scene tree for the first time.
func _ready():
	add_tile_map()

func add_tile_map():
	var type = str(Map_Gen_Algorithms.GenerationTypes.keys()[generation_type]).to_lower()
	var generation_script = load("res://scripts/proc_gen/" + type + "_generator.gd")
	var tile_map = TileMap.new()
	tile_map.tile_set = load("res://sprites/environment/tile_map.tres")
	tile_map.set_script(generation_script)
	tile_map.show_behind_parent = true
	add_child(tile_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
