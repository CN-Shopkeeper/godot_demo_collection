extends BaseState

@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:=$"../.."
@onready var front_down_cast :=$"../../FrontDownCast"
@onready var front_attack_check: =$"../../FrontAttackCheck"
@onready var behind_attack_check: = $"../../BehindAttackCheck"
@onready var front_arrow:=$"../../FrontArrow"

func enter():
	ani_sprite2d.play("run")

func do(delta: float):
	if not body2d.is_on_floor():
		body2d.velocity += body2d.get_gravity() * delta
	else:
		if !is_instance_valid(front_down_cast.get_collider()):
			body2d.change_direct()
	

	if front_attack_check.is_colliding():
		var collider = front_attack_check.get_collider()
		if collider and collider.is_in_group("player"):
			get_parent().change_state("Attack")
			return		
	
	if behind_attack_check.is_colliding():
		var collider = behind_attack_check.get_collider()
		if collider and collider.is_in_group("player"):
			get_parent().change_state("Attack")
			body2d.change_direct()
			return		
	

	body2d.velocity.x = body2d.direct.x*body2d.SPEED
	
	body2d.move_and_slide()
	
