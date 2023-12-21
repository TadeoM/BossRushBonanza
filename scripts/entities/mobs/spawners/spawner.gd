extends Node2D
class_name Spawner

var biome : Map_Gen_Algorithms.BiomeTypes = Map_Gen_Algorithms.BiomeTypes.DUNGEON
var room : Map_Gen_Algorithms.Room
var spawn_count : int
var tier : int
var hasSpawned : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(biome_input: Map_Gen_Algorithms.BiomeTypes, spawn_count_input: int, tier_input: int, room_input : Map_Gen_Algorithms.Room):
	biome = biome_input
	spawn_count = spawn_count_input
	tier = tier_input
	room = room_input
	hasSpawned = false
	transform.origin = room.world_pos

func spawn_enemies():
	var scene = load("res://prefabs/enemies/bat.tscn")
	var bat = scene.instantiate()
	get_tree().current_scene.add_child(bat)
	bat.position = transform.get_origin()
	hasSpawned = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!hasSpawned):
		spawn_enemies()
