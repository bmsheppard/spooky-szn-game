extends Node2D

@onready var target_area = $"../target_area/CollisionShape2D"
@onready var hook_col_shape = $hook/CollisionShape2D
@onready var treasure = $"../treasure"
@onready var pull_strength = $"../temp_gui/pull_strength"
@onready var instructions = $"../temp_gui/instructions"

func _ready():
	var center = get_viewport_rect().size / 2
	position = Vector2(center.x, center.y)
	SignalBus.reel_pull.connect(_handle_reel_pull)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if treasure.attached:
		position.y += 100*delta
	else:
		position.y += 200*delta
	position.y = clamp(
		position.y, 
		target_area.shape.size.y / 2, 
		get_viewport_rect().size.y - hook_col_shape.shape.size.y*4
	)

func _handle_reel_pull():
	if treasure.attached:
		position.y -= 100 * (pull_strength.size/pull_strength.MAX_SIZE)
		pull_strength.set_size(0)
		
		if instructions.visible:
			instructions.visible = false

# leaving this in so that we can test this scene directly
func _input(event):
	if event.is_action_pressed("pull_treasure"):
		_handle_reel_pull()
	
