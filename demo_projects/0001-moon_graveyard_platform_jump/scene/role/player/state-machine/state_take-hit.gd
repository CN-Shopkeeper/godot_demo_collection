extends BaseState

@onready var body2d:CharacterBody2D = $"../.."
@onready var ani_sprite2d :AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player:=$"../../AnimationPlayer"
@onready var ap_jump :AudioStreamPlayer2D =$"../../Audio/Jump"
@onready var ap_take_hit :AudioStreamPlayer2D =$"../../Audio/TakeHit"
@onready var ap_attack :AudioStreamPlayer2D =$"../../Audio/Attack"


func enter():
	if body2d.health>0:
		ap_take_hit.play()
		ani_sprite2d.play("take_hit")
	else:
		ani_sprite2d.play("death")

func exit():
	ani_player.stop()
	ani_sprite2d.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation =="take_hit":
		get_parent().change_state("Idle")
	if ani_sprite2d.animation =="death":
		await get_tree().create_timer(3).timeout
		body2d.emit_signal("death")
	
