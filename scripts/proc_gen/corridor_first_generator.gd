extends MapGeneratorBase

@export_range(3,10) var corridor_length_min : int = 5
@export_range(3,10) var corridor_length_max : int = 10

@export_range(3,10) var corridor_count_min : int = 5
@export_range(3,10) var corridor_count_max : int = 100

@export_range(1, 5) var corridor_width_min : int = 1
@export_range(2, 5) var corridor_width_max : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	generator_settings = load("res://prefabs/map_gen/corridor_first_settings.tres")
	width = generator_settings.width
	height = generator_settings.height
	tile_set = generator_settings.tile_set
	generate_map()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

#create empty map
func new_empty_map():
	for x in range(width):
		map.append([])
		for y in range(height):
			map[x].append(wall)

func generate_map():
	new_empty_map()
	random_fill_map()
	draw_on_tilemap()

func draw_on_tilemap():
	for x in range(width):
		for y in range(height):
			if map[x][y] == wall:
				set_cell(0, Vector2i(x,y), 1, Vector2i(4, 4))
				#pass
			if map[x][y] == floor:
				set_cell(0, Vector2i(x,y), 0, Vector2i(randi_range(0,6), 0))
			if map[x][y] == 2:
				set_cell(0, Vector2i(x,y), 0, Vector2i(randi_range(0,6), 2))

func random_fill_map():
	if (!use_random_seed):
		seed(seed_id.hash())
	else:
		var seed = randi()
		seed(seed)
	
	# start making corridors at start_pos
	var start_pos = Vector2i.ZERO
	var current_pos = start_pos
	var floor_positions = {}
	var attempts = 0
	while (attempts < 1 && rooms.size() < room_count):
		var room_locations : Array[Vector2i] = create_all_corridors(floor_positions, attempts)
		# current_pos is at the end of the previous corridor (current current_pos is start_pos)
		# generate a corridor at current_pos
		# create a room at the end of X Corridors
		# new start_pos should now be at one of the exits
		populate_rooms(room_locations)

# generates the corridor layout that we want for the dungeon
func create_all_corridors(floor_positions := {}, attempts := 0):
	var current_pos := Vector2i(40,40)
	var start_pos = current_pos
	var room_locations : Array[Vector2i] = []
	var corridors_before_room = randi_range(2, 4)
	var corridor_counter = 0
	
	for i in range(corridor_count_max):
		var corridor : Array[Vector2i] = Map_Gen_Algorithms.random_walk_corridor(current_pos, corridor_length_max)
		current_pos = corridor[corridor.size() - 1]
		
		
		# designate a location to have a room escavated after corridor generation
		# only designate new locations
		if(!room_locations.has(current_pos)):
			corridor_counter += 1
			if(corridor_counter >= corridors_before_room):
				room_locations.append(current_pos)
				corridors_before_room = randi_range(1, 3)
				corridor_counter = 0
				map[current_pos.x][current_pos.y] = 2
		
		for j in range(corridor.size()):
			if(map[corridor[j].x][corridor[j].y] != 2):
				map[corridor[j].x][corridor[j].y] = floor
	
	map[start_pos.x][start_pos.y] = 2
	return room_locations

# make rooms, delete any rooms that can't fit in out tilemap
func populate_rooms(locations : Array[Vector2i]):
	for i in range(locations.size()):
		var successful_room = create_room(locations[i])
		if(!successful_room):
			locations.remove_at(i)
			
	print("done")

# add the room to the map
func create_room(center_pos: Vector2i):
	var pattern_index = randi_range(0, tile_set.get_patterns_count()-1)
	var random_pattern = tile_set.get_pattern(pattern_index)
	var pattern_width = random_pattern.get_size().x
	var pattern_height = random_pattern.get_size().y
	var top_left : Vector2i = Vector2i(center_pos.x - (pattern_width / 2), center_pos.y - (pattern_height / 2))
	
	var room : Map_Gen_Algorithms.Room = Map_Gen_Algorithms.Room.new()
	
	if(center_pos.x + pattern_width < width && center_pos.y + pattern_height < height):
		
		for x in range(top_left.x, top_left.x + pattern_width):
			for y in range(top_left.y, top_left.y + pattern_height):
				if(map[x][y] != 2):
					map[x][y] = floor
				else:
					var temp = Vector2i(x,y)
					print("here")
	else:
		return false
	
	room.pos = center_pos
	room.world_pos = (center_pos * tile_set.tile_size) + (tile_set.tile_size / 2)
	room.width = pattern_width
	room.height = pattern_height
	
	room = room_exits(room)
	rooms.push_back(room)
	make_spawner(room)
	
	return true

func make_spawner(room : Map_Gen_Algorithms.Room):
	var biome = Map_Gen_Algorithms.BiomeTypes.CAVE
	var spawner = Spawner.new()
	spawner.init(biome, 4, 1, room)
	get_tree().current_scene.get_node("EnemyManager").add_child.call_deferred(spawner)

# tell the room passed in where it's exits are
# if the exit is Vector2i.ZERO, then the given direction does not have an exit
func room_exits(room : Map_Gen_Algorithms.Room):
	var test =room.pos.y + (room.height / 2.0)
	var top_exit = Vector2i(room.pos.x, room.pos.y + (room.height / 2.0))
	if(map[top_exit.x][top_exit.y + 1] == floor):
		room.exits[room.exit_indices.TOP] = top_exit
		
	var bottom_exit = Vector2i(room.pos.x, room.pos.y - (room.height / 2.0))
	if(map[bottom_exit.x][bottom_exit.y - 1] == floor):
		room.exits[room.exit_indices.BOTTOM] = bottom_exit
		
	var left_exit = Vector2i(room.pos.x - (room.width / 2.0), room.pos.y)
	if(map[left_exit.x][left_exit.y - 1] == floor):
		room.exits[room.exit_indices.LEFT] = left_exit
		
	var right_exit = Vector2i(room.pos.x + (room.width / 2.0), room.pos.y)
	if(map[right_exit.x][right_exit.y + 1] == floor):
		room.exits[room.exit_indices.RIGHT] = right_exit
	return room
