extends Node

const SCORES_PATH: String = "user://charger_score.tres"

var high_score: int = 0:
	get:
		return high_score
	set(value):
		if value > high_score:
			high_score = value
			save_high_score()

func _ready() -> void:
	load_high_score()

func load_high_score() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		var hsr: HighScoreResource = load(SCORES_PATH)
		high_score = hsr.high_score

func save_high_score() -> void:
	var hsr: HighScoreResource = HighScoreResource.new(high_score)
	ResourceSaver.save(hsr, SCORES_PATH)
