class_name LaunchCursor
extends Node2D

signal drag_released(force_scale: Vector2)

var _is_dragging: bool = false
var _drag_distance: Vector2 = Vector2.ZERO

@onready var grow_animated_sprite: AnimatedSprite2D = $GrowAnimatedSprite
@onready var direction_arrow_sprite: Sprite2D = $DirectionArrowSprite

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		on_primary_pressed()
	
	if event.is_action_released("primary") and _is_dragging:
		on_primary_released()
		
	if _is_dragging and event is InputEventMouseMotion:
		_drag_distance =  global_position - event.position
		direction_arrow_sprite.rotation = _drag_distance.angle()
		
		# Magic numbers yippie
		direction_arrow_sprite.scale.x = clampf(
			_drag_distance.length() / 50,
			0.5,
			2.0
			)

func on_primary_pressed() -> void:
	visible = true
	_is_dragging = true
	position = get_viewport().get_mouse_position()
	
	grow_animated_sprite.play("grow")

func on_primary_released() -> void:
	visible = false
	drag_released.emit(calculate_force_from_distance(_drag_distance))

# Calculates the force scale based on the mouse position since the player clicked to start the cursor
func calculate_force_from_distance(distance: Vector2) -> Vector2:
	var result: Vector2 = distance.normalized()  * clampf(
		distance.length(),
		0.5,
		2
	)
	
	return result
