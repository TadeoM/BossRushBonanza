extends Node
const StatHelperObject = preload("res://scripts/stats_helper.gd") # Relative path
@onready var StatsEnum = StatHelperObject.new().StatsEnum
@onready var ModifierTypeEnum = StatHelperObject.new().MODIFIER_TYPE

var stats_enum_count: int
var base_stat_values = {}
var stat_modifiers_values = {}
var max_stat_dictionary_stat_values = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stats_enum_count = StatsEnum.STATS_COUNT
	for stat in StatsEnum:
		if(StatsEnum[stat] == StatsEnum.STATS_COUNT):
			continue
		base_stat_values[StatsEnum[stat]] = StatsEnum[stat]
		var stat_name = StatsEnum.keys()[StatsEnum[stat]]
		var returned_stat_value = getCurrentStatValue(StatsEnum[stat])
		print(stat_name, " ", returned_stat_value)

func getStrengthBasedStatValue(stat_enum_val):
	var stat_name = StatsEnum.keys()[stat_enum_val]
	return base_stat_values[stat_enum_val]

func getDexterityBasedStatValue(stat_enum_val):
	var stat_name = StatsEnum.keys()[stat_enum_val]
	return base_stat_values[stat_enum_val]

func getIntelligenceBasedStatValue(stat_enum_val):
	var stat_name = StatsEnum.keys()[stat_enum_val]
	return base_stat_values[stat_enum_val]

func getCurrentStatValue(stat_enum_val):
	var current_stat_value
	
	match stat_enum_val:
		StatsEnum.STRENGTH, StatsEnum.HEALTH, StatsEnum.STAMINA_REGENERATION, StatsEnum.PHYSICAL_DEFENCE:
			current_stat_value =  getStrengthBasedStatValue(stat_enum_val)
		StatsEnum.DEXTERITY, StatsEnum.ATTACK_SPEED, StatsEnum.CRITICAL_HIT_CHANCE, StatsEnum.CRITICAL_HIT_DAMAGE_MODIFIER, StatsEnum.MOVEMENT_SPEED:
			current_stat_value = getDexterityBasedStatValue(stat_enum_val)
		StatsEnum.INTELLIGENCE, StatsEnum.MANA, StatsEnum.MANA_REGENERATION, StatsEnum.CAST_SPEED, StatsEnum.MAGICAL_DEFENCE:
			current_stat_value = getIntelligenceBasedStatValue(stat_enum_val)
	
	return current_stat_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
