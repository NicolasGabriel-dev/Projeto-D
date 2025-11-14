extends CharacterBody2D
 
signal zombie_hit

@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

@export var live: int = 2
@export var speed_main: float = 2.0
@export var focus_aceleration = false
@export var stop_on_focus = false
var keep_target: Node2D
var target = Vector2(0,0)
var is_hitting: bool = false
var is_unfocused: bool = true
var speed = speed_main

func _process(delta: float) -> void:
	if keep_target and is_unfocused:
		focusOnPosition(keep_target.global_position)
	move()
	
#func _ready() -> void:
	#keep_target = get_global_mouse_position()

		
func focusOnPosition(tar: Vector2):
	is_unfocused = false
	$FocusTime.start() #altere no FocusTimer
	#velocity = Vector2(0,0)
	target = tar
	if focus_aceleration:
		if speed >= 0: 
			speed += randf_range(-0.5, 2)
		if speed > 0.5 && speed < 4.0:
			speed *= randf_range(0.5, 2.0)
		else:
			speed = speed_main
	await $FocusTime.timeout
	is_unfocused = true

func move() -> void:
	if position.distance_to(target) > 10:
		var moviment = Vector2.RIGHT.rotated(get_angle_to(target))

		_animation_player.flip_h = moviment.x < 0
		_animation_player.play()

		# movimento físico
		velocity = moviment * speed

		# tenta mover e detectar colisão
		var collision = move_and_collide(velocity)

		# se colidiu, trate aqui
		if collision:
			_on_collision(collision.get_collider())

	else:
		velocity = Vector2.ZERO
		_animation_player.stop()

func _on_collision(collider):
	if collider.is_in_group("player"):
		print("Colidiu com o player!")
		attack()

	if collider.is_in_group("wall"):
		print("Bateu na parede!")
		# exemplo: pare o movimento
		velocity = Vector2.ZERO



func set_target(tar: Node2D):
	keep_target = tar

func attack() -> void:
	is_hitting = true
	zombie_hit.emit(get_tree())
	$AttackCooldown.start()
	await $AttackCooldown.timeout
	is_hitting = false

func be_attacked(damage: int) -> void:
	live -= damage
	modulate = Color(1, 0.5, 0.5)  # efeito visual: fica avermelhado
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1, 1, 1)
	if live <= 0:
		die()

func die():
	queue_free()
