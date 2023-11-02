extends Entity
@export var mob_scriptable : Mob_Scriptable

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	entity_stats.init(mob_scriptable.core_stat_keys, mob_scriptable.core_stat_values)
	health.init(entity_stats)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
