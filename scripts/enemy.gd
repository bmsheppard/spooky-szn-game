extends Node3D

var state = 'IDLE'
var speed = 10.0
var target: Node3D
var moused_on = false

func _process(delta):
	if moused_on and Input.is_action_just_pressed("left_click"):
		queue_free()

	if state == 'FOLLOW':
		
		if global_position.distance_to(target.global_position) < 10:
			SignalBus.hit_ship.emit()
			queue_free()

		var dir = global_position.direction_to(target.global_position)
		global_position += (dir * speed * delta)
		var target_basis = Basis.looking_at(dir)
		basis = basis.slerp(target_basis, 0.5)

func _on_area_3d_body_entered(body):
	state = 'FOLLOW'
	target = body
	SignalBus.hit_ship
