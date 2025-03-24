extends Node2D

signal victory
signal failed
var monster_count = 0

func _ready() -> void:
	for m in get_tree().get_nodes_in_group("monster"):
		monster_count += 1
		m.connect("death",Callable (self, "_on_monster_death"))
	$Polygon2D.visible=false
	$Polygon2D/Area2D.monitoring=false
	
func _on_monster_death():
	monster_count -= 1
	print("怪物死亡，剩余怪物：", monster_count)
	if monster_count <= 0:
		print("所有怪物被清除！")
		$Polygon2D.visible=true
		$Polygon2D/Area2D.monitoring=true
		
		
		

func _on_player_death() -> void:
	emit_signal("failed")
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("victory")
		queue_free()


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("failed")
		queue_free()
