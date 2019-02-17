extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const TETHER_SCENE = preload("res://ropeTest.tscn")
const SPACE_STATION_SCENE = preload("res://space_station.tscn")

var camera
var tether
var smallShip
var spaceStation

var spaceStationCount
var compass
var distance

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
	
	spaceStationCount = 0
	spaceStation = SPACE_STATION_SCENE.instance()
	randomize()
	
	var randFloatX = randf()*(11+spaceStationCount)+1
	var randFloatY = randf()*(13+spaceStationCount)+1
	
	if int(randFloatX) % 2 == 0:
		randFloatX = randFloatX * -1
	if int(randFloatY) % 2 == 0:
		randFloatY = randFloatY * -1
	
	compass = Vector2(randFloatX, randFloatY).normalized()
	var randFloatDis = randf() * 11 - 1
	distance = getDistance(randFloatDis)
	compass = compass * distance
	
	spaceStation.position.x = position.x + (randFloatX * compass.x)
	spaceStation.position.y = position.y + (randFloatY * compass.y)
	self.add_child(spaceStation)

func getDistance(randN):
	var N = randN * randN * randN
	var initialMult = 500
	for i in spaceStationCount:
		initialMult = initialMult * 2
	return N * initialMult
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
	
#	distance = destPos - delta_position
	
#	if distance.length() <= 500:
	if (abs(spaceStation.position.x - delta_position.x) <= 1500 && abs(spaceStation.position.y - delta_position.y) <= 1500):
		spaceStationCount = spaceStationCount + 1
		var newRandFloatX = randf()*(11+spaceStationCount)+1
		var newRandFloatY = randf()*(13+spaceStationCount)+1
		if int(newRandFloatX) % 2 == 0:
			newRandFloatX = newRandFloatX * -1
		if int(newRandFloatY) % 2 == 0:
			newRandFloatY = newRandFloatY * -1
		compass = Vector2(newRandFloatX, newRandFloatY).normalized()
		var newRandFloatDis = randf() * 11 - 1
		distance = getDistance(newRandFloatDis)
		compass = compass * distance
		spaceStation.position.x = delta_position.x + (newRandFloatX * compass.x)
		spaceStation.position.y = delta_position.y + (newRandFloatY * compass.y)
		self.add_child(spaceStation)
	

