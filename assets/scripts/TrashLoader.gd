extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var small_ship

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if Input.is_action_pressed('ui_accept'):
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == 'small_ship':
				small_ship = $"../".smallShip
				var trashes = small_ship.get_node('MagnetForce').get_overlapping_bodies()
				var interior = $"../".get_node('ViewportContainer/Viewport/interior')
				var trashPosition = interior.get_node('TrashPosition2D').position
				for trash in trashes:
					if trash.is_in_group('enemy'):
						var newTrash = trash.duplicate()
						trash.queue_free()
						newTrash.remove_from_group('enemy')
						newTrash.position = trashPosition
						newTrash.gravity_scale = 1
						interior.add_child(newTrash)
					