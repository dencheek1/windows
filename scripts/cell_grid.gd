extends Node2D

@export var scene: PackedScene
@export var rows: int
@export var columns: int
@export var gap: int

signal pressed(id: int)

var nodes : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init() -> void:
	
	var pos = $".".position
	
	for x in columns :
		for y in rows:
				var node = scene.instantiate()
				node.id = x + y*rows
				#node.setId(x*columns + y)
				node.position = pos + Vector2(gap*x, gap*y)
				node.connect("pressed", _on_node_pressed)
				add_child(node)
				nodes[node.getId()] = node

func _on_node_pressed(id: int) -> void:
	pressed.emit(id)
	
	
func update_nodes(mask:int, center_id:int) -> void:
	var id = center_id + rows
	var id_list = []
	var test
	
	#check node state
	
	#if node active	
	if nodes[center_id].isActive:
		for r in 3:
			for c in 3:
				test = mask >> (c + r * 3)
				if test & 1 :
					if id >= 0 && id < rows*columns && id / columns == (id + 1 - c) / columns:
						if (id + 1 - c) >= 0:
							id_list.append(id + 1 - c)
			id -= rows
	
	#print_debug(id_list)
	for nid in id_list:
		nodes[nid].changeState()
	

func get_all_nodes() -> Dictionary:
	return nodes
