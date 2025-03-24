extends BaseState

@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"

func enter():
	ani_sprite2d.play("death")

func do(delta:float):
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	
