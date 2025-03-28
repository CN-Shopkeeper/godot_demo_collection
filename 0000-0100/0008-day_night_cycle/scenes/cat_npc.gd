extends CharacterBody2D

func wake_up():
	$AnimatedSprite2D.play("wake_up")
	
func sleep():
	$AnimatedSprite2D.play("sleep")
