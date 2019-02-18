extends RigidBody2D

const TETHER_SCENE = preload("res://ropeTest.tscn")
const SPACE_STATION_SCENE = preload("res://space_station.tscn")

var camera
var tether
var smallShip
var spaceStation

var spaceStationCount
var compass
var distance

var endPointX
var endPointY

var compassPoint

var player
var playerSmall

var fuel

func _ready():
	fuel = 100
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = $Camera2D
	camera.make_current()
	camera.offset_v = 60
	
	tether = TETHER_SCENE.instance()
	tether.position.x = position.x - 150
	tether.position.y = position.y + 800
	add_child(tether)
	smallShip = tether.get_child(0).small_ship
	
	apply_impulse(Vector2(0,0),Vector2(1000,0))
	player = -1 # make player = none
	playerSmall = -1
	add_to_group("Ship")
	$music.play()
#func getRootChild(n, root):
#	if n > 0:
#		return getRootChild(n - 1, child)
#	else:
#		return child
#
	spaceStationCount = 0
	spaceStation = SPACE_STATION_SCENE.instance()
	randomize()
	
	var randFloatDis = randf() * 11 - 1
	var randFloatX = randomizeX(randFloatDis)
	var randFloatY = randomizeY(randFloatDis)
	
	compass = Vector2(randFloatX, randFloatY).normalized()
	distance = getDistance(randFloatDis)
	compass = compass * distance
#
	spaceStation.position.x = position.x + (randFloatX * compass.x)
	endPointX = spaceStation.position.x
	spaceStation.position.y = position.y + (randFloatY * compass.y)
	endPointY = spaceStation.position.y
	self.add_child(spaceStation)
	spaceStation.show()
	
	compassPoint = $pointRigidBody
	compassPoint.global_rotation = (spaceStation.global_position - global_position).angle()
	
func randomizeX(randN):
	var N = randN * (17 + spaceStationCount)
	if (int(N) % 2 == 0):
		N = N * -1
	return N
	
func randomizeY(randN):
	var N = randN * (13 + spaceStationCount)
	if (int(N) % 2 == 0):
		N = N * -1
	return N

func getDistance(randN):
	var N = randN
	var initialMult = 1.5
#	for i in spaceStationCount:
#		initialMult = initialMult * 1.5
	return N * initialMult
	
func _physics_process(delta):
	var force = Vector2()
	var torque = 0
	if fuel >= 0.1:
		if(player==0):
			if Input.is_action_pressed('key_up'):
				force = Vector2(500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('key_down'):
				force = Vector2(-500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('key_left'):
				torque -= 5000
				fuel -= 0.1
			if Input.is_action_pressed('key_right'):
				torque += 5000
				fuel -= 0.1
		elif(player==1):
			if Input.is_action_pressed('ui_up'):
				force = Vector2(500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('ui_down'):
				force = Vector2(-500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('ui_left'):
				torque -= 5000
				fuel -= 0.1
			if Input.is_action_pressed('ui_right'):
				torque += 5000
				fuel -= 0.1

	
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
	if fuel <= 0:
		get_tree().change_scene("res://Endingscreen.tscn")
		print("game should end")
	var camX = 5
	var camY = 5
	var delta_position = global_position - smallShip.global_position
	var mag = delta_position.length()
	var mapped = reMap(mag, 5000, 1000, 15, 5)
	var camZoom = Vector2(mapped, mapped)
	camera.zoom = camZoom
	
	var delta_y = global_position.y - smallShip.global_position.y
	var mapped_y = reMap(delta_y, 6000, 0, 15, 5)
	if mapped_y < 10.5:
		if camera.offset_v >= 60 - mapped_y - 40:
			camera.offset_v -= 3
	else:
		if (camera.offset_v <= 60):
			camera.offset_v += 3
	
	compassPoint.global_rotation = (spaceStation.global_position - global_position).angle()
	
func spaceStationEntered():
	spaceStationExited()

func spaceStationExited():
	spaceStation.queue_free()
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
	var newStation = SPACE_STATION_SCENE.instance()
	newStation.position.x = position.x + (newRandFloatX * compass.x)
	endPointX = newStation.position.x
	newStation.position.y = position.y + (newRandFloatY * compass.y)
	endPointY = newStation.position.y
	spaceStation = newStation
	self.add_child(spaceStation)
	spaceStation.show()
	compassPoint.global_rotation = (spaceStation.global_position - global_position).angle()


func _on_ship_body_entered(body):
	fuel-=1
	print("fuel deducted")


	
