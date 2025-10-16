extends CharacterBody2D

var speed = 2000  # Velocidade do projétil

func _physics_process(delta: float) -> void:
	# Move na direção do rotation
	var velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()
