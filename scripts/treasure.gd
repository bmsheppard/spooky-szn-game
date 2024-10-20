extends Area2D

@onready var hook = $"../claw/hook"
var attached = false

func _ready():
	var viewport = get_viewport_rect().size
	position = Vector2(viewport[0] / 2, viewport[1])

func _process(delta):
	if attached:
		global_position = hook.global_position

func _on_area_entered(area):
	attached = true
