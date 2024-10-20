extends Area3D

@onready var mesh = $MeshInstance3D

func _on_area_entered(_area):
	mesh.mesh.flip_faces = true
	
func _on_area_exited(_area):
	mesh.mesh.flip_faces = false
