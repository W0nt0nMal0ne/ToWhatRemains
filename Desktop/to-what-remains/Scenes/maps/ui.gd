extends CanvasLayer




func _process(delta):
	%CPLabel.text = "CP: " + str(GameManager.current_cp) + " / " + str(GameManager.max_cp)
	%TurnLabel.text = "Turn: " + str(GameManager.current_turn)
