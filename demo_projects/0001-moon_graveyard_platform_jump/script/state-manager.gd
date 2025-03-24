class_name StateManager
extends Node

var states_array : Array=[]

@onready var current:BaseState = $Run

func _ready() -> void:
	states_array = get_children()
	current.enter()

func _physics_process(delta: float) -> void:
	current.do(delta)

"""
Idle
Run
Attack
Jump
Fall
TakeHit
"""
func change_state(state_name:String)-> void:

	current.exit()
	current = get_node(state_name)
	current.enter()
