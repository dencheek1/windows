extends Node

@export var mask: int
@export var level:int = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var solution = generate_level(6,mask,level,7)
	var nodes = $cell_grid.get_all_nodes()
	print_debug(solution)
	prepare_field(mask,solution,nodes,6)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cell_grid_pressed(id: int) -> void:
	print_debug(id)
	$cell_grid.update_nodes(mask, id)
	if are_all_set():
		level += 1 
		var solution = generate_level(6,mask,level,12)
		var nodes = $cell_grid.get_all_nodes()
		print_debug(solution)
		prepare_field(mask,solution,nodes,6)

#asume field is square
func prepare_field(mask:int, solution: Array[int], nodes:Dictionary, size: int) -> void:
	var test
	var size_2 = size*size
	
	for id in nodes:
		nodes[id].makeInactive()
		nodes[id].setState(1)
	
	for sid in solution:
		nodes[sid].makeActive()
		#nodes[sid].changeState()
		# id is a center of the mask
		var id = sid + size
		for r in 3:
			for c in 3:
				test = mask >> (c + r * 3)
				if test & 1 == 1:
					if id >= 0 && id < size_2 && id / size == (id + 1 - c) / size:
						if (id + 1 - c) >= 0:
							nodes[id + 1 - c].makeActive()
							nodes[id + 1 - c].changeState()
			id -= size

	
	#print_debug(id_list)
	#for nid in id_list:
		#nodes[nid].changeState()

func are_all_set() -> bool:
	var nodes = $cell_grid.get_all_nodes()
	for nd in nodes:
		if nodes[nd].getState() == 0 && nodes[nd].isActive(): 
			return false
	return true

func generate_level(size:int, mask:int, level:int, steps:int) -> Array[int]:
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
