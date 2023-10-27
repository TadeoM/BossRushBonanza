extends Resource
class_name Mob_Scriptable

@export var name : String = "Bat"
@export var core_stat_keys : Array[StatSystem.StatsEnum]
@export var core_stat_values : Array[int]
@export var sprite : SpriteFrames
@export var held_items : Array[Item_Scriptable]
@export var possible_drops : Array[Item_Scriptable]
