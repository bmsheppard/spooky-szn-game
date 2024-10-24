extends Node3D

@onready var minigame_text = $start_minigame_text

var minigame = preload("res://scenes/pickup_minigame.tscn")
var speed = 0.05


@onready var depth_meter: Label = $"../../../UI/depth_meter"
@onready var compass = $"../../../UI/compass"
@onready var long_and_lad = $"../../../UI/long_and_lad"

var periscope_active = false
var start_depth = 200
var start_long_lad = Vector2(200,200)
var start_global_position

var health = 2.0

func _ready():
	minigame_text.visible = false
	SignalBus.restart_main_game.connect(restart_main_game)
	SignalBus.hit_ship.connect(hit_ship)
	SignalBus.in_safe_zone.connect(in_safe_zone)
	SignalBus.out_safe_zone.connect(out_safe_zone)
	SignalBus.periscope_active.connect(is_periscope_active)
	start_global_position = global_position
	
func _process(_delta):
	position += (transform.basis*Vector3.FORWARD*speed)
	var long = int(start_long_lad.y + start_global_position.z-global_position.z)
	var lad = int(start_long_lad.x + start_global_position.x-global_position.x)
	long_and_lad.text = str(long,'° N\n',lad,'° W')
	
	depth_meter.text = str('Depth: ', floor(start_depth - position.y), 'm')
	calculate_compass()
	
	#if periscope_active and Input.is_action_just_pressed("left_click"):
		#print('hello')
		#for n in shape_cast_3d.get_collision_count():
			#var object = shape_cast_3d.get_collider(n)
			#print(object)
			#object.queue_free()
	
	if Input.is_key_pressed(KEY_SPACE) and minigame_text.visible:
		start_minigame()

func start_minigame():
	minigame_text.visible = false
	speed = 0
	SignalBus.start_minigame.emit()
	add_child(minigame.instantiate())

func restart_main_game():
	speed = 0.05
	
func hit_ship():
	health -= 1.0
	SignalBus.shake_screen.emit()
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/lose_screen.tscn")

func is_periscope_active(is_active):
	periscope_active = is_active
	
func in_safe_zone():
	minigame_text.visible = true

func out_safe_zone():
	minigame_text.visible = false
	

func calculate_compass():
	var dir = rotation_degrees.y
	if dir < 0: dir += 360
	
	var label = 'N'
	if dir >= 22.5 and dir < 67.5:
		label = 'NW'
	elif dir >= 67.5 and dir < 112.5:
		label = 'W'
	elif dir >= 112.5 and dir < 157.5:
		label = 'SW'
	elif dir >= 157.5 and dir < 202.5:
		label = 'S'
	elif dir >= 202.5 and dir < 247.5:
		label = 'SE'
	elif dir >= 247.5 and dir < 292.5:
		label = 'E'
	elif dir >= 292.5 and dir < 337.5:
		label = 'NE'
	
	compass.text = str(label)
