extends KinematicBody2D


func _ready():

	pass

func _process(delta):
	var speed_x = 1;
	var speed_y = 0;
	var motion = (Vector2(speed_x, speed_y) * LASER_SPEED).rotated(rotation);
	translate(motion * delta)
	



