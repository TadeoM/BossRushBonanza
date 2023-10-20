extends Node
# class redefinitions
var StatsEnum = StatSystem.StatsEnum 
var ModifierTypeEnum = StatSystem.ModifierType 
var StatModifier = StatSystem.StatModifier 

# dev onready vars
@onready var testItem : Item_Scriptable = preload("res://resources/items/shield.tres")

# onready vars
@onready var inventory : Inventory = get_node('./Inventory')
@onready var player_stats : Stats = get_node('./PlayerStats')
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("dev_random_stat"):
		# some comment
		var newStat = StatModifier.new(self, 0, 1, ModifierTypeEnum.FLAT_VALUE) # rng.randi_range(0, StatsEnum.STATS_COUNT-1)
		var stat_name = StatsEnum.keys()[newStat.stat_key]
		var old_stat_value = player_stats.getCurrentStatValue(newStat.stat_key)
		player_stats.addStatModifier(newStat)
		var new_stat_value = player_stats.getCurrentStatValue(newStat.stat_key)
		#print(stat_name, ": Old Value: ", old_stat_value, "->New Value: ", new_stat_value)

	if Input.is_action_just_pressed("dev_spawn_item"):
		inventory.add_item(testItem)
		var stat_dictionary = inventory.get_stat_modifiers()
		for stat in stat_dictionary:
			player_stats.addStatModifier(stat_dictionary[stat])
