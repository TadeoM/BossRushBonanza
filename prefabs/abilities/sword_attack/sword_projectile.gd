extends Area2D
class_name Sword_Projectile

var direction = null
var distance = null
var speed = null
var parent = null
var moved = 0

var damage

func configure(source = null, my_direction = null, my_distance = null, my_speed = null, my_damage = null):
	parent = source
	direction = my_direction
	distance = my_distance
	speed = my_speed
	damage = my_damage

func _ready():
	pass

func _physics_process(delta):
	if (moved < distance):
		move()
	if (moved >= distance):
		self.queue_free()
  
func move():
	moved += 1
  
	self.position += direction.normalized() * speed

func _on_body_entered(body : Node2D):
	if (body is Entity):
		var health = body.get_node('./Health')
		health.apply_damage(damage)
