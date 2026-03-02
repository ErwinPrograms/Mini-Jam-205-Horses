class_name GameUI
extends Control

# not ideal place to store score but im on a time crunch
var score: int = 0

@onready var health_display_container: HealthDisplayContainer = $MarginContainer/HealthDisplayContainer
@onready var score_label: Label = $MarginContainer/ScoreLabel

func _ready() -> void:
	SignalHub.point_scored.connect(on_point_scored)
	SignalHub.game_over.connect(on_game_over)

func get_health_display() -> HealthDisplayContainer:
	return health_display_container

func on_point_scored() -> void:
	score += 1
	score_label.text = "%03d" % score

func on_game_over() -> void:
	ScoreManager.high_score = score
