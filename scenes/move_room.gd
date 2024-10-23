extends Node2D

@onready var move_icon = $move_icon

var mouse_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	move_icon.visible = false


func _process(delta):
	if mouse_entered:
		move_icon.visible = true
	else:
		move_icon.visible = false

func _on_area_2d_mouse_entered():
	mouse_entered = true

func _on_area_2d_mouse_exited():
	mouse_entered = false
