extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var camera

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = $Camera2D
	camera.make_current()
	
func _physics_process(delta):
	if Input.is_action_pressed('ui_left'):
		var force = Vector2(1,0)
#		var offset = self.position
#		offset.x += 1
		self.apply_impulse(Vector2(0,0), force)
		
#
#func _integrate_forces(state):
#	print(state)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
