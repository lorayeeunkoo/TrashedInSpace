extends Node
export (PackedScene) var Trash

func _ready():
	randomize()
	$TrashTimer.start()

func _on_TrashTimer_timeout():
	$TrashPath/TrashSpawnLocation.set_offset(randi())
	var trash = Trash.instance()
	add_child(trash)
	var direction = $TrashPath/TrashSpawnLocation.rotation + PI/2
	trash.position = $TrashPath/TrashSpawnLocation.position
	trash.rotation = direction
	trash.set_linear_velocity(Vector2(rand_range(trash.MIN_SPEED, trash.MAX_SPEED), 0).rotated(direction))
	$TrashTimer.start()

	
	
