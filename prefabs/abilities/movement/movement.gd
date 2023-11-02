extends Ability
class_name Movement

var max_speed : float = 200.0
var current_speed : float = 0.0
var acceleration : float = 4.0
var time : float = 0.0

func _process(delta):
	time += delta

func execute(source, dir : Vector2):
	current_speed = 100 + source.entity_stats.getCurrentStatValue(StatSystem.StatsEnum.MOVEMENT_SPEED) if source.entity_stats else 100 # temp while stats aren't finalzied
	max_speed = current_speed * 3
	source.velocity = Vector2()
	source.velocity = dir * current_speed
	print(source.name + " Speed: (" + str(source.velocity.length()))
	
	if source.animatedSprite:
		source.animatedSprite.play("walk_left")
		
		if source.velocity.x > 0:
			source.animatedSprite.flip_h = true
		else:
			source.animatedSprite.flip_h = false
	
	source.move_and_slide()

