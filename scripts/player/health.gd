extends Node
class_name Health

var max_health : int = 100
var current_health : int = 100
var health_regen : int = 1
var armor : int = 0

var timer : float = 0.0

func regen_health():
	if(current_health < max_health):
		if((health_regen + current_health) > max_health):
			current_health = max_health
		else: current_health += health_regen

# Called when the node enters the scene tree for the first time.
func init(stats : Stats):
	current_health = stats.getCurrentStatValue(StatSystem.StatsEnum.HEALTH)
	max_health = current_health * 3
	armor = stats.getCurrentStatValue(StatSystem.StatsEnum.DEFENSE)
	print($"..".name + " Health: " + str(current_health))

func apply_damage(amount):
	print("Original Damage: " + str(amount))
	if(armor > 0):
		amount = amount * ((100 - armor) * 0.01)
		
	print("After Armor: " + str(amount))
	
	if(current_health < 0):
		current_health -= amount
	elif(current_health > amount):
		current_health -= amount
	else: 
		$"..".queue_free()

func _process(delta):
	timer += delta
	if(timer > 60.0):
		regen_health()
		timer = 0.0
