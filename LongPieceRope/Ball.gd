extends RigidBody2D

var thrust = Vector2(0, 1000)
var torque = 20000

func _integrate_forces(state):
    if Input.is_action_pressed("ui_up"): 
	    set_applied_force(thrust.rotated(rotation- PI))
    elif Input.is_action_pressed("ui_down"): 
	    set_applied_force(thrust.rotated(rotation))
    elif Input.is_action_pressed("ui_right"):
	    set_applied_force(thrust.rotated(rotation - PI/2))
    elif Input.is_action_pressed("ui_left"):
	    set_applied_force(thrust.rotated(rotation - 3*PI/2))
    else:
        set_applied_force(Vector2())
    """
	var rotation_dir = 0
    if Input.is_action_pressed("ui_right"):
        rotation_dir += 0.1
    if Input.is_action_pressed("ui_left"):
        rotation_dir -= 0.1
    set_applied_torque(rotation_dir * torque)
	"""
	
"""
extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var over = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and over:
		var mousePos = get_viewport().get_mouse_position()
		position += mousePos - global_position

func _on_Control_mouse_entered():
	over = true
	modulate = Color(0x0000ffff)


func _on_Control_mouse_exited():
	over = false
	modulate = Color(0xffffffff)
"""