extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	_animated_sprite.play("default")

func _physics_process(delta):
	get_input()
	move_and_slide()
