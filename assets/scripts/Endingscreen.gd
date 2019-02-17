extends CanvasLayer

signal end_game

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $StartButton.show()
#	need background back to begin
func _on_StartButton_pressed():
	$StartButton.hide()
	get_tree().change_scene("res://root.tscn")

func _on_MessageTimer_timeout():
    $MessageLabel.hide()

func _on_Button_pressed():
	get_tree().change_scene("res://Startingscreen.tscn")
	pass # replace with function body
