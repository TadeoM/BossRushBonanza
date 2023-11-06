extends Node
class_name Health

signal death_signal

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
func init(source: CharacterBody2D, stats : Stats):
	current_health = stats.getCurrentStatValue(StatSystem.StatsEnum.HEALTH)
	max_health = current_health * 3
	armor = stats.getCurrentStatValue(StatSystem.StatsEnum.DEFENSE)
	death_signal.connect(source._on_death)

func apply_damage(amount):
	#print("Original Damage: " + str(amount))
	if(armor > 0):
		var reductionFactor = max(0, ((100 - armor) * 0.01))
		amount = amount * reductionFactor
		
	#print("After Armor: " + str(amount))
	
	if(current_health < 0):
		current_health -= amount
	elif(current_health > amount):
		current_health -= amount
	else: 
		death_signal.emit(self)

func _process(delta):
	timer += delta
	if(timer > 60.0):
		regen_health()
		timer = 0.0
