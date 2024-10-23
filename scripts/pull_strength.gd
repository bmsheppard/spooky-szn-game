extends Node2D

@onready var power = $"../power"

var size = 10
var pos = 0
const MAX_SIZE = 110
const PERFECT_PULL = MAX_SIZE - 20

func _ready():
	var viewport = get_viewport_rect().size
	pos = Vector2(viewport.y / 2 - 100, viewport.x / 2 - 100)
	power.position = pos - power.size / 2

func _process(delta):
	size += delta * 100
	if size >= MAX_SIZE:
		size = 0
	queue_redraw()
	
func _draw():
	var black: Color = Color.html("#262730")
	var green: Color = Color.html("#33ff66")
	var red: Color = Color.html("#D33F49")
	var white: Color = Color.html("#E5E5E5")
	draw_circle(pos, MAX_SIZE - 0, white)
	draw_circle(pos, MAX_SIZE - 1, black)
	if size >= PERFECT_PULL:
		draw_circle(pos, size, green)
	else:
		draw_circle(pos, size, red)

func set_size(new_size):
	size = new_size
