class_name EnemySpawnManager
extends Node2D

const EYEBALL_SPAWNER = preload("uid://oo6rmo4aparu")

var num_spawned_waves: int = 0

func _ready() -> void:
	pass

func _on_spawn_wave_timer_timeout() -> void:
	# spawn new wave
	var amount: int = num_spawned_waves / 5 + 1
	for _i in range(amount):
		var new_spawner: EyeballSpawner = EYEBALL_SPAWNER.instantiate()
		get_parent().add_child(new_spawner)
		new_spawner.spawn_at(randf_range(20, 300))
	
	# increment num spawned waves
	num_spawned_waves += 1
