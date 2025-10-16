extends CharacterBody2D

var bullet_scene = preload("res://Scripts/bullets.gd")  # Caminho do bullet

func _physics_process(delta: float) -> void:
	# Olhar para o mouse
	look_at(get_global_mouse_position())
	
	# Disparar quando tecla "ui_accept" é pressionada
	if Input.is_action_just_pressed("ui_accept"):
		fire()

func fire():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position  # Posicionar no player
	bullet.rotation = rotation                # Setar rotação igual ao player
	get_parent().add_child(bullet)            # Adicionar à cena
