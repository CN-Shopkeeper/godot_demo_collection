@tool
extends Node2D

@export var process_x:bool=false
@export var process_y:bool=false
@export var factor:int =10
@export var curve:Curve

var time :float = 0
var dir: int =1

func _process(delta: float) -> void:
	if curve:
		time+=delta*dir
		
		if process_x:
			position.x= curve.sample(time)*factor
		if process_y:
			position.y= curve.sample(time/2)*(factor/2)
		if time>1:dir=-1
		elif time<0:dir=1
		time = clamp(time,0,1)
			
