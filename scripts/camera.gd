extends Camera3D
@onready var ship = $".."

const LOOK_SPEED = 0.001
const FOV  = 0.75

func _ready():
	SignalBus.set_periscope_angle.connect(_set_periscope_angle)
	
func _process(_delta):
	rotation.y = clamp(rotation.y, -FOV, FOV)

func _set_periscope_angle(rot):
	rotate_object_local(Vector3.UP, rot * - LOOK_SPEED)
