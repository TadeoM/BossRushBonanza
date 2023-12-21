extends TileMap
class_name MapGeneratorBase

@export var generator_settings : MapGenSettings

@export var seed_id : String = "tadeo"
@export var use_random_seed : bool = false
@export_range(1, 20) var room_count : int = 10

var wall = 0
var floor = 1

var rooms : Array[Map_Gen_Algorithms.Room]

var width : int = 80
var height : int = 80

var map = []
var rng := RandomNumberGenerator.new()
