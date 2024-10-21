extends Node2D

@onready var sonar_base = $sonar_base
@onready var sonar_line: Sprite2D = $sonar_line
var ship
var ship_sonar_3d

const SONAR_HIT = preload("res://scenes/sonar_hit.tscn")

const MAX_DISTANCE_3D = 200.
const MAX_DISTANCE_2D = 122. # figure this out


func _ready():
	ship = get_tree().get_first_node_in_group('ship')
	ship_sonar_3d = get_tree().get_first_node_in_group('ship_sonar_3d')

func _process(_delta):
	sonar_line.rotate(0.01)
	ship_sonar_3d.rotate(Vector3.DOWN, 0.01)
	
	for n in ship_sonar_3d.get_collision_count():
		var distance = ship.global_position.distance_to(ship_sonar_3d.get_collision_point(n))
		var distance_2d = (distance / MAX_DISTANCE_3D) * MAX_DISTANCE_2D * -1
	
		var hit = SONAR_HIT.instantiate()
		hit.rotation = sonar_line.rotation
		add_child(hit)
		hit.init_hit(distance_2d)
		
		
	
