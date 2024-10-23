extends Area3D

@onready var mesh = $MeshInstance3D
@onready var periscope = $"../Periscope"

func _on_body_entered(body):
	mesh.mesh.flip_faces = true
	periscope.playing = true
	SignalBus.in_safe_zone.emit()


func _on_body_exited(body):
	mesh.mesh.flip_faces = false
	periscope.playing = false
	SignalBus.out_safe_zone.emit()
