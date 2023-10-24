extends Item_Scriptable
class_name Weapon_Scriptable

@export var base_damage_low : float = 1.0
@export var base_damage_high : float = 2.0
@export var base_attack_speed : float = 1.5
@export var attack_pattern : Node2D

# create a class that can be inheritted from for attack pattern, IE: how to spawn particles, and hitboxes
# class_name Attack_Pattern
# var collider_shape
# func attack():
#   pass

# next class being:
# extends Attack_Pattern
# class_name Sword_Swing
# func attack():
# spawn X collider_shape
# 

#

