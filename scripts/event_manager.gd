extends Node

@export var mask: int

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level = generate_next_level(6,170,1,5)
	
	var id = 0
	var id_list = []
	var test
	
	#check node state
	
	#if node active	
	for r in 3:
		for c in 3:
			test = mask >> (c + r * 3)
			if test & 1 :
				if id >= 0 && id < rows*columns && id / columns == (id -1 + c) / columns:
					if (id -1 + c) >= 0:
						id_list.append(id -1 + c)
		id += rows
	
	#print_debug(id_list)
	for nid in id_list:
		nodes[nid].changeState()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cell_grid_pressed(id: int) -> void:
	$cell_grid.update_nodes(mask, id)
	print_debug(generate_next_level(6,0,1,7))
	$cell_grid.get_all_nodes()[9].makeInactive()
	#check completion condition
	

func are_all_set() -> bool:
	var nodes = $cell_grid.get_all_nodes()
	for nd in nodes:
		if nodes[nd].getState() == 0 && nodes[nd].isActive(): 
			return false
	return true

func generate_next_level(size:int, mask:int, level:int, steps:int) -> Array[int]:
	var result = Array([], TYPE_INT, "",null)
	var pool = Array([], TYPE_INT, "",null)
	
	for i in size*size:
		pool.append(i)
	
	rng.seed = hash(size*mask*level*100)
	
	for i in steps:
		var val = rng.randi();
		result.append(
			pool.pop_at(val%pool.size()))
	
	return result
	
func init_grid(size:int, level_seed: Array[int]) -> void:
	pass
