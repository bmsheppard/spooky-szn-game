extends Node2D

var periscope_active = false
var screen_positon = Vector2(0,0)

var offset_scale = 1.04
var offset
var center_point
var screen_size


func _ready():
	screen_size = get_viewport().get_visible_rect().size
	center_point = screen_size / 2
	offset = ((screen_size * offset_scale) - screen_size) / 2

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("test_1") and screen_positon.y == 0:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if screen_positon.x == 0:
			screen_positon.x = screen_size.x + (offset.x * 2)
		else:
			screen_positon.x = 0
		tween.tween_property(self, "position",  screen_positon, 0.2)
	
	if Input.is_action_just_pressed("test_2") and screen_positon.x == 0:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if screen_positon.y == 0:
			periscope_active = true 
			screen_positon.y = screen_size.y + (offset.y)
		else:
			periscope_active = false
			screen_positon.y = 0
		tween.tween_property(self, "position",  screen_positon, 0.2)

func _input(event):
	if event is InputEventMouseMotion:
		if periscope_active:
			SignalBus.set_periscope_angle.emit(event.relative.x)
		else:
			self.position = screen_positon + ((event.global_position - center_point) / center_point * offset * -1)
			
	if event.is_action_pressed("pull_treasure"):
		SignalBus.reel_pull.emit()
