extends Node2D

@onready var ship = $"../../../ship"
@onready var sonar_shape_3d = $"../../../ship/sonar_shape_3d"
@onready var sonar_base = $sonar_base
@onready var sonar_line: Sprite2D = $sonar_line

const SONAR_HIT = preload("res://scenes/sonar_hit.tscn")

const MAX_DISTANCE_3D = 200.
const MAX_DISTANCE_2D = 122. # figure this out

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sonar_line.rotate(0.01)
	sonar_shape_3d.rotate(Vector3.DOWN, 0.01)

	for n in sonar_shape_3d.get_collision_count():
		var distance = ship.global_position.distance_to(sonar_shape_3d.get_collision_point(n))
		var distance_2d = (distance / MAX_DISTANCE_3D) * MAX_DISTANCE_2D * -1
	
		var hit = SONAR_HIT.instantiate()
		hit.rotation = sonar_line.rotation
		add_child(hit)
		hit.init_hit(distance_2d)
		
		
	
