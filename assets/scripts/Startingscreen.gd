extends CanvasLayer

signal start_game

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $StartButton.show()

func _on_StartButton_pressed():
	$StartButton.hide()
	get_tree().change_scene("res://root.tscn")

func _on_MessageTimer_timeout():
    $MessageLabel.hide()