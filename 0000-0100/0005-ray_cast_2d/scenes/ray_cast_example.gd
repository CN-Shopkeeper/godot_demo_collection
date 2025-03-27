extends Node2D

@onready var ray_cast_2d :=$RayCast2D
@onready var label :=  $Label
@onready var line_2d=$Line2D

func _ready() -> void:
	line_2d.points.clear()
	line_2d.show()
	line_2d.add_point(ray_cast_2d.position)
	line_2d.add_point(ray_cast_2d.target_position)
	
func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		var col_point = ray_cast_2d.get_collision_point()
		var local_col_point = to_local(col_point)
		label.text = "collider: %s\nglobal_point: %s\nlocal_point: %s"%[collider,col_point,local_col_point]
		line_2d.default_color=Color.RED
	else :
		label.text=""
		line_2d.default_color=Color.GREEN
