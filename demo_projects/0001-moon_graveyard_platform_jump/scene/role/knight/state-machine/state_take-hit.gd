extends BaseState

@onready var ani_player:AnimationPlayer = $"../../AnimationPlayer"
@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:CharacterBody2D=$"../.."
@onready var a1:Area2D = $"../../AttackCheck/A1"
@onready var a2_behind:Area2D = $"../../AttackCheck/A2Behind"
@onready var a2_front:Area2D = $"../../AttackCheck/A2Front"

func enter():
	#ap_take_hit.play()
	if body2d.health>0:
		ani_sprite2d.play("take_hit")
	else:
		ani_sprite2d.play("death")

func exit():
	ani_player.stop()
	ani_sprite2d.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation =="take_hit":
		get_parent().change_state("Run")
	if ani_sprite2d.animation =="death":
		body2d.emit_signal("death")
		body2d.queue_free()
