class_name HealthDisplayContainer
extends FlowContainer

const UI_HEART = preload("uid://b2368r0ewr55n")


@export var total_hearts: int = 3
@export var filled_hearts: int = total_hearts:
	set(value):
		set_fill(value)
		filled_hearts = value

var hearts: Array[UIHeart] = []

func _ready() -> void:
	for i in range(total_hearts):
		var new_heart = UI_HEART.instantiate()
		add_child(new_heart)
		hearts.append(new_heart)

func set_fill(health: int) -> void:
	if !hearts:
		return
	
	for i in range(0, health):
		hearts[i].fill_texture()
	for i in range(health, total_hearts):
		hearts[i].empty_texture()
