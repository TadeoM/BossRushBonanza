extends Node
const StatHelperObject = preload("res://scripts/stats_helper.gd") 
@onready var StatsEnum = StatHelperObject.new().StatsEnum
@onready var ModifierTypeEnum = StatHelperObject.new().ModifierType

var player_stats
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	player_stats = get_node('./PlayerStats')
	#print(player_stats)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ig_spawn_item"):
		# some comment
		var newStat = StatHelperObject.StatModifier.new(self, rng.randi_range(0, StatsEnum.STATS_COUNT-1), rng.randi_range(1, 50), ModifierTypeEnum.FLAT_VALUE)
		var stat_name = StatsEnum.keys()[newStat.stat_key]
		player_stats.addStatModifier(newStat.stat_key, newStat)
		print(player_stats.getCurrentStatValue(newStat.stat_key))
