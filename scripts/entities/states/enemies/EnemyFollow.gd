extends EnemyState
class_name EnemyFollow

var player : CharacterBody2D
var follow_time : float = 0.0

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	follow_time += delta
	var distanceToPlayer = player.global_position - enemy.global_position
	var direction = distanceToPlayer.normalized()
	
	if(enemy.movement):
		if distanceToPlayer.length() > 50:
			enemy.movement.execute(enemy, direction.normalized())
		else:
			enemy.velocity = Vector2()
	
	if distanceToPlayer.length() > 100:
		transitioned.emit(self, "Idle")
