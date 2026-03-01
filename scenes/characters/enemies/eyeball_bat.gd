class_name EyeballBat
extends CharacterBody2D

signal died()

const LIFT: float = 100.0
const SPEED: float = 50.0
const MAX_HEALTH: int = 2
const DEATH_SOUND: AudioStream = preload("uid://cqj801am12a3h")

@export var stun_duration: float = 1.5
@export var hover_height: float = 100.0:
	set(value):
		hover_height = value
		_hover_y = 156 - hover_height

var _current_health: int = MAX_HEALTH:
	set(value):
		if _current_health == 0:
			return
		
		if value <= 0:
			die()
		# Stun activates ANY health change (healing included)
		stun_self()
		_current_health = value
	get:
		return _current_health
var _is_stunned: bool = false:
	set(value):
		if value and !_is_stunned:
			stun_timer.start()
		if value and _is_stunned:
			stun_timer.stop()
			stun_timer.start()
		_is_stunned = value
	get:
		return _is_stunned

var _hover_y: float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_area: Area2D = $HitboxArea
@onready var hurtbox_area: Area2D = $HurtboxArea
@onready var stun_timer: Timer = $StunTimer
@onready var hit_audio: AudioStreamPlayer2D = $HitAudio


func _ready() -> void:
	stun_timer.wait_time = stun_duration
	# 156 is hardcoded floor.y
	_hover_y = 156 - hover_height

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if _is_stunned:
		if not is_on_floor():
			velocity += get_gravity() * delta
		# only uses physics when stunned
		move_and_slide()
		return
	else:
		velocity = Vector2.ZERO
	
	position.y = move_toward(position.y, _hover_y, LIFT * delta)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

func take_damage(amount: int) -> void:
	_current_health -= amount
	hit_audio.play()
	
	animated_sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.modulate = Color.WHITE
	

func stun_self() -> void:
	# Many of the stun effects are in _physics_process
	_is_stunned = true
	hitbox_area.set_deferred("monitorable", false)


func _on_stun_timer_timeout() -> void:
	hitbox_area.set_deferred("monitorable", true)
	
	_is_stunned = false

func die() -> void:
	died.emit()
	hurtbox_area.area_entered.disconnect(_on_hurtbox_area_entered)
	hitbox_area.set_deferred("monitorable", false)
	
	hit_audio.stream = DEATH_SOUND
	hit_audio.play()
	
	
	var death_fade := get_tree().create_tween()
	death_fade.tween_property(animated_sprite_2d, "modulate:a", 0, 1).set_trans(Tween.TRANS_CUBIC)
	
	animated_sprite_2d.stop()
	
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is LanceWeapon and !area.get_parent().sleeping:
		take_damage(area.damage)
