class_name FadeTransition
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_animation() -> void:
	animation_player.play("fade")

func switch_scene() -> void:
	get_tree().paused = false
	ViewManager.to_next_scene()
