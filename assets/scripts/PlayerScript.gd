extends KinematicBody2D

const UP = Vector2(0,-1)
var motion = Vector2()
var player = 0
var hide = false
var lock = false
var cannon = false
var top
var mid
var bot

var ship
var smallShip

func _ready():
	top = $"../ElevatorSpot3"
	mid = $"../ElevatorSpot2"
	bot = $"../ElevatorSpot1"
	ship = $"../../../../../ship"
	pass

func _physics_process(delta):
	if(!hide):
		if !lock:
			motion.y += 10
			if Input.is_action_pressed("key_right"):
				motion.x += 100
				motion.x = min(motion.x,400)
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = false
			elif Input.is_action_pressed("key_left"):
				motion.x -= 100
				motion.x = max(motion.x,-400)
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = true
			elif motion.x * motion.x < .50:
				motion.x *= .65
				
			else:
				motion.x = 0
				$AnimatedSprite.play("idle")
		
		if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("key_up"):
			if($RayCast2D.is_colliding()):
#				if $RayCast2D.get_collider().name == "garbage":
#					dosmth
				if $RayCast2D.get_collider().name == "ElevatorArea3":
					position = bot.position
				if $RayCast2D.get_collider().name == "ElevatorArea2":
					position = top.position
				if $RayCast2D.get_collider().name == "ElevatorArea1":
					position = mid.position
				if $RayCast2D.get_collider().name == "FuelArea":
#					fuel? += carry
#					carry = 0
					pass
				if $RayCast2D.get_collider().name == "DockArea":
					if ship.playerSmall == -1:
						ship.playerSmall = player
						$AnimatedSprite.play("idle")
						hide = true
						lock = true
				if $RayCast2D.get_collider().name == "CannonArea":
					if ship.playerCannon == -1:
						ship.playerCannon = player
						$AnimatedSprite.play("idle")
						lock = true
						cannon = true
				if $RayCast2D.get_collider().name == "DriveArea":
					if ship.player == -1:
						ship.player = player
						$AnimatedSprite.play("idle")
						lock = true
					pass
		
		
#		if is_on_floor():
#			if(Input.is_action_just_pressed("ui_focus_next")):
#				motion.y = -400
		motion = move_and_slide(motion, UP)
	pass
