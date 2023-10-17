extends Node
class_name Stats
var StatsEnum = StatSystem.StatsEnum 
var StatModifier = StatSystem.StatModifier 

var stats_enum_count: int
var base_stats = {
	# key: int (StatsEnum)
	# value: float (straight value)
}
var stat_modifiers_dictionary = {
	# Key: int (StatsEnum)
	# Value: Array of StatModifier (found in stats_helper.gd)
}
var max_stat_dictionary_stat_values = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stats_enum_count = StatsEnum.STATS_COUNT
	for stat in StatsEnum:
		if(StatsEnum[stat] == StatsEnum.STATS_COUNT):
			continue
		base_stats[StatsEnum[stat]] = StatsEnum[stat]
		stat_modifiers_dictionary[StatsEnum[stat]] = []
		var stat_name = StatsEnum.keys()[StatsEnum[stat]]
		var returned_stat_value = getCurrentStatValue(StatsEnum[stat])
		#print(stat_name, " ", returned_stat_value)

func getCoreStatValue(stat_enum_key):
	var stat_name = StatsEnum.keys()[stat_enum_key]
	var current_stat_value = base_stats[stat_enum_key]
	
	for modifier in stat_modifiers_dictionary[stat_enum_key]:
		current_stat_value += modifier.stat_value
	
	return current_stat_value

func getSubStatStatValue(stat_enum_key, core_stat_key):
	var stat_name = StatsEnum.keys()[stat_enum_key]
	var current_stat_value = base_stats[stat_enum_key] + getCoreStatValue(core_stat_key)
	
	for modifier in stat_modifiers_dictionary[stat_enum_key]:
		current_stat_value += modifier.stat_value
	
	return current_stat_value 

func getCurrentStatValue(stat_enum_key):
	var current_stat_value
	
	match stat_enum_key:
		StatsEnum.STRENGTH, StatsEnum.DEXTERITY, StatsEnum.INTELLIGENCE, StatsEnum.LUCK, StatsEnum.VERSATILITY, StatsEnum.FAITH:
			current_stat_value = getCoreStatValue(stat_enum_key)
		StatsEnum.HEALTH, StatsEnum.DAMAGE_REDUCTION, StatsEnum.PHYSICAL_DAMAGE:
			current_stat_value =  getSubStatStatValue(stat_enum_key, StatsEnum.STRENGTH)
		StatsEnum.STAMINA, StatsEnum.STAMINA_REGEN, StatsEnum.RANGE_DAMAGE:
			current_stat_value = getSubStatStatValue(stat_enum_key, StatsEnum.DEXTERITY)
		StatsEnum.MANA, StatsEnum.MANA_REGENERATION, StatsEnum.SPELL_DAMAGE:
			current_stat_value = getSubStatStatValue(stat_enum_key, StatsEnum.INTELLIGENCE)
		StatsEnum.CRITICAL_HIT_CHANCE, StatsEnum.CRITICAL_MULTIPLIER, StatsEnum.MOVEMENT_SPEED:
			current_stat_value =  getSubStatStatValue(stat_enum_key, StatsEnum.LUCK)
		StatsEnum.DAMAGE, StatsEnum.ATTACK_SPEED:
			current_stat_value = getSubStatStatValue(stat_enum_key, StatsEnum.VERSATILITY)
		StatsEnum.RARITY, StatsEnum.DEFENSE, StatsEnum.RANGE:
			current_stat_value = getSubStatStatValue(stat_enum_key, StatsEnum.FAITH)
	
	return current_stat_value

func addStatModifier(stat : StatSystem.StatModifier):
	stat_modifiers_dictionary[stat.stat_key].push_back(stat)
	var stat_name = StatsEnum.keys()[stat.stat_key]
	var dict_array_size = stat_modifiers_dictionary[stat.stat_key].size()
	
	#print(stat_name, " ", stat_modifiers_dictionary[stat_enum_key][dict_array_size-1].stat_value)
