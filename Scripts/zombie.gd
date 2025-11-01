extends CharacterBody2D
 
signal zombie_hit

@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

@export var live: int = 2
@export var speed: float = 2.0
var keep_target: Node2D
var target = Vector2(0,0)
var is_hitting: bool = false
var is_unfocused: bool = true


func _process(delta: float) -> void:
	if keep_target and is_unfocused:
		focusOnPosition(keep_target.global_position)
	move()
	
#func _ready() -> void:
	#keep_target = get_global_mouse_position()

		
func focusOnPosition(tar: Vector2):
	is_unfocused = false
	$FocusTime.start(0.1)
	#velocity = Vector2(0,0)
	target = tar
	#if speed >= 0: 
		#speed += randf_range(-5, 5)
	#if speed > 0.5 && speed < 8.0:
		#speed *= randf_range(0.5, 2.0)
	#else:
		#speed = 3.0
	await $FocusTime.timeout
	is_unfocused = true

func move() ->void:
	if position.distance_to(target) > 10:
		_animation_player.play()
		position += Vector2.RIGHT.rotated(get_angle_to(target)) *speed
	else:
		_animation_player.stop()


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
