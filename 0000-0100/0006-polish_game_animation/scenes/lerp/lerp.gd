extends Node2D

const SPEED = 4.0

@onready var sprite := $Sprite2D
var intended_position:Vector2 = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	intended_position= get_local_mouse_position()
	sprite.position = sprite.position.lerp(intended_position,delta*SPEED)
	pass
