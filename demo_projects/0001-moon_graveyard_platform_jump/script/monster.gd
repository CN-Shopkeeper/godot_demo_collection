class_name Monster
extends Character

func _ready() -> void:
	health=100
	direct = Vector2.RIGHT
	add_to_group("monster")

func take_hit(value:int):
	super.take_hit(value)
	print("monster take hit")
	
func change_direct():
	if direct == Vector2.RIGHT:
		direct = Vector2.LEFT
	else:
		direct = Vector2.RIGHT
	scale.x*=-1
