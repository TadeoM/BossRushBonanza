extends Entity
@export var class_scriptable : Class_Scriptable

@onready var rng = RandomNumberGenerator.new()

var dash = load_ability("dash")
var sword_attack = load_ability("sword_attack")

var attack_speed

func _ready():
	entity_stats.init(class_scriptable.core_stats_keys, class_scriptable.core_stats_values)
	health.init(entity_stats)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _read_input():
	velocity = Vector2()
	
	if Input.is_action_just_pressed("dev_random_stat"):
		var newStat = StatModifier.new(self, StatsEnum.STRENGTH, 1, ModifierTypeEnum.FLAT_VALUE) # rng.randi_range(0, StatsEnum.STATS_COUNT-1)
		var stat_name = StatsEnum.keys()[newStat.stat_key]
		var old_stat_value = entity_stats.getCurrentStatValue(newStat.stat_key)
		entity_stats.addStatModifier(newStat)
		var new_stat_value = entity_stats.getCurrentStatValue(newStat.stat_key)
		print(stat_name, ": Old Value: ", old_stat_value, "->New Value: ", new_stat_value)

	if Input.is_action_just_pressed("dev_spawn_item"):
		inventory.add_item(testItem)
		var stat_dictionary = inventory.get_stat_modifiers()
		for stat in stat_dictionary:
			entity_stats.addStatModifier(stat_dictionary[stat])

	if (Input.is_action_pressed("ig_up")): movement.execute(self, "up")
	elif (Input.is_action_pressed("ig_down")): movement.execute(self, "down")
	if (Input.is_action_pressed("ig_left")): movement.execute(self, "left")
	elif (Input.is_action_pressed("ig_right")): movement.execute(self, "right")

	if (last_ability > global_cooldown):
		if(Input.is_action_pressed("ig_dash")):
			dash.execute(self)
			last_ability = 0
		if(Input.is_action_pressed("ig_attack_1")):
			sword_attack.execute(self, 20, 4, entity_stats.getCurrentStatValue(StatsEnum.STRENGTH))
			last_ability = 0

func _physics_process(delta):
	super._physics_process(delta)
	_read_input()
