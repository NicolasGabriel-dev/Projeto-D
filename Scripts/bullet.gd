extends Area2D

@export var lifetime: float = 2.0
var move: Vector2
var life_timer: float = 0.0

func setMoveAndShow(speed: float, direction: float) -> void:
	# direction é um ângulo em radianos
	move = Vector2.RIGHT.rotated(direction) * speed
	#rotation = direction

func setPosition(pos):
	position = pos
func setRotation(rot):
	rotation = rot

func _process(delta: float) -> void:
	position += move * delta
	life_timer += delta
	if life_timer >= lifetime:
		queue_free()
