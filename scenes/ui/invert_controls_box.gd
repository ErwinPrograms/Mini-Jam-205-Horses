extends CheckBox



func _on_toggled(toggled_on: bool) -> void:
	SettingsManager.invert_controls = toggled_on
