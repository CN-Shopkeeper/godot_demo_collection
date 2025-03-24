extends BaseState

@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"

func enter():
	ani_sprite2d.play("run")


func do(delta:float):
	var direction := Input.get_axis("platform_jump_2d_left", "platform_jump_2d_right")
	
	if not body2d.is_on_floor():
		get_parent().change_state("Fall")
		return
	elif direction==0:
		get_parent().change_state("Idle")
		return
	elif Input.is_action_just_pressed("platform_jump_2d_jump") and body2d.is_on_floor():
		#velocity.y = JUMP_VELOCITY
		get_parent().change_state("Jump")
		return
	elif Input.is_action_just_pressed("platform_jump_2d_attack1"):
		get_parent().change_state("Attack")
		return
		
	
	body2d.check_direct(direction)	
	body2d.velocity.x = direction*body2d.SPEED_ON_FLOOR
	#player.velocity.y = 1  
	body2d.move_and_slide()
	
	#player.velocity =Vector2(0,1)
	#player.move_and_slide()
	
func exit():
	ani_player.stop()
	ani_sprite2d.stop()	
