extends CharacterBody2D
 
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	_animation_player.play()
