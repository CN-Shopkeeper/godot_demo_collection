extends BaseState

@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"


func enter():
	ani_sprite2d.play("fall")
	
func do (delta:float):
	var direction := Input.get_axis("platform_jump_2d_left", "platform_jump_2d_right")
	
	if body2d.is_on_floor():
		get_parent().change_state("Idle")
		return
	body2d.check_direct(direction)
	body2d.velocity.x = body2d.SPEED_ON_FALL*direction
	body2d.velocity+=delta*body2d.get_gravity()
	body2d.move_and_slide()
func exit():
	ani_player.stop()
	ani_sprite2d.stop()
