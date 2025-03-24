extends StateManager

func _ready() -> void:
	
	current = $Idle
	print(current)
	super._ready()
