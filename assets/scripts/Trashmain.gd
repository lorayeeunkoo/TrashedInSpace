extends Node
export (PackedScene) var Trash
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$TrashTimer.start()

func game_over():
	$TrashTimer.stop()
	$HUD.show_game_over()


func _on_TrashTimer_timeout():
	$TrashPath/TrashSpawnLocation.set_offset(randi())
	var trash = Trash.instance()
	add_child(trash)
	var direction = $TrashPath/TrashSpawnLocation.rotation + PI/2
	trash.position = $TrashPath/TrashSpawnLocation.position
	trash.rotation = direction
	trash.set_linear_velocity(Vector2(rand_range(trash.MIN_SPEED, trash.MAX_SPEED), 0).rotated(direction))
	$TrashTimer.start()

func update_score(score):
    $ScoreLabel.text = str(score)
# no score timer
#func _on_ScoreTimer_timeout():
#	score += 1
#	$HUD.update_score(score)
	
