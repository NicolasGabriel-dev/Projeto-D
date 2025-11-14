extends CanvasLayer

var time: int = 0
var high_score: int = 0

func converted_to_time(varTime):
	var minutes
	var seconds
	if (int(varTime/60) < 10):
		minutes = "0" + str(int(varTime/60))
	else:
		minutes = str(int(varTime/60))
	if (int(varTime%60) < 10):
		seconds = "0" + str(int(varTime%60))
	else:
		seconds = str(int(varTime%60))
	return  minutes + ":" + seconds 

func update_time() -> void:
	$CounterLabel.text = converted_to_time(time)

func _ready() -> void:
	$CounterTimer.start()
	
func actual_high_score():
	if time > high_score:
		high_score = time
	return high_score


func _on_counter_timer_timeout() -> void:
	print("teste")
	time += 1
	update_time()
	actual_high_score()
	$CounterTimer.start()
