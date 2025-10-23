extends CharacterBody2D
var veloc = 5

var bullet_path = preload("res://Scenes/bullet.tscn")
func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Clique Esquerdo"): 
		fire()

func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir=rotation
	bullet.pos=$Node2D.global_position
	bullet.rota = global_rotation
	get_parent().add_child(bullet)

func _process(delta: float) -> void:
	var posH = (Input.is_action_pressed("ui_right") as int) - (Input.is_action_pressed("ui_left") as int)
	var posV = (Input.is_action_pressed("ui_down") as int) - (Input.is_action_pressed("ui_up") as int)
	
	global_position.x += posH * veloc
	global_position.y += posV * veloc
	
