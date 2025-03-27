extends Node2D

@onready var sprite: = $Sprite2D
@onready var points :Array=$Points.get_children()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var  time = $HSlider.value
	sprite.position = cubic_bezier(points[0].position,points[1].position,
									points[2].position,points[3].position,time)

func cubic_bezier(p0:Vector2,p1:Vector2,p2:Vector2,p3:Vector2,t:float):
	var q0 = p0.lerp(p1,t)
	var q1 = p1.lerp(p2,t)
	var q2 = p2.lerp(p3,t)
	
	var r0 = q0.lerp(q1,t)
	var r1 = q1.lerp(q2,t)
	
	var s = r0.lerp(r1,t)
	
	return s
	
