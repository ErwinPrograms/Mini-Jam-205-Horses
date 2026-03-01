class_name UIHeart
extends TextureRect

const HEART_FULL = preload("uid://n3km3x4awsyt")
const HEART_EMPTY = preload("uid://gycjj2cklvqy")

var filled: bool = true:
	set(value):
		fill_texture() if value else empty_texture()
		filled = value

func fill_texture() -> void:
	texture = HEART_FULL

func empty_texture() -> void:
	texture = HEART_EMPTY
