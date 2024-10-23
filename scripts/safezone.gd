extends Area3D

@onready var mesh = $MeshInstance3D
@onready var periscope = $"../Periscope"

func _on_area_entered(_area):
	mesh.mesh.flip_faces = true
	periscope.playing = true
	
func _on_area_exited(_area):
	mesh.mesh.flip_faces = false
	periscope.playing = false
