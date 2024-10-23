extends Node2D
@onready var song = $Periscope

func _ready():
	song.playing = true

func _on_play_again_pressed():
	song.playing = false
	get_tree().change_scene_to_file("res://scenes/periscope.tscn")
