extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Timer.is_stopped():
		#if $LeftEnemy/CollisionShape2D.disabled:
		$LeftEnemy/CollisionShape2D.set_deferred("disabled",!$LeftEnemy/CollisionShape2D.disabled)
		$RightEnemy/CollisionShape2D.set_deferred("disabled",!$RightEnemy/CollisionShape2D.disabled)
		
		$Timer.start(5)
	pass
