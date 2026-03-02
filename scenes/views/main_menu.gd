extends Control

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var score_label: Label = $MarginContainer/HighScoreContainer/ScoreLabel

func _ready() -> void:
	score_label.text = "%03d" % ScoreManager.high_score

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		ViewManager.load_game()
