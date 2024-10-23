extends Area2D
@onready var collision = $CollisionShape2D
@onready var treasure = $"../treasure"

func _ready():
	var viewport = get_viewport_rect().size
	collision.shape.size = Vector2(viewport.x, viewport.y / 8)
	
func _on_area_entered(_area):
	if treasure.attached:
		SignalBus.restart_main_game.emit()
		self.get_parent().queue_free()
