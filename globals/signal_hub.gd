extends Node

signal game_over()
signal point_scored()

func emit_game_over() -> void:
	game_over.emit()

func emit_point_scored() -> void:
	point_scored.emit()
