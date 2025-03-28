extends Control

@onready var resolution_option_button: OptionButton = $Panel/HBoxContainer/VBoxContainer/OptionButton

func add_resolutions():
	for r in GUI.resolutions:
		resolution_option_button.add_item(r)

func update_button_values():
	var windows_size_str = str(get_window().size.x,"x",get_window().size.y)
	print(windows_size_str)
	var resolution_index = GUI.resolutions.keys().find(windows_size_str)
	print(resolution_index)
	resolution_option_button.selected = resolution_index

func _ready() -> void:
	add_resolutions()


func _on_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	# method in the video
	#get_window().set_size(GUI.resolutions[key])
	
	# Embedded windows need to be disabled to run in the editor
	DisplayServer.window_set_size(GUI.resolutions[key])
	GUI.center_window()
