extends CharacterBody2D

@onready var _animation_player: AnimatedSprite2D = $animatedSprite
@export var speed = 200
@export var gun: PackedScene = preload("res://Scenes/gun.tscn")

func _ready() -> void:
	spawn_gun($HandLeft.position)
	spawn_gun($HandRight.position)

func _process(delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_pressed("ui_right"):
		_animation_player.flip_h = false
		_animation_player.play("Movimento")
	elif Input.is_action_pressed("ui_left"):
		_animation_player.flip_h = true
		_animation_player.play("Movimento")
	elif Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		_animation_player.play("Movimento")
	else:
		_animation_player.stop()

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func spawn_gun(hand_position: Vector2) -> void:
		var gun_instance = gun.instantiate()
		gun_instance.position = hand_position
		add_child(gun_instance)
