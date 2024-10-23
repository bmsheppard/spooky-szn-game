extends Node2D

@onready var wheel = $wheel
@onready var lever_handle = $lever/lever_handle
@onready var depth_indicators = $"../../UI/depth_indicators"

var ship: Node3D

const MAX_TURN = 0.5
const TURN_RATE = 0.002

const MAX_RISE = 35.
const RISE_RATE = 0.2
const MAX_ELAVATION = 100.
const ELEVATION_UPDATE_INTERVAL = 1 # seconds

var last_elevation_update = 0
var wheel_selected = false
var lever_selected = false


func _ready():
	ship = get_tree().get_first_node_in_group('ship')
	
func _process(delta):
	if wheel_selected and Input.is_action_pressed("left_click"):
		if get_viewport().get_mouse_position().x < wheel.global_position.x:
			wheel.rotate(-0.01)
			wheel.rotation = clamp(wheel.rotation, -1*MAX_TURN, MAX_TURN)
		if get_viewport().get_mouse_position().x > wheel.global_position.x:
			wheel.rotate(0.01)
			wheel.rotation = clamp(wheel.rotation, -1*MAX_TURN, MAX_TURN)
	elif wheel_selected and Input.is_action_just_released("left_click"):
		if wheel.rotation <= 0.1 and wheel.rotation >= -0.1:
			wheel.rotation = 0
	else:
		wheel_selected = false
	
	if lever_selected and Input.is_action_pressed("left_click"):
		if get_viewport().get_mouse_position().y < lever_handle.global_position.y:
			lever_handle.position.y -= 1.
			lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)
		if get_viewport().get_mouse_position().y > lever_handle.global_position.y:
			lever_handle.position.y += 1.
			lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)
	elif lever_selected and Input.is_action_just_released("left_click"):
		if lever_handle.position.y <= 10 and lever_handle.position.y >= -10:
			lever_handle.position.y = 0
	else:
		lever_selected = false
	
	ship.rotate_y((wheel.rotation / MAX_TURN) * TURN_RATE * -1)
	ship.position.y +=  (lever_handle.position.y / MAX_RISE) * RISE_RATE * -1
	ship.position.y = clamp(ship.position.y, -1 * MAX_ELAVATION, MAX_ELAVATION)
	
	last_elevation_update += delta
	if last_elevation_update >= ELEVATION_UPDATE_INTERVAL:
		last_elevation_update = 0
		depth_indicators.update_indicators(ship.position.y, -MAX_ELAVATION, MAX_ELAVATION)

func _on_wheel_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		wheel_selected = true


func _on_lever_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		lever_selected = true
