extends Node3D

const SPEED = 0.05

func _process(delta):
	position += (transform.basis*Vector3.FORWARD*SPEED)
