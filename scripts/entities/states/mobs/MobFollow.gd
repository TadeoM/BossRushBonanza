extends MobState
class_name MobFollow

var player : CharacterBody2D
var follow_time

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	follow_time += delta
	var distance = player.global_position - enemy.global_position
	var direction = distance.normalized()
	
	if(enemy.movement):
		if distance.length() > 25:
			enemy.movement.execute(enemy, direction.normalized())
		else:
			enemy.velocity = Vector2()
	
	if distance.length() > 100:
		Transitioned.emit(self, "Idle")
