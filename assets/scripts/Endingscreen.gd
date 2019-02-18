extends CanvasLayer

signal end_game

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Button_pressed():
	$EndButton/button_click.play()
	get_tree().change_scene("res://Startingscreen.tscn")
	pass # replace with function body
