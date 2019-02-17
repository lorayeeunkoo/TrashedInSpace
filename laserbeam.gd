extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const LASER_SPEED = 500;


func _ready():

	pass

func _process(delta):
	var speed_x = 1;
	var speed_y = 0;
	var motion = (Vector2(speed_x, speed_y) * LASER_SPEED).rotated(rotation);
	translate(motion * delta)

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
	pass # replace with function body
