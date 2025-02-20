extends Node

@export var id: int

signal pressed(id: int)

var state = 0
var active = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale = get_viewport().get_visible_rect().size.x / get_viewport().size.x
	$AnimatedSprite2D/TouchScreenButton.scale = Vector2(scale, scale)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass
	#if event is InputEventScreenTouch :
		#if event.pressed :
			
			#if event.position > position && event position < 
			
		


func _on_touch_screen_button_pressed() -> void:
	pressed.emit(id)
	
func setId(id_value: int) -> void:
	id = id_value

func getId() -> int:
	return id
	
func getState() -> int:
	return state

func changeState() -> void:

	state = (state + 1) & 1
	$AnimatedSprite2D.frame = state

func setState(st:int) -> void:
	state = st
	$AnimatedSprite2D.frame = state
	
func makeActive() -> void:
	active = true
	
func makeInactive()  -> void:
	active = false	

func isActive() -> bool:
	return active
