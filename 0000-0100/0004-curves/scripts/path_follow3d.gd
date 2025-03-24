@tool
extends PathFollow3D

@export var process:bool = false
@export var factor : int = 50

func _process(delta: float) -> void:
	if process:
		progress+=delta*factor
