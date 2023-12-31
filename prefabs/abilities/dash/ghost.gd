extends Area2D
class_name SwordProjectile

var direction = null
var distance = null
var speed = null
var parent = null
var moved = 0

func configure(source = null, my_direction = null, my_distance = null, my_speed = null):
	parent = source
	direction = my_direction
	distance = my_distance
	speed = my_speed
	#look_at(source.position + my_direction)

func _physics_process(delta):
	if (moved < distance):
		move()
	if (moved >= distance):
		parent.position = self.position
		self.queue_free()
  
func move():
	moved += 1
	
	self.position = direction * speed
