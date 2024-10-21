extends Node2D
@onready var target_area = $"../target_area/CollisionShape2D"
@onready var hook_col_shape = $hook/CollisionShape2D
@onready var treasure = $"../treasure"

func _ready():
	var center = get_viewport_rect().size / 2
	position = Vector2(center.x, center.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		if treasure.attached:
			position.y -= 40
		else:
			position.y += 0.01
	else:
		position.y += 2
	
	position.y = clamp(
		position.y, 
		target_area.shape.size.y / 2, 
		get_viewport_rect().size.y - hook_col_shape.shape.size.y*4
	)
	
