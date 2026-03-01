class_name LanceWeapon
extends Area2D

@export var damage: int

# size

func fire_at_angle(radians: float) -> void:
	rotation = radians
