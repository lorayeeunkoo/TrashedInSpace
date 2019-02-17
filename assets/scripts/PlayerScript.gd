extends KinematicBody2D

const UP = Vector2(0,-1)
var motion = Vector2()

var top
var mid
var bot

func _ready():
	top = $"../ElevatorSpot3"
	mid = $"../ElevatorSpot2"
	bot = $"../ElevatorSpot1"
	ship = $"../../../../../ship"
	smallShip = ship.smallShip
	pass

func _physics_process(delta):
	motion.y += 10
	if Input.is_action_pressed("ui_page_down"):
		motion.x += 60
		motion.x = min(motion.x,400)
	elif Input.is_action_pressed("ui_page_up"):
		motion.x -= 60
		motion.x = max(motion.x,-400)
	elif motion.x * motion.x < .50:
		motion.x *= .8
	else:
		motion.x = 0
		
	if Input.is_action_just_pressed("ui_accept"):
		if($RayCast2D.is_colliding()):
			if $RayCast2D.get_collider().name == "ElevatorArea3":
				position = bot.position
				pass
			if $RayCast2D.get_collider().name == "ElevatorArea2":
				position = top.position
				pass
			if $RayCast2D.get_collider().name == "ElevatorArea1":
				position = mid.position
				pass
			if $RayCast2D.get_collider().name == "FuelArea":
				position = mid.position
				pass
			if $RayCast2D.get_collider().name == "DockArea":
				position = mid.position
				pass
			if $RayCast2D.get_collider().name == "CannonArea":
				position = mid.position
				pass
			if $RayCast2D.get_collider().name == "DriveArea":
				position = mid.position
				pass

	
	if is_on_floor():
		if(Input.is_action_just_pressed("ui_focus_next")):
			motion.y = -400
	motion = move_and_slide(motion, UP)
	pass
