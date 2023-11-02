class_name StatSystem

enum ModifierType
{
	FLAT_VALUE,
	PERCENTAGE_VALUE,
}

enum StatsEnum
{
	STRENGTH,
	DEXTERITY,
	INTELLIGENCE,
	
	LUCK,
	VERSATILITY,
	FAITH,
	
# str-based
	HEALTH,
	DEFENSE,
	BURN_CHANCE,
	
# int-based
	MANA,
	MANA_REGENERATION,
	MAGIC_DEFENSE,
	FREEZE_CHANCE,
	
# dex-based
	STAMINA,
	STAMINA_REGEN,
	PHYS_DEFENSE,
	THUNDER_CHANCE,
	
# luck-based
	CRITICAL_HIT_CHANCE,
	CRITICAL_MULTIPLIER,	
	MOVEMENT_SPEED,
	ENFEEBLE_CHANCE,
	
# versatility-based
	DAMAGE,
	HIT_POINTS,
	BLEED_CHANCE,
	
# faith-based
	RARITY,
	RANGE,
	ATTACK_SPEED,
	HOLY_BREAK,
	
	STATS_COUNT # count: 45
}

class StatModifier:
	var modifier_source
	var stat_key : StatsEnum
	var stat_value : float
	var modifier_type : ModifierType
	
	func _init(_modifier_source, _stat_key, _stat_value, _modifier_type):
		modifier_source = _modifier_source
		stat_key = _stat_key
		stat_value = _stat_value
		modifier_type = _modifier_type

const StrengthCharacterCoreStats = {
	StatsEnum.STRENGTH: 5,
	StatsEnum.DEXTERITY: 3,
	StatsEnum.INTELLIGENCE: 1,
	
	StatsEnum.LUCK: 1,
	StatsEnum.VERSATILITY: 1,
	StatsEnum.FAITH: 1,
}

const DexterityCharacterCoreStats = {
	StatsEnum.STRENGTH: 2,
	StatsEnum.DEXTERITY: 5,
	StatsEnum.INTELLIGENCE: 2,
	
	StatsEnum.LUCK: 1,
	StatsEnum.VERSATILITY: 1,
	StatsEnum.FAITH: 1,
}

const IntelligenceCharacterCoreStats = {
	StatsEnum.STRENGTH: 1,
	StatsEnum.DEXTERITY: 3,
	StatsEnum.INTELLIGENCE: 5,
	
	StatsEnum.LUCK: 1,
	StatsEnum.VERSATILITY: 1,
	StatsEnum.FAITH: 1,
}
