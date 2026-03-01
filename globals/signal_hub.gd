extends Node

signal game_over()

func emit_game_over() -> void:
	game_over.emit()
