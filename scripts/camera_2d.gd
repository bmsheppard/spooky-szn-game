extends Camera2D

var randomStrength: float = 8.0
@export var shakeFade: float = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func apply_shake():
	shake_strength = randomStrength


func _ready():
	SignalBus.shake_screen.connect(apply_shake)

func _process(delta):
	if shake_strength > 0:
		print('hello world')
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		offset = randomOffset()
		#position += offset
