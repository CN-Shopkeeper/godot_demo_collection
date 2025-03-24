extends BaseState

@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:=$"../.."
@onready var front_down_cast :=$"../../FrontDownCast"
@onready var front_attack_check: =$"../../FrontAttackCheck"
@onready var behind_attack_check: = $"../../BehindAttackCheck"
@onready var front_arrow:=$"../../FrontArrow"

func enter():
	#ap_take_hit.play()
	if body2d.health>0:
		ani_sprite2d.play("take_hit")
	else:
		ani_sprite2d.play("death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation =="take_hit":
		get_parent().change_state("Run")
	if ani_sprite2d.animation =="death":
		body2d.emit_signal("death")
		body2d.queue_free()
