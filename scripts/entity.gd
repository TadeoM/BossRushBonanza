extends CharacterBody2D
class_name Entity

var StatsEnum = StatSystem.StatsEnum 
var ModifierTypeEnum = StatSystem.ModifierType 
var StatModifier = StatSystem.StatModifier 

# dev onready vars
@onready var testItem : Item_Scriptable = preload("res://resources/items/shield.tres")

# onready vars
@onready var inventory : Inventory = get_node('./Inventory')
@onready var entity_stats : Stats = get_node('./Stats')
@onready var sprite = $AnimatedSprite2D

var movement = load_ability("movement")

var max_mana : int = 100
var current_mana : int = 100 
var mana_regen : int = 1

var global_cooldown = 30
var is_busy : bool = false
var last_ability : int = 0

var timer : int = 0


func _ready():
	current_mana = entity_stats.getCurrentStatValue(StatsEnum.MANA)
	max_mana = entity_stats.getCurrentStatValue(StatsEnum.MANA)

func regen_mana():
	if(current_mana < max_mana):
		if((mana_regen + current_mana) > max_mana):
			current_mana = max_mana
		else: current_mana += mana_regen

func modify_mana(amount):
	var new_mana = current_mana + amount
	if(new_mana < 0): current_mana = 0
	if(new_mana > max_mana): current_mana = max_mana
	else: current_mana += amount

func _physics_process(delta):
	last_ability += 1
	timer += delta
	if((timer % 60) == 0):
		regen_mana()

func load_ability(ability_name):
	var scene = load("res://prefabs/abilities/" + ability_name + "/" + ability_name + ".tscn")
	var sceneNode = scene.instantiate()
	add_child(sceneNode)
	sceneNode.configure(self)
	return sceneNode
