extends Control

@onready var card_texture: TextureRect = $CardTexture
@onready var shadow: TextureRect = $Shadow

@export var angle_x_max:float =15.0
@export var angle_y_max:float =15.0
@export var max_offset_shadow:float=50.0

var is_following_mouse:bool=false

var tween_rot:Tween
var tween_hover:Tween
var tween_destroy:Tween

func _ready() -> void:
	angle_x_max=deg_to_rad(angle_x_max)
	angle_y_max=deg_to_rad(angle_y_max)

func _process(delta: float) -> void:
	_handle_shadow(delta)
	_follow_mouse(delta)

# 销毁
func destroy()->void:
	card_texture.use_parent_material=true
	if tween_destroy and tween_destroy.is_running():
		tween_destroy.kill()
		
	tween_destroy=create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_destroy.tween_property(material,"shader_parameter/dissolve_value",0.0,2.0).from(1.0)
	tween_destroy.parallel().tween_property(shadow,"self_modulate:a",0.0,1.0)
	await tween_destroy.finished
	queue_free()
	
func _handle_shadow(delta:float)->void:
	var center: Vector2 = get_viewport_rect().size/2.0
	var distance:float = global_position.x-center.x
	
	shadow.position.x = lerp(0.0,max_offset_shadow*sign(distance),abs(distance/center.x))
	
func _follow_mouse(delta:float)->void:
	if not is_following_mouse: return
	global_position = get_global_mouse_position()-size/2

func _handle_mouse_click(event: InputEvent)->void:
	if not event is InputEventMouseButton:return
	if event.button_index!=MOUSE_BUTTON_LEFT:return
	
	if event.is_pressed():
		is_following_mouse=true
	else:
		is_following_mouse=false

func _on_gui_input(event: InputEvent) -> void:
	_handle_mouse_click(event)
	if is_following_mouse: return
	if not event is InputEventMouseMotion: return
	var mouse_pos :Vector2 =get_local_mouse_position()
	var lerp_val_x:float = remap(mouse_pos.x,0.0,size.x,0,1)
	var lerp_val_y:float = remap(mouse_pos.y,0.0,size.y,0,1)
	
	var rot_x :float= rad_to_deg(lerp_angle(-angle_x_max,angle_x_max,lerp_val_x))
	var rot_y :float= rad_to_deg(lerp_angle(-angle_y_max,angle_y_max,lerp_val_y)) 
	
	card_texture.material.set_shader_parameter("x_rot",rot_x)
	card_texture.material.set_shader_parameter("y_rot",rot_y)
	

func _on_mouse_exited() -> void:
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot=create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(card_texture.material,"shader_parameter/x_rot",0.0,0.5)
	tween_rot.tween_property(card_texture.material,"shader_parameter/y_rot",0.0,0.5)
	#card_texture.material.set_shader_parameter("x_rot",0)
	#card_texture.material.set_shader_parameter("y_rot",0)
	
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover=create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self,"scale",Vector2.ONE,0.5)

func _on_mouse_entered() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover=create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self,"scale",Vector2(1.2,1.2),0.5)
