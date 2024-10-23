extends Node2D

@onready var background_1 = $background_1
@onready var background_2 = $background_2
@onready var background_1_timer = $background_1_timer
@onready var background_2_timer = $background_2_timer

func _on_background_1_timer_timeout():
		background_1.color.a = 0.4
		await get_tree().create_timer(0.15).timeout
		background_1.color.a = 1.0  
		background_1_timer.wait_time = randf_range(2,10)
		background_1_timer.start()

func _on_background_2_timer_timeout():
		background_2.color.a = 0.6
		await get_tree().create_timer(0.15).timeout
		background_2.color.a = 1.0  
		background_2_timer.wait_time = randf_range(2,10)
		background_2_timer.start()
