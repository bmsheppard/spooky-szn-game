extends Node2D

@onready var background_bottom = $background_bottom
@onready var background_middle = $background_middle
@onready var background_left = $background_left
@onready var background_middle_timer = $background_middle_timer
@onready var background_left_timer = $background_left_timer
@onready var background_bottom_timer = $background_bottom_timer

func _on_background_middle_timer_timeout():
		background_middle.color.a = 0.6
		await get_tree().create_timer(0.15).timeout
		background_middle.color.a = 1.0  
		background_middle_timer.wait_time = randf_range(2,10)
		background_middle_timer.start()


func _on_background_left_timer_timeout():
		background_left.color.a = 0.6
		await get_tree().create_timer(0.15).timeout
		background_left.color.a = 1.0  
		background_left_timer.wait_time = randf_range(6,14)
		background_left_timer.start()


func _on_background_bottom_timer_timeout():
		background_bottom.color.a = 0.6
		await get_tree().create_timer(0.15).timeout
		background_bottom.color.a = 1.0  
		background_bottom_timer.wait_time = randf_range(2,10)
		background_bottom_timer.start()
