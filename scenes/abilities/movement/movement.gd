extends Node
class_name Movement

var max_speed : float = 200
var current_speed : float = 0
var acceleration : float = 4


func execute(source, dir):
	current_speed = source.entity_stats.getCurrentStatValue(StatSystem.StatsEnum.MOVEMENT_SPEED)
	current_speed = 100 # temp while stats aren't finalzied
	max_speed = current_speed * 3
	source.velocity = Vector2()

	if (dir == "up"):
		source.velocity.y -= current_speed
	elif (dir == "down"):
		source.velocity.y += current_speed
	if (dir == "left"):
		source.velocity.x -= current_speed
	elif (dir == "right"):
		source.velocity.x += current_speed
		
	source.velocity = source.velocity.normalized() * current_speed
	source.move_and_slide()

