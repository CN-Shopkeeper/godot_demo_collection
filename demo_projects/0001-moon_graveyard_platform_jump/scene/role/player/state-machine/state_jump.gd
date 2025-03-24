extends BaseState

@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"


var jumping:bool = false



func enter():
	ani_sprite2d.play("jump")
	await ani_sprite2d.animation_finished
	if ani_sprite2d.animation == "jump":
		ap_jump.play()
		ani_sprite2d.play("smrslt")
		jumping = true
		body2d.velocity.y = body2d.JUMP_SPEED
		
func do(delta:float):
	var direction := Input.get_axis("platform_jump_2d_left", "platform_jump_2d_right")
	
	#
	if jumping:
		if body2d.velocity.y>0:
			get_parent().change_state("Fall")
			return
		body2d.check_direct(direction)
		body2d.velocity.x = direction*body2d.SPEED_ON_JUMP
		body2d.velocity +=delta*body2d.get_gravity()
		body2d.move_and_slide()
	
func exit():
	body2d.velocity.y = 0
	jumping=false
	ani_player.stop()
	ani_sprite2d.stop()
