extends Control
const CARD = preload("res://demo_projects/0002-balatro_card_effects/scenes/card.tscn")

@export var from: Control
@export var to: Control
@export var card_offset_x:float = 40.0
@export var rot_max: float=10
var tween:Tween
var is_drawn:bool=false

var deck := []

func _ready() -> void:
	rot_max=deg_to_rad(rot_max)
	
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	for suit in suits:
			for rank in ranks:
				deck.append(suit + "_" + rank)
	deck.shuffle()
				
func drawn_cards(from_position:Vector2,number:int)->void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	var draw_number:int = min(number,deck.size())
	for i in draw_number:
		var instance = _draw_one_card()
		if not instance:
			break
		add_child(instance)
		instance.global_position=from_position
		
		var final_pos : Vector2 = -(instance.size/2)-Vector2(card_offset_x*(number-1-i),0.0)
		final_pos.x+=(card_offset_x*(number-1))/2.0
		var rot_radians:float = lerp(-rot_max,rot_max,float(i)/float(number-1))
		tween.parallel().tween_property(instance,"position",final_pos,0.3+(i*0.075))
		tween.parallel().tween_property(instance,"rotation",rot_radians,0.3+(i*0.075))
		

func undrawn_cards(to_position:Vector2)->void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
	var drawn_cards_list= get_children()
	
	var order=drawn_cards_list.size()
	for card in drawn_cards_list:
		tween.parallel().tween_property(card,"global_position",to_position,0.3+((order-1)*0.075))
		tween.parallel().tween_property(card,"rotation",0,0.3+((order-1)*0.075))

		

func _draw_one_card()->Node:
	if deck.size() > 0:
		var card_name=deck.pop_front()
		var card_path = "res://demo_projects/0002-balatro_card_effects/assets/Cards/cut_off/%s.png" % card_name
		var texture = load(card_path)
		
		var card_instance = CARD.instantiate()
		var texture_rect =card_instance.get_node("CardTexture")
		if texture_rect:
			texture_rect.texture = texture
#			防止阴影相互遮挡卡面
			texture_rect.z_index=1
		return card_instance
	return null  # 如果牌堆为空，返回 null

func _on_button_draw_pressed() -> void:
	if is_drawn:
		undrawn_cards(to.global_position)
	else:
		drawn_cards(from.global_position,10)
	is_drawn=!is_drawn
