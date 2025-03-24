extends BaseState

@onready var ani_player:AnimationPlayer = $"../../AnimationPlayer"
@onready var ani_sprite2d:=$"../../AnimatedSprite2D"
@onready var body2d:CharacterBody2D=$"../.."
@onready var a1:Area2D = $"../../AttackCheck/A1"
@onready var a2_behind:Area2D = $"../../AttackCheck/A2Behind"
@onready var a2_front:Area2D = $"../../AttackCheck/A2Front"

func enter():
	ani_player.play("run")
	
func do(delta: float):
	if not body2d.is_on_floor():
		body2d.velocity += body2d.get_gravity() * delta
	else:
		if !is_instance_valid($"../../FrontDownCast".get_collider()):
			body2d.change_direct()
	
	var overlapping_bodies :Array = a1.get_overlapping_bodies()	
	if not overlapping_bodies.is_empty():
		for body in overlapping_bodies:
			if body.is_in_group("player"):
				get_parent().change_state("Attack")
				return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	body2d.velocity.x = body2d.direct.x*body2d.SPEED
	
	body2d.move_and_slide()
	
func exit():
	ani_player.stop()
	ani_sprite2d.stop()
