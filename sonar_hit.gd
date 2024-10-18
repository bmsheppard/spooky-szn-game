extends Node2D

@onready var sprite_2d = $Sprite2D

func _process(delta):
	sprite_2d.modulate.a -= 0.01
	if sprite_2d.modulate.a <= 0:
		queue_free()

func init_hit(distance: float):
	sprite_2d.position.y += distance
	
	
