extends Node2D

@onready var horse_player: HorsePlayer = $HorsePlayer
@onready var launch_cursor: LaunchCursor = $ControllerNodes/LaunchCursor
@onready var game_ui: GameUI = $UICanvas/GameUI
@onready var music_player: AudioStreamPlayer = $MusicPlayer

func _ready() -> void:
	horse_player.connect_to_cursor(launch_cursor)
	SignalHub.game_over.connect(on_game_over)
	
	horse_player.took_damage.connect(
		func():
			game_ui.get_health_display().set_fill(
				horse_player._remaining_health
			)
	)

func set_music_position(from_postion: float) -> void:
	music_player.stop()
	music_player.play(from_postion)

func get_music_position() -> float:
	return music_player.get_playback_position()

func on_game_over() -> void:
	get_tree().paused = true
