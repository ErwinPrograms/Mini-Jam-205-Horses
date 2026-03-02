extends Control

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		ViewManager.load_game()

func set_music_position(from_postion: float) -> void:
	music_player.stop()
	music_player.play(from_postion)

func get_music_position() -> float:
	return music_player.get_playback_position()
