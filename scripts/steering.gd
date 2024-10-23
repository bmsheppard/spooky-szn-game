extends Node2D

@onready var wheel = $wheel
@onready var lever_handle = $lever/lever_handle
var ship

const MAX_TURN = 0.5
const TURN_RATE = 0.01

const MAX_RISE = 35.
const RISE_RATE = 0.2

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

		ship.rotate_y((wheel.rotation / MAX_TURN) * TURN_RATE * -1)
	else:
		wheel_selected = false
	
	if lever_selected and Input.is_action_pressed("left_click"):
		if get_viewport().get_mouse_position().y < lever_handle.global_position.y:
			lever_handle.position.y -= 1.
			lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)
		if get_viewport().get_mouse_position().y > lever_handle.global_position.y:
			lever_handle.position.y += 1.
			lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)

		ship.rotate_y((wheel.rotation / MAX_TURN) * TURN_RATE * -1)
	else:
		lever_selected = false

func _on_wheel_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		wheel_selected = true


func _on_lever_area_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		lever_selected = true
