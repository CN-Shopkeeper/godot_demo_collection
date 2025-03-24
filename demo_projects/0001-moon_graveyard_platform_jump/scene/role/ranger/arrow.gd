extends Area2D

var vec_x:float =1.0

func _physics_process(delta: float) -> void:
	self.position.x +=10*vec_x
	var bodies =get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			body.take_hit(5)
			queue_free()
			return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if vec_x <0:
		self.scale.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
