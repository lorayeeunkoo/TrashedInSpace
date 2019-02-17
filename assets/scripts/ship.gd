extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const TETHER_SCENE = preload("res://ropeTest.tscn")

var camera
var tether
var smallShip

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = $Camera2D
	camera.make_current()
	
	tether = TETHER_SCENE.instance()
	tether.position.x = position.x - 150
	tether.position.y = position.y + 800
	self.add_child(tether)
	smallShip = getRootChild(30, tether.get_child(1))
#
func getRootChild(n, root):
	var child = root.get_child(1)
	if n > 0:
		return getRootChild(n - 1, child)
	else:
		return child

func _physics_process(delta):
	var force = Vector2()
	var torque = 0
	
	if Input.is_action_pressed('ui_up'):
		force = Vector2(10,0)
		force = force.rotated(rotation)
	if Input.is_action_pressed('ui_down'):
		force = Vector2(-10,0)
		force = force.rotated(rotation)
	if Input.is_action_pressed('ui_left'):
		torque -= 100
	if Input.is_action_pressed('ui_right'):
		torque += 100

#	applied_torque = torque
#	applied_force = force
	apply_impulse(Vector2(0,0),force)
	
	apply_impulse(Vector2(10,0),Vector2(0,torque))
	apply_impulse(Vector2(-10,0),Vector2(0,-torque))
	
func reMap(value, maxInput, minInput, maxOutput, minOutput):
	value = maxInput if value > maxInput else value
	value = minInput if value < minInput else value

	var inputSpan = maxInput - minInput
	var outputSpan = maxOutput - minOutput

	var scaledThrust = float(value - minInput) / float(inputSpan)

	return minOutput + (scaledThrust * outputSpan)	

func _process(delta):
	var camX = 5
	var camY = 5
	var delta_position = global_position - smallShip.global_position
	var mag = delta_position.length()
	var mapped = reMap(mag, 5000, 1000, 25, 7)
	print(mapped)
	var camZoom = Vector2(mapped, mapped)
	camera.zoom = camZoom
	

