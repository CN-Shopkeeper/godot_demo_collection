class_name Player
extends Character

@onready var healthPB : =$CanvasLayer/TextureProgressBar
const SPEED_ON_FLOOR = 400
const SPEED_ON_JUMP =200
const SPEED_ON_FALL =200
const JUMP_SPEED = -500


func _ready() -> void:
	self.add_to_group("player")
	healthPB.max_value=health
	
	
func take_hit (value:int):
	super.take_hit(value)
	print("player take hit")
	healthPB.value=health
	
func check_direct(input_x_direction):
	if 0==input_x_direction:
		# keep the same x direction
		return
	
	var new_dir = Vector2.RIGHT if input_x_direction>0 else Vector2.LEFT
	
	if new_dir!=direct:
		change_direct()
