extends KinematicBody2D

const LINK_SCENE = preload("res://link.tscn")
const SMALL_SHIP_SCENE = preload("res://small_ship.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var last_link
var small_ship
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var parent = self
	for i in range(40):
		var child = LINK_SCENE.instance()
		child.position.x = position.x + 1*15
		child.position.y = position.y
		parent.add_child(child)
		
		var link = PinJoint2D.new()
		parent.add_child(link)
		link.node_a = parent.get_path()
		link.node_b = child.get_path()
		
		parent = child
	
	last_link = parent
	small_ship = SMALL_SHIP_SCENE.instance()
	last_link.add_child(small_ship);
	
	var link = PinJoint2D.new()
	last_link.add_child(link)
	link.node_a = last_link.get_path()
	link.node_b = small_ship.get_path()
	
func _physics_process(delta):
	var force = Vector2()
	var torque = 0
	
	if Input.is_action_pressed('ui_up'):
		force = Vector2(0,-40)
#		force = force.rotated(small_ship.rot)
	if Input.is_action_pressed('ui_down'):
		force = Vector2(0,40)
#		force = force.rotated(small_ship.rot)
	if Input.is_action_pressed('ui_left'):
		torque -= 5
	if Input.is_action_pressed('ui_right'):
		torque += 5
	print(small_ship.rotation)

#	applied_torque = torque
#	applied_force = force
	last_link.apply_impulse(Vector2(0,0),force)
	
	last_link.apply_impulse(Vector2(20,0),Vector2(0,torque))
	last_link.apply_impulse(Vector2(-20,0),Vector2(0,-torque))
	

