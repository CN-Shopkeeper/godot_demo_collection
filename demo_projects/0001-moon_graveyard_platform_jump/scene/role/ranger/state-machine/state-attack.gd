extends BaseState

@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:=$"../.."
@onready var front_down_cast :=$"../../FrontDownCast"
@onready var front_attack_check: =$"../../FrontAttackCheck"
@onready var behind_attack_check: = $"../../BehindAttackCheck"
@onready var front_arrow:=$"../../FrontArrow"

func enter():	
	ani_sprite2d.play("2_atk")
		
	
func do(delta:float):
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "2_atk":
		get_parent().change_state("Run")



func _on_animated_sprite_2d_frame_changed() -> void:
	if not ani_sprite2d:
		return
	if ani_sprite2d.animation=="2_atk" and ani_sprite2d.frame == 8:
		var sce = preload("res://demo_projects/0001-moon_graveyard_platform_jump/scene/role/ranger/arrow.tscn").instantiate()
		sce.position = front_arrow.global_position
		sce.vec_x = body2d.direct.x
		body2d.get_parent().add_child(sce)
