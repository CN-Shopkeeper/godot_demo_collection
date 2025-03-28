extends Node2D

const DAYS=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturda","Sunday"]
const PATH = "user://0008-day_night_cycle_scene.cfg"

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var day_counter = 0:
	set(value):
		day_counter = value
		%Day.text = "Day "+str(day_counter)
		%DayOfWeek.text=DAYS[day_counter%7]

func _ready() -> void:
	load_data()

func _physics_process(delta: float) -> void:
	var current_time  = animation_player.current_animation_position
	var total_time = animation_player.current_animation_length
	
	var minute_passed = (current_time/total_time)*(24*60)
	%Minute.text = str(int(minute_passed)%60)
	%Hour.text = str(int(minute_passed)/60)
	
func next_day():
	day_counter+=1	
	
func lights(value=true):
	get_tree().call_group("LightSource","enable",value)
	
	if value ==false:
		get_tree().call_group("NPC","wake_up")
	else :
		get_tree().call_group("NPC","sleep")

func load_data():
	var config = ConfigFile.new()
	if config.load(PATH)!=OK:
		save_data()
		return
	#day_counter = config.get_value("Scene","day_counter")
	#var time = config.get_value("Scene","animation_position")
	#animation_player.advance(time)

func save_data():
	var config = ConfigFile.new()
	var current_time = animation_player.current_animation_position
	
	config.set_value("Scene","day_counter",day_counter)
	config.set_value("Scene","animation_position",current_time)
	
	config.save(PATH)
	


func _on_button_pressed() -> void:
	save_data()
