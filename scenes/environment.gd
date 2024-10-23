extends Node3D

var rng = RandomNumberGenerator.new()
var time = 0
var refresh_time = 3
var children = self.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(children.size()):
		children.position.y = rng.randf_range(-100, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time == refresh_time:
		time = 0
		set_new_kelp_positions()
		
func set_new_kelp_positions():
	print('here')
	for i in range(children.size()):
		var c = children[i]
		c.position.move_toward(Vector3(c.position.x, rng.randf_range(-100, 100), c.position.z), refresh_time)
