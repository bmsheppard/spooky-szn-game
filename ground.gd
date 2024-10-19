@tool
extends MeshInstance3D

@export var xSize = 20
@export var zSize = 20

@export var update = false
@export var clear_vert_vis = false

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_terrain()


func generate_terrain():
	pass
	#var a_mesh: 
