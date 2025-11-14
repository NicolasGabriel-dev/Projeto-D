extends CanvasLayer

signal start_game
signal toggle_shop

var shop: bool = false

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

func _on_shop_button_pressed() -> void:
	$ShopButton.hide()
	toggle_shop.emit()


func _on_start_game() -> void:
	pass # Replace with function body.
