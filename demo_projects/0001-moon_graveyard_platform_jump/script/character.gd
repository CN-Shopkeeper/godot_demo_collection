class_name Character
extends CharacterBody2D

@export var health=100
signal death

var direct:Vector2 = Vector2.RIGHT

func take_hit(value:int):
	if health<=0:
		pass
	else:
		health -= value
		$FSM.change_state("TakeHit")
	
func change_direct():
	if direct == Vector2.RIGHT:
		direct = Vector2.LEFT
	else:
		direct = Vector2.RIGHT
	scale.x*=-1
