extends CharacterBody2D

var bullet_path = preload("res://Scenes/bullet.tscn")
var bullet = 0
var can_shoot = true

func _physics_process(delta):
	look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("ui_up"):
		if can_shoot:
			start_shooting()
			
	if Input.is_action_pressed("ui_up") and can_shoot:
		await start_shooting()


func fire():
	var bullet_instance = bullet_path.instantiate()
	bullet_instance.dir = rotation
	bullet_instance.pos = $Node2D.global_position
	bullet_instance.rota = global_rotation
	get_parent().add_child(bullet_instance)

func start_shooting():
	can_shoot = false  # impede iniciar novo disparo enquanto este roda
	fire()
	bullet += 1
	print(bullet)

	await get_tree().create_timer(0.3).timeout  # tempo entre tiros

	if bullet == 6:
		bullet = 0
		print("🔄 Recarregando...")
		await get_tree().create_timer(2.0).timeout  # pausa de 2s
		print("✅ Pronto para atirar novamente!")

	can_shoot = true  # libera o próximo disparo
