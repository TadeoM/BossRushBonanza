extends Node

enum MODIFIER_TYPE
{
	flat_value,
	percentage_value,
}

enum StatsEnum
{
	STRENGTH,
	DEXTERITY,
	INTELLIGENCE,

# str-based
	HEALTH,
	STAMINA_REGENERATION,
# int-based
	MANA,
	MANA_REGENERATION,
# dex-based
	PHYSICAL_DEFENCE,
	MAGICAL_DEFENCE,

	ATTACK_SPEED,
	CAST_SPEED,

	CRITICAL_HIT_CHANCE,
	CRITICAL_HIT_DAMAGE_MODIFIER,

	MOVEMENT_SPEED,

	STATS_COUNT
}

const StrengthCharacterCoreStats = {
	StatsEnum.STRENGTH: 5,
	StatsEnum.DEXTERITY: 3,
	StatsEnum.INTELLIGENCE: 1
}

const DexterityCharacterCoreStats = {
	StatsEnum.STRENGTH: 2,
	StatsEnum.DEXTERITY: 5,
	StatsEnum.INTELLIGENCE: 2
}

const IntelligenceCharacterCoreStats = {
	StatsEnum.STRENGTH: 1,
	StatsEnum.DEXTERITY: 3,
	StatsEnum.INTELLIGENCE: 5
}
