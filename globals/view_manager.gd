extends Node

const MAIN = preload("uid://dyryae66s6fme")
const GAME = preload("uid://bq0khrtdtveh8")
const FADE_TRANSITION = preload("uid://cfvdwx0enwmh1")

var fade_scene: FadeTransition
var next_scene: PackedScene

func _ready() -> void:
	fade_scene = FADE_TRANSITION.instantiate()
	add_child(fade_scene)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		load_main_menu()

func load_main_menu() -> void:
	fade_to_scene(MAIN)
	
func load_game() -> void:
	get_tree().paused = false
	fade_to_scene(GAME)

func fade_to_scene(to_scene: PackedScene) -> void:
	next_scene = to_scene
	fade_scene.play_animation()

func to_next_scene() -> void:
	if next_scene:
		var music_position: float = get_tree().current_scene.get_music_position()
		
		get_tree().change_scene_to_packed(next_scene)
		
		#get_tree().current_scene.set_music_position(music_position)
		
		next_scene = null
