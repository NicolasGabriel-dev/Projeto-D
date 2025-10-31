extends Area2D

@export var bullet_speed: float = 10.0
@export var fire_rate: float = 0.3
@export var reload_time: float = 1.5
@export var max_bullets: int = 6
@export var bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")

var bullet_count: int = 0
var can_shoot: bool = true
var is_reloading: bool = false

func _process(delta: float) -> void:
	if is_reloading:
		rotate(max_bullets * (PI*2 *delta)/reload_time)
	else:
		var mouse_pos = get_global_mouse_position()
		# Calcula rotação corretamente: ângulo entre arma (global_position) e mouse
		rotation = (mouse_pos - global_position).angle()
		#print(mouse_pos.x - global_position.x)
		var direction_x = mouse_pos.x - global_position.x 
		$Sprite2D.flip_v = direction_x < 0
		$Muzzle.position.y = -5*signf(direction_x)
	#print($Muzzle.global_position - position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		start_shooting()

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	# define posição global do projétil (nasce no cano)
	bullet.set_position($Muzzle.global_position)
	# opcional: define a rotação visual do projétil
	bullet.set_rotation(rotation)
	# passa velocidade e direção (em radianos)
	bullet.setMoveAndShow(bullet_speed, rotation)
	# adiciona ao nó raiz da cena (mundo), para NÃO herdar transform/rotacao da arma
	get_tree().root.add_child(bullet)

func start_shooting() -> void:
	can_shoot = false
	shoot()
	bullet_count += 1

	await get_tree().create_timer(fire_rate).timeout

	if bullet_count >= max_bullets:
		is_reloading = true
		await get_tree().create_timer(reload_time).timeout
		is_reloading = false
		bullet_count = 0

	can_shoot = true
