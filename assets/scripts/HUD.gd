extends CanvasLayer

signal start_game
	

func reset_game_hud():
	$Message.show()
	$Message.text = 'Desvie e sobreviva aos monstrengos!'
	
	
func update_score(score):
	$Score.text = str(score)

	
func update_message(message):
	$Message.show()
	$Message.text = str(message)
	$MessageTimer.start()
	yield($MessageTimer, 'timeout')


func start_game_action():
	emit_signal("start_game")


func hide_message():
	$Message.hide()
