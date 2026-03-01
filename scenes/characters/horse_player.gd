class_name HorsePlayer
extends RigidBody2D

var _JUMP_TEXTURE: Texture2D = preload("uid://b1yrtrcigajii")
var _LAND_TEXTURE: Texture2D = preload("uid://dwci8yofvnu7x")

@export var launch_power: float = 75
@export var max_jumps: int = 3

var _remaining_jumps: int
var _in_air: bool = false:
	set(value):
		var sprite_texture: Texture2D = _JUMP_TEXTURE if value else _LAND_TEXTURE
		sprite_2d.texture = sprite_texture
	get: 
		return _in_air

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var lance_weapon: LanceWeapon = $LanceWeapon

func _ready() -> void:
	_in_air = false
	_remaining_jumps = max_jumps

func connect_to_cursor(cursor: LaunchCursor):
	cursor.drag_released.connect(on_drag_released)

func on_drag_released(force_scale: Vector2) -> void:
	lance_weapon.fire_at_angle(force_scale.normalized().angle())
	
	# Verticality is dampened instead of disabling force
	if _in_air and _remaining_jumps <= 0:
		if force_scale.y < 0:
			#print("No more jumps!")
			force_scale.y = force_scale.y * .25
		
	linear_velocity += force_scale * launch_power
	_remaining_jumps += -1
	#print("Remaining jumps: %s\nIn Air: %s" % [_remaining_jumps, _in_air])
	
	sprite_2d.flip_h = linear_velocity.x < 0

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body is FloorBody:
		reset_jumps()
		_in_air = false

func _on_body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body is FloorBody:
		_in_air = true

func reset_jumps() -> void:
	_remaining_jumps = max_jumps

func is_touching_floor() -> bool:
	var colliding_bodies: Array[Node2D] = get_colliding_bodies()
	
	return colliding_bodies and colliding_bodies[0] is FloorBody
