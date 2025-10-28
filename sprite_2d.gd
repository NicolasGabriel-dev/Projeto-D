extends Sprite2D

@export var radius: float = 50.0
@export var fire_rate: float = 0.3
@export var reload_time: float = 2.0
@export var max_bullets: int = 6

var bullet_path = preload("res://Scenes/bullet.tscn")
var bullet_count: int = 0
var can_shoot: bool = true


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("ui_up"):
		if can_shoot:
			start_shooting()


func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
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
	var bullet_instance = bullet_path.instantiate()
	if bullet_instance: 
		bullet_instance.rotation = global_rotation
		bullet_instance.global_position = global_position
		get_tree().current_scene.add_child(bullet_instance)


func start_shooting() -> void:
	can_shoot = false
	fire()
	bullet_count += 1
	print("💥 Bullet:", bullet_count)

	await get_tree().create_timer(fire_rate).timeout

	if bullet_count >= max_bullets:
		print("🔄 Recarregando...")
		await get_tree().create_timer(reload_time).timeout
		bullet_count = 0
		print("✅ Recarregado!")

	can_shoot = true
