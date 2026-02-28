class_name LaunchCursor
extends Node2D

var _is_dragging: bool = false

@onready var grow_animated_sprite: AnimatedSprite2D = $GrowAnimatedSprite
@onready var direction_arrow_sprite: Sprite2D = $DirectionArrowSprite

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		on_primary_pressed()
	
	if event.is_action_released("primary") and _is_dragging:
		on_primary_released()
		
	if event is InputEventMouseMotion:
		print("CursorPosition: %s\nMousePosition: %s" % [global_position, event.position])
		direction_arrow_sprite.rotation = event.position.angle_to_point(global_position)

func on_primary_pressed() -> void:
	visible = true
	_is_dragging = true
	position = get_viewport().get_mouse_position()
	
	grow_animated_sprite.play("grow")

func on_primary_released() -> void:
	visible = false
