extends KinematicBody2D

const LINK_SCENE = preload("res://link.tscn")
const SMALL_SHIP_SCENE = preload("res://small_ship.tscn")

const DUMMY_GARBAGE_SCENE = preload("res://dummyGarbage.tscn")
var numTrash = 10

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var last_link
var small_ship
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	#Initialize/Create the rigidbody objects to be dummy trash
	var parent = self
	
	for i in range (numTrash):
		#Set each garbage in different locations each time
		var garbage = DUMMY_GARBAGE_SCENE.instance()
		garbage.position.x = position.x + i * 40
		garbage.position.y = position.y
		parent.add_child(garbage)
		
#	var parent = self
	for i in range(30):
		var child = LINK_SCENE.instance()
		child.position.x = position.x
		child.position.y = position.y + 200
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
		force = Vector2(0,-180)
		force = force.rotated(small_ship.global_rotation)
	if Input.is_action_pressed('ui_down'):
		force = Vector2(0,180)
		force = force.rotated(small_ship.global_rotation)
	if Input.is_action_pressed('ui_left'):
		torque -= 5
	if Input.is_action_pressed('ui_right'):
		torque += 5

#	applied_torque = torque
#	applied_force = force
	small_ship.apply_impulse(Vector2(0,0),force)
	
	small_ship.apply_impulse(Vector2(4,0),Vector2(0,torque))
	small_ship.apply_impulse(Vector2(-4,0),Vector2(0,-torque))
	

