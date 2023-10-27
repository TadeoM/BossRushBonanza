extends Node
class_name Inventory

var ItemTypes = ItemHelpers.ItemTypes

var items = {
	
}
# var equipped_items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_item(item : Item_Scriptable):
	if !items.has(item.name):
		items[item.name] = item
	else:
		items[item.name].stackSize += 1
	
	print(items)
	print(items[item.name].stackSize)

func equip_item(item : Item_Scriptable):
	pass

func get_stat_modifiers():
	var newStatModifierList : Array[StatSystem.StatModifier]
	for item in items:
		for i in items[item].stat_modifiers_keys.size() - 1:
			print(items[item])
			var newStatModifier = StatSystem.StatModifier.new(item, item.stat_modifiers_keys[i], item.stat_modifiers_values[i], item.stat_modifiers_types[i])
			newStatModifierList.push_back(newStatModifier)

	for stat in newStatModifierList:
		print(StatSystem.StatsEnum.find_key(stat.stat_key), 
	 		" ", stat.stat_value, "%" if stat.modifier_type == StatSystem.ModifierType.PERCENTAGE_VALUE else "")
	return newStatModifierList

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
