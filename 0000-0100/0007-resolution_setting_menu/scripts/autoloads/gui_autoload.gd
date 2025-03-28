extends CanvasLayer

var gui_components=[
	"res://0000-0100/0007-resolution_setting_menu/scenes/gui_components/settings_menu.tscn"
]
var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600,900),
	"1152x648": Vector2i(1152,648),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600)
}

func center_window():
	var screen_center = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var windows_size = DisplayServer.window_get_size_with_decorations()
	DisplayServer.window_set_position(screen_center-windows_size/2)

func _ready() -> void:
	var last_key = resolutions.keys()[-1]
	DisplayServer.window_set_min_size(resolutions[last_key])
	for i in gui_components:
		var new_scene = load(i).instantiate()
		add_child(new_scene)
		new_scene.hide()
		
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_settings"):
		var settings_menu = get_node("SettingsMenu")
		settings_menu.visible=!settings_menu.visible
		if settings_menu.visible:
			settings_menu.update_button_values()
		
