extends Node2D

func _ready():
	var center = get_viewport_rect().size / 2
	position = Vector2(center[0], center[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		position.y -= 1
	else:
		position.y += 1
