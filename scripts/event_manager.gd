extends Node

@export var mask: int

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = hash("seed");
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cell_grid_pressed(id: int) -> void:
	$cell_grid.update_nodes(mask, id)
	print_debug(generate_next_level(6,0,1,7))
	#check completion condition
	

func are_all_set() -> bool:
	var nodes = $cell_grid.get_all_nodes()
	for nd in nodes:
		if nodes[nd].getState() == 0: 
			return false
	return true

func generate_next_level(size:int, mask:int, level:int, steps:int) -> Array:
	var result = Array([], TYPE_INT, "",null)
	var pool = Array([], TYPE_INT, "",null)
	
	for i in size*size:
		pool.append(i)
	
	rng.seed = hash(size*mask*level*100)
	
	for i in steps:
		var val = rng.randi();
		print_debug(val)
		print_debug(pool[val%pool.size()])
		result.append(
			pool.pop_at(val%pool.size()))
	
	return result
