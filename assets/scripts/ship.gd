extends RigidBody2D

const TETHER_SCENE = preload("res://ropeTest.tscn")

var camera
var tether
var smallShip
var player
var playerSmall
var playerCannon

var fuel

func _ready():
	fuel = 10000000
	# Called when the node is added to the scene for the first time.
	# Initialization here
	camera = $Camera2D
	camera.make_current()
	camera.offset_v = 60
	
	var tetherLoc = $LinkPortLoc.position
	
	tether = TETHER_SCENE.instance()
	tether.global_position.x = tetherLoc.x
	tether.global_position.y = tetherLoc.y
	add_child(tether)
	smallShip = tether.get_child(0).small_ship
	
	apply_impulse(Vector2(0,0),Vector2(1000,0))
	player = -1 # make player = none
	playerSmall = -1
	playerCannon = -1
	add_to_group("Ship")
	$music.play()
#func getRootChild(n, root):
#	if n > 0:
#		return getRootChild(n - 1, child)
#	else:
#		return child
#
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
				torque -= 5
				fuel -= 0.1
			if Input.is_action_pressed('ui_right'):
				torque += 5
				fuel -= 0.1
		elif(player==2):
			if Input.is_action_pressed('up'):
				force = Vector2(500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('down'):
				force = Vector2(-500,0)
				force = force.rotated(rotation)
				fuel -= 0.1
			if Input.is_action_pressed('left'):
				torque -= 5
				fuel -= 0.1
			if Input.is_action_pressed('right'):
				torque += 5
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
	var mapped = reMap(mag, 5000, 1000, 10, 2)
	var camZoom = Vector2(mapped, mapped)
	if playerSmall != -1:
		camera.zoom = camZoom
	var delta_y = global_position.y - smallShip.global_position.y
	var mapped_y = reMap(delta_y, 6000, 0, 15, 5)
	if mapped_y < 10.5:
		if camera.offset_v >= 60 - mapped_y - 40:
			camera.offset_v -= 3
	else:
		if (camera.offset_v <= 60):
			camera.offset_v += 3


func _on_ship_body_entered(body):
	fuel-=1
	print("fuel deducted")

	
