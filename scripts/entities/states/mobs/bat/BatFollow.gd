extends MobFollow
class_name BatFollow

var attack_timer  : float

func Enter():
	super.Enter()
	attack_timer = 1.0

func Physics_Update(delta: float):
	super.Physics_Update(delta)
	

