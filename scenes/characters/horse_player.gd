class_name HorsePlayer
extends RigidBody2D

@export var launch_power: float = 200


func connect_to_cursor(cursor: LaunchCursor):
	cursor.drag_released.connect(on_drag_released)

func on_drag_released(force_scale: Vector2) -> void:
	print("Now launching")
	linear_velocity = force_scale * launch_power
	print(linear_velocity)
