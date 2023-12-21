extends CharacterBody2D
class_name Entity

var StatsEnum = StatSystem.StatsEnum 
var ModifierTypeEnum = StatSystem.ModifierType 
var StatModifier = StatSystem.StatModifier 

# dev onready vars
@onready var testItem : Item_Scriptable = preload("res://resources/items/shield.tres")

# onready vars
@onready var inventory : Inventory
@onready var entity_stats : Stats
@onready var health : Health
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D

var movement

var max_mana : int = 100
var current_mana : int = 100 
var mana_regen : int = 1

var global_cooldown = 30
var is_busy : bool = false
var last_ability : int = 0

var timer : int = 0

func _init():
	inventory = Inventory.new()
	health = Health.new()
	entity_stats = Stats.new()
	
	inventory.set_name("Inventory")
	health.set_name("Health")
	entity_stats.set_name("Stats")
	
	add_child(inventory)
	add_child(health)
	add_child(entity_stats)

func _ready():
	current_mana = entity_stats.getCurrentStatValue(StatsEnum.MANA)
	max_mana = entity_stats.getCurrentStatValue(StatsEnum.MANA)
	animatedSprite.play()

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

func _on_death(source):
	queue_free()
