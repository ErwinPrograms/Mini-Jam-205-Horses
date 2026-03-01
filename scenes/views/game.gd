extends Node2D

@onready var horse_player: HorsePlayer = $HorsePlayer
@onready var launch_cursor: LaunchCursor = $ControllerNodes/LaunchCursor

func _ready() -> void:
	horse_player.connect_to_cursor(launch_cursor)
	SignalHub.game_over.connect(on_game_over)

func on_game_over() -> void:
	get_tree().paused = true
