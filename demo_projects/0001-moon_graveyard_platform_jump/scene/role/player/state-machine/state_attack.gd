extends BaseState
@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"

@onready var a1 := $"../../AttackCheck/Attack1"
@onready var a2 := $"../../AttackCheck/Attack2"
@onready var a3 := $"../../AttackCheck/Attack3"

var attack_index:int = 0



func enter():
	$Timer.stop()
	if attack_index ==0:
		ani_player.play("attack1")
	elif attack_index==1:
		ani_player.play("attack2")
	else :
		ani_player.play("attack3")
		
func do(delta:float):
	pass
	
func exit():
	ani_player.stop()
	ani_sprite2d.stop()
	
	
	
func attack_check():
	var overlapping_bodies:Array[Node2D] = []
	
	if attack_index ==0:
		overlapping_bodies=a1.get_overlapping_bodies()
	elif attack_index ==1:
		overlapping_bodies=a2.get_overlapping_bodies()
	else:
		overlapping_bodies=a3.get_overlapping_bodies()
	
	for i in overlapping_bodies:
		if i.is_in_group("monster"):
			i.take_hit(20)


func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation.left(6) =="attack":
		attack_index +=1
		attack_index%=3 
		$Timer.start(0.25)
		get_parent().change_state("Idle")


func _on_timer_timeout() -> void:
	attack_index=0
