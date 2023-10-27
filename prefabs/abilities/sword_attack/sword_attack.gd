extends Ability 
class_name Sword_Attack
@onready var sprite = $Sprite2D

var projectile = load("res://prefabs/abilities/sword_attack/sword_projectile.tscn")

var range = 10
var animation_speed = 0.25

func _ready():
	pass

func _process(delta):
	var direction = (parent.get_global_mouse_position() - parent.position).normalized()
	self.position.x = direction.x * range
	self.position.y = direction.y * range
	look_at(get_global_mouse_position())

func execute(source, distance = null, speed = null, damage = null):
	var direction = (source.get_global_mouse_position() - source.position).normalized()
	
	self.position.x = direction.x * 15
	self.position.y = direction.y * 15

	var projectile_instance = projectile.instantiate()
	projectile_instance.position.x = source.position.x + direction.x * 10
	projectile_instance.position.y = source.position.y + direction.y * 10
	get_tree().current_scene.add_child(projectile_instance)
	projectile_instance.configure(source, direction, distance, speed, damage)
	
	await get_tree().create_timer(animation_speed).timeout
	self.position.x = 0
	self.position.y = 0


