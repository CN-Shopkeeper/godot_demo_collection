extends Node2D

const SPEED = 500

func _process(delta: float) -> void:
	var axis = Input.get_axis("LEFT","RIGHT")
	position.x+=axis*SPEED *delta
