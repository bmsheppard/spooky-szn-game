extends Node2D

@onready var song = $Periscope
@onready var title = $CanvasLayer/gui/title
@onready var instructions = $CanvasLayer/gui/instructions
func _ready():
	song.playing = true
	title.visible = true
	instructions.visible = false
	
func _on_play_pressed():
	song.playing = false
	get_tree().change_scene_to_file("res://scenes/periscope.tscn")

func _on_instructions_pressed():
	toggle_instructions()

func _on_back_pressed():
	toggle_instructions()
	
func toggle_instructions():
	title.visible = !title.visible
	instructions.visible = !instructions.visible
