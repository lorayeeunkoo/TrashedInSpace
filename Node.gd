extends Node

export (PackedScene) var Trash
var score

func _ready():
	pass
	
func new_game():
	score = 0
	$HUD.update_score(score)
	
func game_over():
	$HUD.show_game_over()


func update_score(score):
    $ScoreLabel.text = str(score)
	

#func _on_ScoreTimer_timeout():
#	score += 1
#	$HUD.update_score(score)
	
