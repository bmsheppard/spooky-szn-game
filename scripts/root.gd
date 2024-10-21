extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("test_1") and position.y == 0:
		var test = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if position.x == 0:
			test.tween_property(self, "position:x", 1920, 0.2)
		else:
			test.tween_property(self, "position:x", 0, 0.2)
	
	if Input.is_action_just_pressed("test_2") and position.x == 0:
		var test = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if position.y == 0:
			test.tween_property(self, "position:y", 1080, 0.2)
		else:
			test.tween_property(self, "position:y", 0, 0.2)