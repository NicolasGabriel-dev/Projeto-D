extends CharacterBody2D

@export var speed: float = 2000
@export var lifetime: float = 2.0

var direction: float

func _ready():
	rotation = direction
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
