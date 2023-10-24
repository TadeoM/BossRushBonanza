extends CharacterBody2D
class_name Ai_Enemy_Movement

@onready var _animated_sprite = $AnimatedSprite2D
@export var speed = 30

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	#_animated_sprite.play("default")


func _physics_process(delta):
	get_input()
	move_and_slide()
