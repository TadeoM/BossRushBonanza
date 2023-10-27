extends Ability
class_name Shoot_Attack

func execute(source, dir = null):
	source.velocity = Vector2()

	if (dir == "up"):
		source.velocity.y -= source.current_speed
	if (dir == "down"):
		source.velocity.y += source.current_speed
	if (dir == "right"):
		source.velocity.x -= source.current_speed
	if (dir == "left"):
		source.velocity.x += source.current_speed
  
	source.velocity = source.velocity.normalized()
	source.velocity = source.move_and_slide(source.velocity * source.max_speed)
  
