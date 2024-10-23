extends Node3D

@onready var minigame_text = $start_minigame_text

var minigame = preload("res://scenes/pickup_minigame.tscn")
var speed = 0.05

func _ready():
	minigame_text.visible = false
	SignalBus.restart_main_game.connect(restart_main_game)
	
func _process(_delta):
	position += (transform.basis*Vector3.FORWARD*speed)
	
	if Input.is_key_pressed(KEY_SPACE) and minigame_text.visible:
		start_minigame()

func start_minigame():
	minigame_text.visible = false
	speed = 0
	add_child(minigame.instantiate())

func restart_main_game():
	speed = 0.05


func _on_area_3d_area_entered(_area):
	minigame_text.visible = true

func _on_area_3d_area_exited(_area):
	minigame_text.visible = false
