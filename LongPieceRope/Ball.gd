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