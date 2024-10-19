extends Node2D
@onready var ship = $"../../../ship"
@onready var wheel = $wheel
@onready var lever_handle = $lever/lever_handle

const MAX_TURN = 0.5
const TURN_RATE = 0.01

const MAX_RISE = 35.
const RISE_RATE = 0.1


func _input(event):
	if Input.is_key_pressed(KEY_A):
		wheel.rotate(-0.01)
		wheel.rotation = clamp(wheel.rotation, -1*MAX_TURN, MAX_TURN)
	if Input.is_key_pressed(KEY_D):
		wheel.rotate(0.01)
		wheel.rotation = clamp(wheel.rotation, -1*MAX_TURN, MAX_TURN)
		
	ship.rotate_y((wheel.rotation / MAX_TURN) * TURN_RATE * -1)
	
	if Input.is_key_pressed(KEY_W):
		lever_handle.position.y -= 1.
		lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)
	if Input.is_key_pressed(KEY_S):
		lever_handle.position.y += 1.
		lever_handle.position.y = clamp(lever_handle.position.y, -1*MAX_RISE, MAX_RISE)
	
	
	ship.position.y +=  (lever_handle.position.y / MAX_RISE) * RISE_RATE * -1
