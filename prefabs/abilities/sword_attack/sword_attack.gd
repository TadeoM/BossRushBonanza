extends Area2D
class_name SwordAttack
@onready var hitbox = $CollisionShape2D

var range = 60
var animation_speed = 0.25

func _ready():
	$".".body_entered.connect(self._on_body_enter)


func _process(delta):
	pass

func execute(source, direction = null):
	if (!direction): 
		direction = (source.get_global_mouse_position() - source.position).normalized()
	
	print(direction)
	self.position.x = direction.x * 15
	self.position.y = direction.y * 15
	hitbox.disabled = false
	await get_tree().create_timer(animation_speed).timeout
	hitbox.disabled = true
	self.position.x = 0
	self.position.y = 0

func _on_body_enter(body):
	print("here")
