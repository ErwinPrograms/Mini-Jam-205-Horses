extends Control


func _ready() -> void:
	SignalHub.game_over.connect(on_game_over)

func on_game_over() -> void:
	show()
