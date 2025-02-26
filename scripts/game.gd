extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#load save
	var file = FileAccess.open("res://saved_game.dat", FileAccess.READ)
	#$event_manager.level = file.get_32()
	$event_manager.mask = 0b010111010
	$event_manager.level = file.get_32()
	$event_manager.reload_level()
	print_debug()
	file.close()
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
