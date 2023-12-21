extends MapGeneratorBase
var Map_Gen_Helpers := Map_Gen_Algorithms.new()

@export var iterations:= 10
@export var walk_length := 10
@export var start_randomly_each_iteration := true

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
			map[x].append(1)

func generate_map():
	new_empty_map()
	var floor_pos = random_fill_map()
	for i in range(floor_pos.size()):
		map[floor_pos.keys()[i].x][floor_pos.keys()[i].y] = 0
	draw_on_tilemap()

func draw_on_tilemap():
	for x in range(width):
		for y in range(height):
			if map[x][y] == 0:
				set_cell(0, Vector2i(x,y), 0, Vector2i(randi_range(0,6), 0))

func random_fill_map():
	if (!use_random_seed):
		rng.set_seed(seed_id.hash())
	else:
		randomize()
		rng.set_seed(randi())
	
	var current_pos = Vector2i(40,40)
	var floor_positions = {}
	
	for iteration in range(iterations):
		var path = Map_Gen_Helpers.random_walk(current_pos, walk_length)
		for path_index in range(path.size()):
			floor_positions.merge(path)
			if start_randomly_each_iteration:
				var rand_key: Vector2i = floor_positions.keys()[rng.randi_range(0, floor_positions.size()-1)]
				current_pos = rand_key
	return floor_positions


