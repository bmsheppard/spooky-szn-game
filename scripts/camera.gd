extends Camera3D
@onready var ship = $".."

const LOOK_SPEED = 0.001
const FOV  = 0.75

func _process(_delta):
	rotation.y = clamp(rotation.y, -FOV, FOV)

func _input(event):		
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP, event.relative.x * -LOOK_SPEED)
