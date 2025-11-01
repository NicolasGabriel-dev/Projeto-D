extends Node2D

@export var zombie: PackedScene = preload("res://Scenes/zombie.tscn")

var target: Node2D

func _ready() -> void:
	new_game()
	target = $sdc15
	
#func _process(delta: float) -> void:
	#target = $sdc15.position

func new_game() -> void:
	$ZombieTimer.start()

func game_over() -> void:
	$ZombieTimer.stop()


func zombie_timeout():
	var zombie_instance = zombie.instantiate()
	var spawn = $ZombiePath/ZombieSpawnLocation
	
	spawn.progress_ratio = randf()
	
	zombie_instance.position = spawn.position
	
	# ainda não está certo Node2d e Vector2 em zombie.gd
	zombie_instance.set_target(target)
	
	add_child(zombie_instance)
