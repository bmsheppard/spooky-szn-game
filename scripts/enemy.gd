extends Node3D

var state = 'IDLE'
var speed = 2.0
var target: Node3D

func _process(delta):
	# TODO: While IDLE swim
	if state == 'FOLLOW':
		var dir = global_position.direction_to(target.global_position)
		global_position += (dir * speed * delta)

func _on_area_3d_body_entered(body):
	state = 'FOLLOW'
	target = body
