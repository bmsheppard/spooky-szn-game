extends Node2D

@onready var power = $"../power"

var size = 10
var pos = 0
const MAX_SIZE = 100
const PERFECT_PULL = MAX_SIZE - 20

func _ready():
	var viewport = get_viewport_rect().size
	pos = Vector2(viewport.y / 2 - 100, viewport.x / 2 - 100)
	power.position = pos - power.size / 2
func _process(delta):
	size += delta * 200
	if size >= MAX_SIZE:
		size = 0
	queue_redraw()
	
func _draw():
	var bg_color: Color = Color.html("#0b1b7d")
	draw_circle(pos, MAX_SIZE, Color.WHITE)
	draw_circle(pos, MAX_SIZE - 1, bg_color)
	if size >= PERFECT_PULL:
		draw_circle(pos, size, Color.GREEN)
	else:
		draw_circle(pos, size, Color.RED)

func set_size(new_size):
	size = new_size
