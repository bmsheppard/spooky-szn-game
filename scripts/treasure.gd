extends Area2D

@onready var hook = $"../claw/hook"
@onready var collision_shape_2d = $"../claw/hook/CollisionShape2D"
@onready var temp_gui = $"../temp_gui"
@onready var pull_strength = $"../temp_gui/pull_strength"
@onready var sprite_2d = $Sprite2D

var attached = false

func _ready():
	var viewport = get_viewport_rect().size
	position = Vector2(viewport.x / 2, viewport.y)

func _process(delta):
	if attached:
		global_position = hook.global_position - Vector2.DOWN * sprite_2d.position.y

func _on_area_entered(area):
	temp_gui.visible = true
	pull_strength.size = 10
	attached = true
