extends BaseState

@onready var ani_player:AnimationPlayer = $"../../AnimationPlayer"
@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:CharacterBody2D=$"../.."
@onready var a1:Area2D = $"../../AttackCheck/A1"
@onready var a2_behind:Area2D = $"../../AttackCheck/A2Behind"
@onready var a2_front:Area2D = $"../../AttackCheck/A2Front"

var attack_index:int = 0
func enter():
	$Timer.stop()
	if attack_index ==0:
		ani_player.play("attack_1")
	else:
		ani_player.play("attack_2")
		
	
func do(delta:float):
	pass
	
func exit():
	ani_player.stop()
	ani_sprite2d.stop()
	
func attack1_check():
	var overlapping_bodies=a1.get_overlapping_bodies()
	attack_bodies(overlapping_bodies)

func attack2_behind_check():
	var overlapping_bodies=a2_behind.get_overlapping_bodies()
	attack_bodies(overlapping_bodies)
	
func attack2_front_check():
	var overlapping_bodies=a2_front.get_overlapping_bodies()
	attack_bodies(overlapping_bodies)

func attack_bodies(bodies:Array[Node2D]):
	for body in bodies:
		if body.is_in_group("player"):
			body.take_hit(10)


func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "1_atk"||ani_sprite2d.animation == "2_atk":
		attack_index +=1
		attack_index%=2
		$Timer.start(0.5)
		get_parent().change_state("Run")


func _on_timer_timeout() -> void:
	attack_index=0
