extends Control

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var score_label: Label = $MarginContainer/HighScoreContainer/ScoreLabel

func _ready() -> void:
	score_label.text = "%03d" % ScoreManager.high_score

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		ViewManager.load_game()

func set_music_position(from_postion: float) -> void:
	music_player.stop()
	music_player.play(from_postion)

func get_music_position() -> float:
	return music_player.get_playback_position()
