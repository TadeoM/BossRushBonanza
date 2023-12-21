extends TileMap

@export var width : int = 80
@export var height : int = 80
@export var seed_id : String
@export var use_random_seed : bool
@export_range(40,60) var random_fill_percent : int
@export_range(0, 5) var number_of_smooths : int

var map = []
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_map()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

func new_empty_map():
	for x in range(width):
		map.append([])
		for y in range(height):
			map[x].append(0)

func generate_map():
	new_empty_map()
	random_fill_map()
	for i in range(number_of_smooths):
		smooth_map()
	draw_on_tilemap()

func draw_on_tilemap():
	for x in range(width):
		for y in range(height):
			if map[x][y] == 1:
				set_cell(0, Vector2i(x,y), 0, Vector2i(15, 0))

func random_fill_map():
	if (use_random_seed):
		rng.set_seed(seed_id.hash())
	else:
		randomize()
		rng.set_seed(randi())
	
	for x in range(width):
		for y in range(height):
			if (x == 0 || x == width-1 || y == 0 || y == height-1):
				map[x][y] = 1
			else:
				var randomint = randi_range(0,100)
				map[x][y] = 1 if randomint < random_fill_percent else 0

func smooth_map():
	for x in range(width):
		for y in range(height):
			var neighbour_wall_tiles = get_surround_wall_count(x, y)
			if(neighbour_wall_tiles > 4):
				map[x][y] = 1
			elif(neighbour_wall_tiles < 4):
				map[x][y] = 0

func get_surround_wall_count(gridX : int, gridY : int):
	var wall_count := 0
	var neighbour_grid_size = 1
	for neighbour_x in range(gridX - neighbour_grid_size, gridX + neighbour_grid_size + 1):
		for neighbour_y in range(gridY - neighbour_grid_size, gridY + neighbour_grid_size + 1):
			if(neighbour_x >= 0 && neighbour_x < width && neighbour_y >= 0 && neighbour_y < height):
				if (neighbour_x != gridX || neighbour_y != gridY):
					wall_count += map[neighbour_x][neighbour_y]
			else:
				wall_count += 1
	return wall_count

