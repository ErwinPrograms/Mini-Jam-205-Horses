class_name GameUI
extends Control

@onready var health_display_container: HealthDisplayContainer = $MarginContainer/HealthDisplayContainer


func _ready() -> void:
	pass

func get_health_display() -> HealthDisplayContainer:
	return health_display_container
