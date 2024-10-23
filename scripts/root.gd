extends Node2D
@onready var move_icon_right = $sonar_room/move_right/move_icon
@onready var move_icon_left = $steering_room/move_left/move_icon
@onready var move_icon_down = $periscope_room/move_down/move_icon
@onready var periscope = $sonar_room/periscope
@onready var periscope_area_2d = $sonar_room/periscope/Area2D
@onready var area_2d = $periscope_room/move_down/Area2D

@onready var blur = $UI/blur
var periscope_active = false
var screen_positon = Vector2(0,0)

var offset_scale = 1.04
var offset
var center_point
var screen_size

@onready var safe_zone_label = $UI/safe_zone
var safe_zone_1 = Vector2(300, 50) + Vector2(200,200)
var safe_zone_2 = Vector2(400, 600) + Vector2(200,200)
var safe_zone_3 = Vector2(500, 200) + Vector2(200,200) #tbd
var current_safe_zone = safe_zone_1

#var randomStrength: float = 2.0
#@export var shakeFade: float = 2.0
#var rng = RandomNumberGenerator.new()
#var shake_strength: float = 0.0
#
#func randomOffset() -> Vector2:
	#return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
#
#func apply_shake():
	#shake_strength = randomStrength

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	center_point = screen_size / 2
	offset = ((screen_size * offset_scale) - screen_size) / 2
	safe_zone_label.text = str('Safe Zone\n',int(current_safe_zone.x),'° N ', int(current_safe_zone.y), '° W')
	SignalBus.restart_main_game.connect(next_safe_zone)
	SignalBus.start_minigame.connect(start_minigame)
	#SignalBus.shake_screen.connect(apply_shake)

func start_minigame():
	area_2d.visible = false
	
		
func _process(delta):
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
			SignalBus.periscope_active.emit(true)
			periscope_active = true 
			screen_positon.y = screen_size.y + (offset.y)
		else:
			periscope_area_2d.visible = true
			SignalBus.periscope_active.emit(false)
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
		
func next_safe_zone():
	area_2d.visible = true
	if current_safe_zone == safe_zone_1:
		current_safe_zone = safe_zone_2
	elif current_safe_zone == safe_zone_2:
		current_safe_zone = safe_zone_3
	elif current_safe_zone == safe_zone_3:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
	safe_zone_label.text = str('Safe Zone\n',int(current_safe_zone.x),'° N ', int(current_safe_zone.y), '° W')

func get_mouse_pos():
	return get_viewport().get_mouse_position()
