class_name EyeballSpawner
extends Node2D

signal spawned_enemy()

const EYEBALL: Resource = preload("uid://deannrps0wbic")
const GROUND_Y: float = 156.0

@onready var spawn_delay_timer: Timer = $SpawnDelayTimer

func _ready() -> void:
	spawn_at(30)

func spawn_at(x: int) -> void:
	spawn_delay_timer.start()
	position = Vector2(x, GROUND_Y)

func _on_spawn_delay_timeout() -> void:
	var new_eyeball: EyeballBat = EYEBALL.instantiate()
	new_eyeball.position = position
	new_eyeball.hover_height = randf_range(20, 150)
	
	get_parent().add_child(new_eyeball)
	
	hide()
	queue_free()
