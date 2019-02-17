extends RigidBody2D

var camera
var count

func _ready():
	add_to_group("Ship")
	camera = $Camera2D
	camera.make_current()
	hide()

func start(pos):
	position=pos
	show()
	$Collision.disabled = false
	
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



func _on_ship_body_entered(body):
	count+=1
	print(count)

#need end game stuff
