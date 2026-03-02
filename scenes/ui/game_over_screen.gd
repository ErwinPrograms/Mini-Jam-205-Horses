extends Control

func _ready() -> void:
	SignalHub.game_over.connect(on_game_over)

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		ViewManager.load_main_menu()

func on_game_over() -> void:
	show()
	
	await get_tree().create_timer(.5).timeout
	mouse_filter = Control.MOUSE_FILTER_PASS
