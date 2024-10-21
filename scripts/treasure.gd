extends Area2D

@onready var hook = $"../claw/hook"
@onready var collision_shape_2d = $"../claw/hook/CollisionShape2D"
@onready var temp_gui = $"../temp_gui"

var attached = false

func _ready():
	var viewport = get_viewport_rect().size
	position = Vector2(viewport.x / 2, viewport.y)

func _process(delta):
	if attached:
		global_position = hook.global_position + Vector2.DOWN * collision_shape_2d.shape.size.y

func _on_area_entered(area):
	temp_gui.visible = true
	attached = true
