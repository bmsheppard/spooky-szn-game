extends Node2D
@onready var move_icon_right = $sonar_room/move_right/move_icon
@onready var move_icon_left = $steering_room/move_left/move_icon
@onready var move_icon_down = $periscope_room/move_down/move_icon
@onready var periscope = $sonar_room/periscope
@onready var periscope_area_2d = $sonar_room/periscope/Area2D

@onready var blur = $UI/blur
var periscope_active = false
var screen_positon = Vector2(0,0)

var offset_scale = 1.04
var offset
var center_point
var screen_size

var safe_zone_1 = Vector2(-500, 300)
var safe_zone_2 = Vector2(-500, 200)
var safe_zone_3 = Vector2(-500, 200)
var current_safe_zone = safe_zone_1


func _ready():
	screen_size = get_viewport().get_visible_rect().size
	center_point = screen_size / 2
	offset = ((screen_size * offset_scale) - screen_size) / 2

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("left_click") and (move_icon_right.visible or move_icon_left.visible) and screen_positon.y == 0:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if screen_positon.x == 0:
			screen_positon.x = -screen_size.x - (offset.x * 2)
		else:
			screen_positon.x = 0
		blur.visible = true
		tween.tween_property(self, "position",  screen_positon, 0.2)
		await tween.finished
		blur.visible = false
		
	
	if Input.is_action_just_pressed("left_click") and (periscope.position != Vector2(0,-700) or move_icon_down.visible) and screen_positon.x == 0:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
		if screen_positon.y == 0:
			periscope_area_2d.visible = false
			periscope_active = true 
			screen_positon.y = screen_size.y + (offset.y)
		else:
			periscope_area_2d.visible = true
			periscope_active = false
			screen_positon.y = 0
		blur.visible = true
		tween.tween_property(self, "position",  screen_positon, 0.2)
		await tween.finished
		blur.visible = false

func _input(event):
	if event is InputEventMouseMotion:
		if periscope_active:
			SignalBus.set_periscope_angle.emit(event.relative.x)
		else:
			self.position = screen_positon + ((event.global_position - center_point) / center_point * offset * -1)
			
	if event.is_action_pressed("pull_treasure"):
		SignalBus.reel_pull.emit()
