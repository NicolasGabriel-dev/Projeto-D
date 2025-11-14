extends CanvasLayer

var time: int
var high_score: int = 0

func converted_to_time(varTime):
	return str(int(varTime/60)) + ":" + str(varTime%60)

func update_time() -> void:
	$CounterLabel.text = converted_to_time(time)

func _ready() -> void:
	$CounterTimer.start()
	
func actual_high_score():
	if time > high_score:
		high_score = time
	return high_score
