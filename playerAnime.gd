extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const GRAVITY = 20
const SPEED = 60

var velocity = Vector2()

func _ready():
	"res://root.tscn"# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$GarbageMan.set_flip_h(false)
		$GarbageMan.play("walking")
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$GarbageMan.set_flip_h(true)
		$GarbageMan.play("walking")
	else:
		velocity.x = 0
		
		
	velocity = move_and_slide(velocity)
