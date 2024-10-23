extends Node2D

var default_pos = Vector2(0, - 700)

var tween

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_area_2d_mouse_entered():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(self, "position",  Vector2(0,0), 0.2)


func _on_area_2d_mouse_exited():
		tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(self, "position",  default_pos, 0.2)
