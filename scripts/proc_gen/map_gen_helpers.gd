class_name Map_Gen_Algorithms
static var CardinalDirections =  [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
static var rng

enum GenerationTypes {
	CORRIDOR_FIRST,
	DUNGEON,
	RANDOM_WALK,
}
enum BiomeTypes {
	DUNGEON,
	CAVE,
	FOREST
}

enum TileTypes{
	FLOOR,
	WALL,
	OBSTACLE,
	DECORATION,
	ORE
}
class Room:
	enum exit_indices {
		TOP    = 0,
		BOTTOM = 1,
		RIGHT  = 2,
		LEFT   = 3
	}
	var pos : Vector2i
	var world_pos : Vector2
	var width : int
	var height : int
	var exits : Array[Vector2i] = [Vector2i.ZERO, Vector2i.ZERO, Vector2i.ZERO, Vector2i.ZERO]
	
	func _init():
		pass

static func random_cardinal_direction() -> Vector2i:
	return CardinalDirections[randi_range(0, 3)]

static func random_walk(start_pos: Vector2i, walk_length: int):
	var path := {}
	path[start_pos] = 0
	var prev_pos = start_pos
	
	for i in range(walk_length):
		var new_pos = prev_pos + random_cardinal_direction()
		path[new_pos] = i+1
		prev_pos = new_pos
	return path

static func random_walk_corridor(start_pos: Vector2i, corridor_length : int, direction: Vector2i = random_cardinal_direction())-> Array[Vector2i]:
	var corridor : Array[Vector2i] = []
	var current_pos = start_pos
	corridor.push_back(current_pos)
	
	for i in range(corridor_length):
		if(current_pos.x-1 >= 0 && current_pos.y-1 >= 0 && current_pos.x+1 < 80 && current_pos.y+1 < 80):
			current_pos += direction
			corridor.push_back(current_pos)
	
	return corridor
