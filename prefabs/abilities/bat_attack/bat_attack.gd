extends Ability 
class_name Bat_Attack
@onready var sprite = $Sprite2D

var projectile = load("res://prefabs/abilities/bat_attack/bat_projectile.tscn")
var target : Node2D

var range : float = 10
var isAnimating : bool = false
var current_time : float = 0
var animation_speed : float = 0.25

func configure(source : Node2D, targ : Node2D = null):
	super.configure(source)
	target = targ

func _process(delta):
	if !target: 
		return
	var direction = (target.position - parent.position).normalized()
	self.position = direction * range

	look_at(get_global_mouse_position())
	var rotation_current = self.rotation
	
	if isAnimating:
		var animated_dir = Vector2()
		var dir_rotation = lerp(0, 60, current_time/animation_speed)
		animated_dir.x = (direction.x * cos(dir_rotation * PI/180)) - (direction.y * sin(dir_rotation * PI/180))
		animated_dir.y = (direction.x * sin(dir_rotation * PI/180)) + (direction.y * cos(dir_rotation * PI/180))
		
		var rotation_start = 0
		var rotation_end = 140

		self.position = animated_dir * range
		var rotation = lerp(rotation_current + rotation_start, rotation_current + rotation_end, current_time/animation_speed)
		self.rotation = self.rotation + (rotation * PI/180)
		current_time += delta


func execute(source, distance = null, speed = null, damage = null):
	var direction = (target.position - source.position).normalized()
	
	self.position.x = direction.x * 15
	self.position.y = direction.y * 15
	self.rotation = 0

	var projectile_instance = projectile.instantiate()
	projectile_instance.position.x = source.position.x + direction.x * 10
	projectile_instance.position.y = source.position.y + direction.y * 10
	get_tree().current_scene.add_child(projectile_instance)
	projectile_instance.configure(source, direction, distance, speed, damage)
	
	current_time = 0
	isAnimating = true
	await get_tree().create_timer(animation_speed).timeout
	isAnimating = false
