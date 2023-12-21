extends Ability
class_name EnemyBasicMove

var max_speed : float = 200.0
var current_speed : float = 0.0
var acceleration : float = 4.0
var time : float = 0.0
var distance_to_track : float = 100.0
var source : Node2D
var target : Node2D

func configure(_source : Node2D):
	super.configure(_source)
	source = _source
	target = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	time += delta
	
	if((target.position - source.position).length() < distance_to_track):
		execute()

func execute():
	if(!target):
		return
	current_speed = 100 + source.entity_stats.getCurrentStatValue(StatSystem.StatsEnum.MOVEMENT_SPEED) if source.entity_stats else 100 # temp while stats aren't finalzied
	max_speed = current_speed * 3
	source.velocity = Vector2()
	var dir = (target.position - source.position).normalized()
	source.velocity = dir * current_speed
	
	if source.animatedSprite:
		source.animatedSprite.play("walk_left")
		
		if source.velocity.x > 0:
			source.animatedSprite.flip_h = true
		else:
			source.animatedSprite.flip_h = false
	
	source.move_and_slide()

