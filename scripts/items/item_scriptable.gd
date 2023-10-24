extends Resource
class_name Item_Scriptable

@export var name : String = "item_name"
@export var stackSize : int = 1
@export var stat_modifiers_keys : Array[StatSystem.StatsEnum]# index 
@export var stat_modifiers_values : Array[float] # index 
@export var stat_modifiers_types : Array[StatSystem.ModifierType] # index 
@export var item_sprite : Texture2D
