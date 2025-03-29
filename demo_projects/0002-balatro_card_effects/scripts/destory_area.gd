extends MarginContainer


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().destroy()
