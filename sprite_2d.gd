extends Sprite2D

@export var radius: float = 20.0
@export var fire_rate: float = 0.3
@export var reload_time: float = 2.0
@export var max_bullets: int = 6

var sprite_bala = preload("res://Scenes/bullet.tscn")
var bullet_count: int = 0
var can_shoot: bool = true


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position()) # Permite a rotação do Vector2D usando look_at

	if Input.is_action_just_pressed("Clique Esquerdo"):
		if can_shoot:
			start_shooting()

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	print(mouse_pos)
	var player = get_parent() as CharacterBody2D
	if player == null:
		return
	
	var player_pos = player.global_position
	var distance = player_pos.distance_to(mouse_pos)
	var mouse_dir = (mouse_pos - player_pos).normalized()
	
	if distance > radius:
		mouse_pos = player_pos + mouse_dir * radius
	
	global_position = mouse_pos

func fire() -> void:
	var bullet_instance = sprite_bala.instantiate()
	if bullet_instance:
		bullet_instance.global_position = global_position + Vector2.RIGHT.rotated(global_rotation) * 20
		bullet_instance.direction = global_rotation
		get_tree().root.add_child(bullet_instance)


func start_shooting() -> void:
	can_shoot = false
	fire()
	bullet_count += 1
	# print("💥 Bullet:", bullet_count)

	await get_tree().create_timer(fire_rate).timeout

	if bullet_count >= max_bullets:
		# print("🔄 Recarregando...")
		await get_tree().create_timer(reload_time).timeout
		bullet_count = 0
		# print("✅ Recarregado!")

	can_shoot = true
