extends Node


func _on_start_game_start() -> void:
	var game_sce = preload("res://demo_projects/0001-moon_graveyard_platform_jump/scene/game/map/map.tscn").instantiate()
	game_sce.connect("victory",Callable($Start,"victory"))
	game_sce.connect("failed",Callable($Start,"failed"))
	add_child(game_sce)
	
