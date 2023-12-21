extends MapGeneratorBase

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
	random_fill_map()
	draw_on_tilemap()

func draw_on_tilemap():
	for x in range(width):
		for y in range(height):
			if map[x][y] == 1:
				set_cell(0, Vector2i(x,y), 1, Vector2i(randi_range(0,6), 0))

func random_fill_map():
	if (!use_random_seed):
		rng.set_seed(seed_id.hash())
	else:
		randomize()
		rng.set_seed(randi())
	
	var current_room_count := 0
	# try 4 placements of a specific set of patterns
	# after four tries, do a set of patterns that are different size
	var failed_placements := 0
	
	while current_room_count < room_count:
		var successful_place = false
		
		var pattern = tile_set.get_pattern(rng.randi_range(0, tile_set.get_patterns_count() - 1))
		var pattern_size = pattern.get_size()
		var pattern_size_x = pattern_size.x
		var pattern_size_y = pattern_size.y
		
		while !successful_place: 
			var pos = Vector2i(rng.randi_range(1, width - pattern_size_x - 1), rng.randi_range(1, height - pattern_size_y - 1))
			
			var success = check_if_room_can_fit(pos, pattern)
			if success:
				create_room(pos, pattern)
				current_room_count += 1
				successful_place = true
			elif failed_placements < 100:
				failed_placements += 1
			else:
				return


func check_if_room_can_fit(pos: Vector2i, pattern: TileMapPattern):
	var pattern_dimensions : Vector2i = pattern.get_size()
	var cells_used : Array[Vector2i] = pattern.get_used_cells()
	var offset_per_tile_checked = cells_used.size()
	
	for x in range(-1, pattern_dimensions.x + 1):
		if (x == -1 || x == pattern_dimensions.x + 1):
			for y in range(-1, pattern_dimensions.y + 1):
				if(map[pos.x+x][pos.y+y] == 0):
					return false
					
		if( pos.y+pattern_dimensions.y + 1 < map[x].size() ):
			if(map[pos.x+x][pos.y-1] == 0) || (map[pos.x+x][pos.y+pattern_dimensions.y + 1] == 0):
				return false
	
	for i in range(cells_used.size() / offset_per_tile_checked):
		var cell_used : Vector2i = cells_used[i]
		if(map[pos.x + cell_used.x][pos.y + cell_used.y] == 0):
			return false
	return true

func create_room(pos: Vector2i, pattern: TileMapPattern):
	var pattern_dimensions : Vector2i = pattern.get_size()
	var cells_used : Array[Vector2i] = pattern.get_used_cells()
	var offset_per_tile_checked = cells_used.size() / 2
	for i in range(cells_used.size()):
		var cell_used : Vector2i = cells_used[i]
		map[pos.x + cell_used.x][pos.y + cell_used.y] = 0
