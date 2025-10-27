extends CharacterBody2D

@export var speed = 200
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func _process(_delta):
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

	
