extends Camera2D

var desvio_desejado: Vector2
var desvio_min = -200
var desvio_max = 200

func _process(delta: float) -> void:
	desvio_desejado = (get_global_mouse_position() - position) * 0.5
	desvio_desejado.x = clamp(desvio_desejado.x, desvio_min, desvio_max)
	desvio_desejado.y = clamp(desvio_desejado.y, desvio_min / 2.0, desvio_max / 2.0)
