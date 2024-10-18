extends Node3D

const SPEED = 0.1

func _process(delta):
	#pass
	position += (transform.basis*Vector3.FORWARD*SPEED)
	
#func _input(event):
	## temp for testing (rotating the ship)
	#if Input.is_key_pressed(KEY_A):
		#rotate_y(0.05)
		#transform = transform.orthonormalized()
	#if Input.is_key_pressed(KEY_D):
		#rotate_y(-0.05)
		#transform = transform.orthonormalized()
	## end temp
