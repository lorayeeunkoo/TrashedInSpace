extends Node
export (PackedScene) var Trash
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()
	
func new_game():
	$TrashTimer.start()
	
func game_over():
    $TrashTimer.stop()


func _on_TrashTimer_timeout():
	# choose a random location on the Path2D
	$TrashPath/TrashSpawnLocation.set_offset(randi())
	var trash = Trash.instance()
	add_child(trash)
	var direction = $TrashPath/TrashSpawnLocation.rotation + PI/2
	trash.position = $TrashPath/TrashSpawnLocation.position
	# add some randomness to the direction
	#direction += rand_range(-PI/4, PI/4)
	trash.rotation = direction
	trash.set_linear_velocity(Vector2(rand_range(trash.MIN_SPEED, trash.MAX_SPEED), 0).rotated(direction))
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
