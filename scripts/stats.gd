extends Node
const StatEnumsObject = preload("res://scripts/stat_enums.gd") # Relative path
@onready var StatsEnum = StatEnumsObject.new().StatsEnum
@onready var ModifierTypeEnum = StatEnumsObject.new().MODIFIER_TYPE


# first evoked function
func _Init():
	var stats_enum = StatsEnum.STATS_COUNT as int
	for stat in stats_enum:
		print(stat)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
