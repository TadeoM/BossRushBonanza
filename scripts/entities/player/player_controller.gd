extends Entity
@export var player_class_scriptable : PlayerClassScriptable
@export_range(0.5, 5) var camera_zoom : float

@onready var rng = RandomNumberGenerator.new()

var dash = load_ability("dash")
var sword_attack = load_ability("sword_attack")

var attack_speed

func _ready():
	super._ready()
	movement = load_ability("movement")
	entity_stats.init(player_class_scriptable.core_stats_keys, player_class_scriptable.core_stats_values)
	health.init(self, entity_stats)
	$Camera2D.zoom = Vector2(camera_zoom, camera_zoom)
	
	#print(entity_stats.getCurrentStatValue(StatSystem.StatsEnum.MOVEMENT_SPEED))

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
	
	var dir = Vector2()
	if (Input.is_action_pressed("ig_up")): dir += Vector2.UP
	elif (Input.is_action_pressed("ig_down")): dir += Vector2.DOWN
	if (Input.is_action_pressed("ig_left")): dir += Vector2.LEFT
	elif (Input.is_action_pressed("ig_right")): dir += Vector2.RIGHT
	
	if dir.length() > 0:
		movement.execute(self, dir.normalized())
	
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

func _on_death(source):
	print("player died")
	#super._on_death(source)
	pass

func _on_body_entered(body : Node2D):
	if (body is TileMap):
		print("collided with " + body.name)

