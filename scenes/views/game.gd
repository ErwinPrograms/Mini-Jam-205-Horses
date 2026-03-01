extends Node2D

@onready var horse_player: HorsePlayer = $HorsePlayer
@onready var launch_cursor: LaunchCursor = $ControllerNodes/LaunchCursor
@onready var game_ui: GameUI = $UICanvas/GameUI

func _ready() -> void:
	horse_player.connect_to_cursor(launch_cursor)
	SignalHub.game_over.connect(on_game_over)
	
	horse_player.took_damage.connect(
		func():
			game_ui.get_health_display().set_fill(
				horse_player._remaining_health
			)
	)

func on_game_over() -> void:
	get_tree().paused = true
