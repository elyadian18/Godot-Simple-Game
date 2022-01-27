extends CanvasLayer
signal game_start

func kenyang_update(kenyang):
	$Kenyang.text=str(kenyang)

func show_message(text):
	$Label.text= text
	$Label.show()
	$Timer.start()

func _on_Button_pressed():
	$Button.hide()
	$Label.hide()
	emit_signal('game_start')


func show_game_over():
	show_message("Game Over")
	yield($Timer,"timeout")
	show_message("Beri makan Boots")
	yield($Timer,"timeout")
	$Button.show()


