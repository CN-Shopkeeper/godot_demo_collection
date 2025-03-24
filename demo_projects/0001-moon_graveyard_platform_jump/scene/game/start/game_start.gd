extends TextureRect

signal game_start

@onready var label:=$CenterContainer/VBoxContainer/Label

func victory():
	label.text="Victory"
	show()
	
func failed():
	label.text="Failed"
	show()

func _on_start_pressed() -> void:
	hide()
	emit_signal("game_start")


func _on_exit_pressed() -> void:
	get_tree().quit()
