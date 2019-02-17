extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const TETHER_SCENE = preload("res://ropeTest.tscn")

var camera

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = $Camera2D
	camera.make_current()
	
	var child = TETHER_SCENE.instance()
	child.position.x = position.x - 1050
	child.position.y = position.y + 850
	self.add_child(child)
	
func _physics_process(delta):
	var force = Vector2()
	var torque = 0
	
	if Input.is_action_pressed('ui_up'):
		force = Vector2(100,0)
		force = force.rotated(rotation)
	if Input.is_action_pressed('ui_down'):
		force = Vector2(-100,0)
		force = force.rotated(rotation)
	if Input.is_action_pressed('ui_left'):
		torque -= 100
	if Input.is_action_pressed('ui_right'):
		torque += 100

#	applied_torque = torque
#	applied_force = force
	apply_impulse(Vector2(0,0),force)
	
	apply_impulse(Vector2(100,0),Vector2(0,torque))
	apply_impulse(Vector2(-100,0),Vector2(0,-torque))
	
#func _integrate_forces(state):
#	print(state)	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
