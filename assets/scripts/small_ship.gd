extends RigidBody2D
var area

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	area = $"MagnetForce"
	area.hide()


func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(Input.is_action_pressed('ui_accept')):
		area.show()
		#get rigidbody within collisionshape
#		var garbagesInBounds = area.get_overlapping_bodies()
#		#get  vectors to rigidbodies
#		for garbage in garbagesInBounds:
#			var force = Vector2(garbage.position.x - position.x, garbage.position.y - position.y)
#			garbage.apply_impulse(Vector2(0,0), force)
			
		#tow the rigidbodies over
	else:
		area.hide()
#
#func magnetize():
#	while(Input.is_action_pressed('ui_accept')):
#		#get rigidbody within collisionshape
#		var garbagesInBounds = area.get_overlapping_bodies()
#		#get  vectors to rigidbodies
#		for garbage in garbagesInBounds:
#			var force = Vector2(garbage.position.x - position.x, garbage.position.y - position.y)
#			garbage.apply_impulse(Vector2(0,0), force)
#
#		#tow the rigidbodies over
#
	