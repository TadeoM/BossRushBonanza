extends EnemyFollow
class_name BatFollow

var StatsEnum = StatSystem.StatsEnum
var attack_timer  : float = 1.0
var current_time : float = 0.0

func Enter():
	super.Enter()
	var faith = enemy.entity_stats.getCurrentStatValue(StatsEnum.FAITH)
	var attack_speed = enemy.entity_stats.getCurrentStatValue(StatsEnum.ATTACK_SPEED)
	
	attack_timer = 1.0 + (1.0 *  enemy.entity_stats.getCurrentStatValue(StatsEnum.FAITH) + enemy.entity_stats.getCoreStatValue(StatsEnum.ATTACK_SPEED))
	print (attack_timer)

func Physics_Update(delta: float):
	current_time += delta
	if !player:
		return
	super.Physics_Update(delta)
	enemy.attack_pattern.configure(enemy, player)
	var distanceToPlayer = player.global_position - enemy.global_position
	var direction = distanceToPlayer.normalized()
	
	if current_time > attack_timer:
		current_time = 0.0
		enemy.attack_pattern.execute(enemy, 20, 4, enemy.entity_stats.getCurrentStatValue(StatsEnum.STRENGTH))
