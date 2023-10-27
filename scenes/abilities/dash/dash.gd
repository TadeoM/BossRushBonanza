extends Node
class_name Dash

var ghost = load("res://scenes/abilities/dash/ghost.tscn")

var distance = 60
var speed = 200
var cooldown = 5

func execute(source, direction = null):
	if (!direction): 
		direction = (source.get_global_mouse_position() - source.position).normalized()
	var look_at = source.get_global_mouse_position()
	speed = source.entity_stats.getCurrentStatValue(StatSystem.StatsEnum.MOVEMENT_SPEED)

	var ghost_instance = ghost.instantiate()
	ghost_instance.position.x = source.position.x + direction.x * 10
	ghost_instance.position.y = source.position.y + direction.y * 10
	get_tree().current_scene.add_child(ghost_instance)
	ghost_instance.configure(source, direction, distance, speed)
	
